-- ============================================================================
-- SOFTWARE MANAGEMENT SYSTEM (DBMS PROJECT)
-- Database Engine: MySQL 8.0+
-- Script: Full Schema DDL, Constraints, Triggers, Stored Procedures, Views & Data
-- ============================================================================

CREATE DATABASE IF NOT EXISTS SoftwareManagementDB;
USE SoftwareManagementDB;

-- Disable Foreign Key Checks for clean table cleanup if re-running
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS audit_logs;
DROP TABLE IF EXISTS bug_reports;
DROP TABLE IF EXISTS deployments;
DROP TABLE IF EXISTS licenses;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS developers;
DROP TABLE IF EXISTS versions;
DROP TABLE IF EXISTS softwares;
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================================
-- 1. TABLES DEFINITION (3NF / BCNF RELATIONAL STRUCTURE)
-- ============================================================================

-- Table 1: Softwares Catalog
CREATE TABLE softwares (
software_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL UNIQUE,
category ENUM('Desktop', 'Web App', 'Mobile App', 'Cloud Service', 'Enterprise ERP', 'Developer Tool') NOT NULL,
description TEXT,
license_type ENUM('Proprietary', 'Open Source', 'SaaS Subscription', 'Perpetual') NOT NULL DEFAULT 'Proprietary',
repository_url VARCHAR(255),
status ENUM('Active', 'In Development', 'Maintenance', 'Deprecated', 'End of Life') NOT NULL DEFAULT 'In Development',
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table 2: Software Versions / Releases
CREATE TABLE versions (
version_id INT AUTO_INCREMENT PRIMARY KEY,
software_id INT NOT NULL,
version_number VARCHAR(20) NOT NULL,
release_date DATE NOT NULL,
release_notes TEXT,
download_url VARCHAR(255),
status ENUM('Stable', 'Beta', 'Alpha', 'Archived') NOT NULL DEFAULT 'Beta',
CONSTRAINT fk_versions_software FOREIGN KEY (software_id)
REFERENCES softwares(software_id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT uq_software_version UNIQUE (software_id, version_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table 3: Developers Team
CREATE TABLE developers (
developer_id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
role ENUM('Lead Architect', 'Frontend Developer', 'Backend Developer', 'DevOps Engineer', 'QA Tester') NOT NULL,
assigned_software_id INT NULL,
hire_date DATE NOT NULL,
CONSTRAINT fk_dev_software FOREIGN KEY (assigned_software_id)
REFERENCES softwares(software_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table 4: Clients / Customer Organizations
CREATE TABLE clients (
client_id INT AUTO_INCREMENT PRIMARY KEY,
company_name VARCHAR(120) NOT NULL UNIQUE,
contact_email VARCHAR(100) NOT NULL,
tier ENUM('Enterprise', 'Professional', 'Standard', 'Trial') NOT NULL DEFAULT 'Standard',
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table 5: Licenses & Seat Allocations
CREATE TABLE licenses (
license_id INT AUTO_INCREMENT PRIMARY KEY,
software_id INT NOT NULL,
client_id INT NOT NULL,
license_key VARCHAR(64) NOT NULL UNIQUE,
max_seats INT NOT NULL DEFAULT 10,
used_seats INT NOT NULL DEFAULT 0,
issued_date DATE NOT NULL,
expiry_date DATE NOT NULL,
status ENUM('Active', 'Expired', 'Revoked', 'Pending') NOT NULL DEFAULT 'Active',
CONSTRAINT fk_license_software FOREIGN KEY (software_id)
REFERENCES softwares(software_id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_license_client FOREIGN KEY (client_id)
REFERENCES clients(client_id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT chk_seat_capacity CHECK (used_seats <= max_seats)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table 6: Deployments & Environments
CREATE TABLE deployments (
deployment_id INT AUTO_INCREMENT PRIMARY KEY,
software_id INT NOT NULL,
version_id INT NOT NULL,
environment ENUM('Production', 'Staging', 'QA / Testing', 'Development') NOT NULL,
deployed_by INT NOT NULL,
deployment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
health_status ENUM('Healthy', 'Degraded', 'Critical', 'Offline') NOT NULL DEFAULT 'Healthy',
CONSTRAINT fk_deploy_software FOREIGN KEY (software_id)
REFERENCES softwares(software_id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_deploy_version FOREIGN KEY (version_id)
REFERENCES versions(version_id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_deploy_dev FOREIGN KEY (deployed_by)
REFERENCES developers(developer_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table 7: Bug & Issue Tracking
CREATE TABLE bug_reports (
bug_id INT AUTO_INCREMENT PRIMARY KEY,
software_id INT NOT NULL,
version_id INT NULL,
title VARCHAR(150) NOT NULL,
severity ENUM('Critical', 'High', 'Medium', 'Low') NOT NULL DEFAULT 'Medium',
reported_by_client INT NULL,
assigned_developer INT NULL,
status ENUM('Open', 'In Progress', 'Resolved', 'Closed') NOT NULL DEFAULT 'Open',
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_bug_software FOREIGN KEY (software_id)
REFERENCES softwares(software_id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_bug_version FOREIGN KEY (version_id)
REFERENCES versions(version_id) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_bug_client FOREIGN KEY (reported_by_client)
REFERENCES clients(client_id) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_bug_dev FOREIGN KEY (assigned_developer)
REFERENCES developers(developer_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table 8: Audit Logs
CREATE TABLE audit_logs (
log_id INT AUTO_INCREMENT PRIMARY KEY,
action VARCHAR(50) NOT NULL,
entity_type VARCHAR(50) NOT NULL,
entity_id INT NOT NULL,
performed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
details TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================================
-- 2. DATABASE INDEXES FOR OPTIMIZED QUERY PERFORMANCE
-- ============================================================================

CREATE INDEX idx_softwares_status ON softwares(status);
CREATE INDEX idx_versions_software ON versions(software_id, status);
CREATE INDEX idx_licenses_client ON licenses(client_id, status);
CREATE INDEX idx_deployments_env ON deployments(environment, health_status);
CREATE INDEX idx_bugs_status_severity ON bug_reports(status, severity);

-- ============================================================================
-- 3. VIEWS FOR ANALYTICS AND DASHBOARD REPORTING
-- ============================================================================

-- View 1: Active Production Deployments
CREATE OR REPLACE VIEW vw_active_deployments AS
SELECT
d.deployment_id,
s.name AS software_name,
v.version_number,
d.environment,
dev.full_name AS deployed_by_dev,
d.deployment_date,
d.health_status
FROM deployments d
JOIN softwares s ON d.software_id = s.software_id
JOIN versions v ON d.version_id = v.version_id
JOIN developers dev ON d.deployed_by = dev.developer_id
WHERE d.environment = 'Production';

-- View 2: License Compliance & Seat Usage
CREATE OR REPLACE VIEW vw_license_compliance AS
SELECT
l.license_id,
c.company_name AS client_name,
s.name AS software_name,
l.license_key,
l.max_seats,
l.used_seats,
(l.max_seats - l.used_seats) AS available_seats,
l.expiry_date,
DATEDIFF(l.expiry_date, CURDATE()) AS days_until_expiration,
l.status
FROM licenses l
JOIN clients c ON l.client_id = c.client_id
JOIN softwares s ON l.software_id = s.software_id;

-- View 3: Open Bug Metrics per Software
CREATE OR REPLACE VIEW vw_open_bugs_summary AS
SELECT
s.software_id,
s.name AS software_name,
COUNT(b.bug_id) AS total_open_bugs,
SUM(CASE WHEN b.severity = 'Critical' THEN 1 ELSE 0 END) AS critical_bugs,
SUM(CASE WHEN b.severity = 'High' THEN 1 ELSE 0 END) AS high_bugs
FROM softwares s
LEFT JOIN bug_reports b ON s.software_id = b.software_id AND b.status IN ('Open', 'In Progress')
GROUP BY s.software_id, s.name;

-- ============================================================================
-- 4. TRIGGERS FOR AUDITING AND CONSTRAINTS
-- ============================================================================

DELIMITER //

-- Trigger: Audit License Creation
CREATE TRIGGER trg_audit_license_created
AFTER INSERT ON licenses
FOR EACH ROW
BEGIN
INSERT INTO audit_logs (action, entity_type, entity_id, details)
VALUES (
'INSERT',
'License',
NEW.license_id,
CONCAT('Issued license key ', NEW.license_key, ' to client ID ', NEW.client_id, ' with ', NEW.max_seats, ' seats.')
);
END //

-- Trigger: Audit Deployment Execution
CREATE TRIGGER trg_audit_deployment_created
AFTER INSERT ON deployments
FOR EACH ROW
BEGIN
INSERT INTO audit_logs (action, entity_type, entity_id, details)
VALUES (
'INSERT',
'Deployment',
NEW.deployment_id,
CONCAT('Deployed environment ', NEW.environment, ' with health ', NEW.health_status)
);
END //

DELIMITER ;

-- ============================================================================
-- 5. STORED PROCEDURES FOR BUSINESS LOGIC
-- ============================================================================

DELIMITER //

-- Procedure 1: Issue New License Key
CREATE PROCEDURE sp_issue_license(
IN p_software_id INT,
IN p_client_id INT,
IN p_seats INT,
IN p_validity_days INT,
OUT p_generated_key VARCHAR(64)
)
BEGIN
DECLARE v_new_key VARCHAR(64);
SET v_new_key = UPPER(CONCAT(
HEX(RANDOM_BYTES(4)), '-',
HEX(RANDOM_BYTES(4)), '-',
HEX(RANDOM_BYTES(4)), '-',
HEX(RANDOM_BYTES(4))
));

INSERT INTO licenses (software_id, client_id, license_key, max_seats, used_seats, issued_date, expiry_date, status)  
VALUES (  
    p_software_id,  
    p_client_id,  
    v_new_key,  
    p_seats,  
    0,  
    CURDATE(),  
    DATE_ADD(CURDATE(), INTERVAL p_validity_days DAY),  
    'Active'  
);  
  
SET p_generated_key = v_new_key;

END //

-- Procedure 2: Log Software Deployment
CREATE PROCEDURE sp_deploy_version(
IN p_software_id INT,
IN p_version_id INT,
IN p_environment VARCHAR(30),
IN p_developer_id INT,
IN p_health VARCHAR(20)
)
BEGIN
INSERT INTO deployments (software_id, version_id, environment, deployed_by, health_status)
VALUES (p_software_id, p_version_id, p_environment, p_developer_id, p_health);
END //

DELIMITER ;

-- ============================================================================
-- 6. SAMPLE SEED DATA INSERTION
-- ============================================================================

-- Seed Softwares
INSERT INTO softwares (software_id, name, category, description, license_type, repository_url, status) VALUES
(1, 'CloudScale ERP', 'Enterprise ERP', 'Comprehensive cloud enterprise resource planning suite', 'SaaS Subscription', 'https://github.com/enterprise/cloudscale-erp', 'Active'),
(2, 'DevStack IDE', 'Developer Tool', 'Lightweight multi-language code editor and debugger', 'Open Source', 'https://github.com/devstack/ide', 'Active'),
(3, 'Nexus Analytics', 'Web App', 'Real-time customer metrics and analytics dashboard', 'Proprietary', 'https://github.com/nexus/analytics', 'Active'),
(4, 'SecureGuard Mobile', 'Mobile App', 'Biometric mobile authentication and MFA client', 'Proprietary', 'https://github.com/secureguard/mobile', 'In Development'),
(5, 'DataStream ETL', 'Cloud Service', 'High throughput event streaming & data pipeline processor', 'Proprietary', 'https://github.com/datastream/etl', 'Active');

-- Seed Versions
INSERT INTO versions (version_id, software_id, version_number, release_date, release_notes, download_url, status) VALUES
(1, 1, 'v3.2.0', '2026-01-15', 'Added AI financial forecasting module and dark theme UI', 'https://downloads.cloudscale.com/v3.2.0.pkg', 'Stable'),
(2, 1, 'v3.3.0-rc1', '2026-03-01', 'Release candidate for integrated multi-currency billing', 'https://downloads.cloudscale.com/v3.3.0-rc1.pkg', 'Beta'),
(3, 2, 'v1.8.4', '2025-11-20', 'Performance patch for LSP autocomplete latency', 'https://github.com/devstack/ide/releases/v1.8.4', 'Stable'),
(4, 3, 'v2.1.0', '2026-02-10', 'Introduced custom webhooks and Slack notifications', 'https://nexus.io/download/v2.1.0', 'Stable'),
(5, 4, 'v0.9.0', '2026-04-05', 'Initial internal testing build with Passkey support', 'https://internal.secureguard.com/v0.9.0.apk', 'Alpha');

-- Seed Developers
INSERT INTO developers (developer_id, full_name, email, role, assigned_software_id, hire_date) VALUES
(1, 'Sarah Jenkins', 's.jenkins@devtech.org', 'Lead Architect', 1, '2022-03-15'),
(2, 'Alex Rivera', 'a.rivera@devtech.org', 'Backend Developer', 1, '2023-06-01'),
(3, 'Marcus Vance', 'm.vance@devtech.org', 'Frontend Developer', 3, '2024-01-10'),
(4, 'Elena Rostova', 'e.rostova@devtech.org', 'DevOps Engineer', 5, '2021-11-01'),
(5, 'David Kim', 'd.kim@devtech.org', 'QA Tester', 2, '2024-08-15');

-- Seed Clients
INSERT INTO clients (client_id, company_name, contact_email, tier) VALUES
(1, 'Acme Global Corp', 'it-admin@acmeglobal.com', 'Enterprise'),
(2, 'Starlight Logistics', 'tech@starlight.io', 'Professional'),
(3, 'Vanguard Financials', 'sec@vanguardfin.com', 'Enterprise'),
(4, 'Apex Micro Systems', 'support@apexmicro.net', 'Standard');

-- Seed Licenses
INSERT INTO licenses (license_id, software_id, client_id, license_key, max_seats, used_seats, issued_date, expiry_date, status) VALUES
(1, 1, 1, 'ACM1-8F9D-3342-9901', 250, 185, '2026-01-01', '2027-01-01', 'Active'),
(2, 3, 2, 'STL8-11A0-77C4-4091', 50, 42, '2025-09-15', '2026-09-15', 'Active'),
(3, 1, 3, 'VNG9-66F2-00E1-8844', 500, 490, '2025-06-01', '2026-06-01', 'Active'),
(4, 5, 4, 'APX3-44B9-12E8-5502', 20, 20, '2024-03-10', '2025-03-10', 'Expired');

-- Seed Deployments
INSERT INTO deployments (deployment_id, software_id, version_id, environment, deployed_by, deployment_date, health_status) VALUES
(1, 1, 1, 'Production', 4, '2026-01-16 04:30:00', 'Healthy'),
(2, 3, 4, 'Production', 4, '2026-02-11 10:15:00', 'Healthy'),
(3, 1, 2, 'Staging', 2, '2026-03-02 14:00:00', 'Degraded'),
(4, 4, 5, 'QA / Testing', 5, '2026-04-06 09:00:00', 'Healthy');

-- Seed Bug Reports
INSERT INTO bug_reports (bug_id, software_id, version_id, title, severity, reported_by_client, assigned_developer, status) VALUES
(1, 1, 1, 'Memory leak during heavy PDF invoice generation export', 'High', 1, 2, 'In Progress'),
(2, 3, 4, 'Dashboard latency spike during peak UTC hours', 'Medium', 2, 3, 'Open'),
(3, 1, 2, 'Staging environment database connection pool exhaustion', 'Critical', 3, 4, 'In Progress'),
(4, 2, 3, 'Intermittent syntax highlighting crash on large TS files', 'Low', NULL, 5, 'Resolved');

-- ============================================================================
-- END OF SCRIPT
-- Verification Test Queries:
-- SELECT * FROM vw_active_deployments;
-- SELECT * FROM vw_license_compliance;
-- SELECT * FROM vw_open_bugs_summary;
-- ============================================================================