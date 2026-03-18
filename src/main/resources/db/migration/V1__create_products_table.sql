-- =====================================================
-- V1__create_products_table.sql
-- Creates tables in the public schema (default)
-- =====================================================

-- =====================================================
-- Table: product_category
-- =====================================================
CREATE TABLE IF NOT EXISTS product_category (
    id              BIGSERIAL PRIMARY KEY,
    category_name   VARCHAR(255) NOT NULL
);

-- =====================================================
-- Table: product
-- =====================================================
CREATE TABLE IF NOT EXISTS product (
    id              BIGSERIAL PRIMARY KEY,
    sku             VARCHAR(255) UNIQUE,
    name            VARCHAR(255) NOT NULL,
    description     VARCHAR(255),
    unit_price      DECIMAL(13,2) NOT NULL,
    image_url       VARCHAR(255),
    active          BOOLEAN DEFAULT true,
    units_in_stock  INTEGER,
    date_created    TIMESTAMPTZ DEFAULT NOW(),
    last_updated    TIMESTAMPTZ DEFAULT NOW(),
    category_id     BIGINT NOT NULL,

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES product_category(id)
);

-- =====================================================
-- Sample Data
-- =====================================================
INSERT INTO product_category (category_name)
VALUES ('BOOKS')
ON CONFLICT DO NOTHING;

INSERT INTO product
    (sku, name, description, image_url, active, units_in_stock,
     unit_price, category_id, date_created, last_updated)
VALUES
    ('BOOK-TECH-1000', 'JavaScript - The Fun Parts', 'Learn JavaScript',
     'assets/images/products/placeholder.png', true, 100, 19.99, 1, NOW(), NOW()),

    ('BOOK-TECH-1001', 'Spring Framework Tutorial', 'Learn Spring',
     'assets/images/products/placeholder.png', true, 100, 29.99, 1, NOW(), NOW()),

    ('BOOK-TECH-1002', 'Kubernetes - Deploying Containers', 'Learn Kubernetes',
     'assets/images/products/placeholder.png', true, 100, 24.99, 1, NOW(), NOW()),

    ('BOOK-TECH-1003', 'Internet of Things (IoT) - Getting Started', 'Learn IoT',
     'assets/images/products/placeholder.png', true, 100, 29.99, 1, NOW(), NOW()),

    ('BOOK-TECH-1004', 'The Go Programming Language: A to Z', 'Learn Go',
     'assets/images/products/placeholder.png', true, 100, 24.99, 1, NOW(), NOW())
ON CONFLICT (sku) DO NOTHING;