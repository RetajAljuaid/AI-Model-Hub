CREATE DATABASE IF NOT EXISTS ai_model_hub;
USE ai_model_hub;

CREATE TABLE Companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    founded_year YEAR,
    website VARCHAR(255)
);

CREATE TABLE Licenses (
    license_id INT AUTO_INCREMENT PRIMARY KEY,
    license_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);


CREATE TABLE Models (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    model_name VARCHAR(100) NOT NULL,
    company_id INT NOT NULL,
    release_date DATE,
    open_source BOOLEAN,
    context_window INT,
    description TEXT,
    license_id INT,
    
FOREIGN KEY (company_id)
    REFERENCES Companies(company_id),
FOREIGN KEY (license_id)
    REFERENCES Licenses(license_id)
);


CREATE TABLE Modalities (
    modality_id INT PRIMARY KEY AUTO_INCREMENT,
    modality_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Model_Modalities (
    model_id INT,
    modality_id INT,

    PRIMARY KEY (model_id, modality_id),

    FOREIGN KEY (model_id)
        REFERENCES Models(model_id),

    FOREIGN KEY (modality_id)
        REFERENCES Modalities(modality_id)
);

CREATE TABLE Benchmarks (
    benchmark_id INT PRIMARY KEY AUTO_INCREMENT,
    benchmark_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE Model_Benchmarks (
    model_id INT,
    benchmark_id INT,
    score DECIMAL(5,2),

    PRIMARY KEY (model_id, benchmark_id),
    FOREIGN KEY (model_id) REFERENCES Models(model_id),
    FOREIGN KEY (benchmark_id) REFERENCES Benchmarks(benchmark_id)
);



CREATE TABLE Pricing (
    pricing_id INT AUTO_INCREMENT PRIMARY KEY,
    model_id INT NOT NULL,
    input_price DECIMAL(10,4),
    output_price DECIMAL(10,4),
    currency VARCHAR(10) DEFAULT 'USD',
    FOREIGN KEY (model_id) REFERENCES Models(model_id)
);



INSERT INTO Companies (company_name, country, founded_year)
VALUES
('OpenAI', 'USA', 2015),
('Google', 'USA', 1998),
('Anthropic', 'USA', 2021),
('Meta', 'USA', 2004),
('Mistral AI', 'France', 2023),
('xAI', 'USA', 2023);


INSERT INTO Licenses (license_name, description)
VALUES
('Closed Source', 'Proprietary model'),
('Open Source', 'Source code and weights are publicly available');

INSERT INTO Modalities (modality_name)
VALUES
('Text'),
('Image'),
('Audio'),
('Video'),
('Code');

INSERT INTO Benchmarks (benchmark_name, description)
VALUES
('MMLU', 'Massive Multitask Language Understanding'),
('HumanEval', 'Code generation benchmark'),
('MATH', 'Mathematical reasoning benchmark'),
('GSM8K', 'Grade school math benchmark');


INSERT INTO Models
(model_name, company_id, release_date, open_source, context_window, license_id)
VALUES
('GPT-4o', 1, '2024-05-13', FALSE, 128000, 1),
('GPT-4.1', 1, '2025-04-14', FALSE, 1000000, 1),
('GPT-5', 1, '2025-08-07', FALSE, 1000000, 1),
('Gemini 2.5 Pro', 2, '2025-03-25', FALSE, 1000000, 1),
('Claude 4 Opus', 3, '2025-05-22', FALSE, 200000, 1),
('Llama 4 Maverick', 4, '2025-04-05', TRUE, 1000000, 2),
('Grok 4', 5, '2025-07-09', FALSE, 256000, 1),
('Mistral Large 2', 6, '2024-07-24', TRUE, 128000, 2);


INSERT INTO Model_Modalities (model_id, modality_id)
VALUES
-- GPT-4o
(1,1),(1,2),(1,3),
-- GPT-4.1
(2,1),(2,5),
-- GPT-5
(3,1),(3,2),(3,3),
-- Gemini 2.5 Pro
(4,1),(4,2),(4,5),
-- Claude 4 Opus
(5,1),(5,5),
-- Llama 4 Maverick
(6,1),
-- Grok 4
(7,1),(7,2),
-- Mistral Large 2
(8,1);


INSERT INTO Model_Benchmarks (model_id, benchmark_id, score)
VALUES
-- GPT-4o
(1,1,88.7),
(1,2,90.2),
(1,3,76.5),
(1,4,95.8),
-- GPT-4.1
(2,1,90.0),
(2,2,92.4),
(2,3,82.0),
(2,4,96.5),
-- GPT-5
(3,1,92.5),
(3,2,95.0),
(3,3,90.0),
(3,4,98.2),
-- Gemini 2.5 Pro
(4,1,91.8),
(4,2,91.0),
(4,3,88.3),
(4,4,97.5),
-- Claude 4 Opus
(5,1,91.2),
(5,2,93.5),
(5,3,89.0),
(5,4,97.0),
-- Llama 4 Maverick
(6,1,85.4),
(6,2,82.8),
(6,3,73.5),
(6,4,90.4),
-- Grok 4
(7,1,90.5),
(7,2,91.8),
(7,3,87.5),
(7,4,96.0),
-- Mistral Large 2
(8,1,84.7),
(8,2,81.3),
(8,3,72.0),
(8,4,89.8);

INSERT INTO Pricing (model_id, input_price, output_price, currency)
VALUES
(1, 2.50, 10.00, 'USD'),
(2, 2.00, 8.00, 'USD'),
(3, 1.25, 10.00, 'USD'),
(4, 1.25, 10.00, 'USD'),
(5, 15.00, 75.00, 'USD'),
(6, 0.20, 0.60, 'USD'),
(7, 3.00, 15.00, 'USD'),
(8, 2.00, 6.00, 'USD');

SELECT
m.model_name,
c.company_name
FROM Models m
JOIN Companies c
ON m.company_id = c.company_id;

SELECT model_name
FROM Models
WHERE open_source = TRUE;

SELECT model_name, release_date
FROM Models
ORDER BY release_date DESC;

SELECT
m.model_name,
p.input_price,
p.output_price
FROM Models m
JOIN Pricing p
ON m.model_id = p.model_id;


SELECT
m.model_name,
b.benchmark_name,
mb.score
FROM Model_Benchmarks mb
JOIN Models m
ON mb.model_id = m.model_id
JOIN Benchmarks b
ON mb.benchmark_id = b.benchmark_id
WHERE m.model_name = 'GPT-5';

SELECT
m.model_name
FROM Models m
JOIN Model_Modalities mm
ON m.model_id = mm.model_id
JOIN Modalities mo
ON mm.modality_id = mo.modality_id
WHERE mo.modality_name = 'Image';

SELECT
m.model_name,
mb.score
FROM Model_Benchmarks mb
JOIN Models m
ON mb.model_id = m.model_id
JOIN Benchmarks b
ON mb.benchmark_id = b.benchmark_id
WHERE b.benchmark_name = 'MMLU'
ORDER BY mb.score DESC
LIMIT 1;

SELECT
m.model_name,
l.license_name
FROM Models m
JOIN Licenses l
ON m.license_id = l.license_id;

SELECT
m.model_name,
AVG(mb.score) AS average_score
FROM Models m
JOIN Model_Benchmarks mb
ON m.model_id = mb.model_id
GROUP BY m.model_name
ORDER BY average_score DESC;

SELECT
c.company_name,
COUNT(m.model_id) AS total_models
FROM Companies c
JOIN Models m
ON c.company_id = m.company_id
GROUP BY c.company_name
ORDER BY total_models DESC;

SELECT
m.model_name,
p.input_price
FROM Models m
JOIN Pricing p
ON m.model_id = p.model_id
ORDER BY p.input_price ASC
LIMIT 1;

SELECT
c.company_name,
ROUND(AVG(mb.score), 2) AS average_score
FROM Companies c
JOIN Models m
ON c.company_id = m.company_id
JOIN Model_Benchmarks mb
ON m.model_id = mb.model_id
GROUP BY c.company_name
ORDER BY average_score DESC;

SELECT
m.model_name,
p.input_price
FROM Models m
JOIN Pricing p
ON m.model_id = p.model_id
WHERE p.input_price < 2;

SELECT
m.model_name,
COUNT(mm.modality_id) AS supported_modalities
FROM Models m
JOIN Model_Modalities mm
ON m.model_id = mm.model_id
GROUP BY m.model_name
ORDER BY supported_modalities DESC;

