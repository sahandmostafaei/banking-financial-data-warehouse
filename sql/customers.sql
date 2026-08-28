-- Banking Financial Data Warehouse
-- Customer sample data
-- Author: Sahand Mostafaei

INSERT INTO customers (
    customer_id,
    customer_name,
    date_of_birth,
    city,
    customer_segment
)
VALUES
    (1,  'Customer 001', '1985-04-12', 'Zurich',   'Premium'),
    (2,  'Customer 002', '1990-07-23', 'Geneva',   'Mass Market'),
    (3,  'Customer 003', '1978-11-05', 'Basel',    'Premium'),
    (4,  'Customer 004', '1988-02-19', 'Lausanne', 'Mass Market'),
    (5,  'Customer 005', '1975-09-30', 'Bern',     'Premium'),
    (6,  'Customer 006', '1982-06-14', 'Zurich',   'Premium'),
    (7,  'Customer 007', '1993-01-27', 'Geneva',   'Mass Market'),
    (8,  'Customer 008', '1986-12-08', 'Basel',    'Premium'),
    (9,  'Customer 009', '1991-03-16', 'Lausanne', 'Mass Market'),
    (10, 'Customer 010', '1979-08-21', 'Bern',     'Premium');
