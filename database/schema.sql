CREATE DATABASE IF NOT EXISTS pool_pos CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pool_pos;
CREATE TABLE IF NOT EXISTS users (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(120) NOT NULL,
 email VARCHAR(190) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL,
 role ENUM('admin','staff') NOT NULL DEFAULT 'staff',
 active TINYINT(1) NOT NULL DEFAULT 1,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS customers (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(140) NOT NULL,
 phone VARCHAR(40) NULL,
 email VARCHAR(190) NULL,
 notes VARCHAR(500) NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX idx_customer_name(name), INDEX idx_customer_phone(phone)
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS products (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(160) NOT NULL,
 category ENUM('Tubes','Caps','Goggles','Shorts','Other') NOT NULL DEFAULT 'Other',
 cost_price DECIMAL(10,2) NOT NULL DEFAULT 0,
 selling_price DECIMAL(10,2) NOT NULL DEFAULT 0,
 stock_qty INT NOT NULL DEFAULT 0,
 low_stock_level INT NOT NULL DEFAULT 5,
 active TINYINT(1) NOT NULL DEFAULT 1,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX idx_products_category(category)
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS sales (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 invoice_no VARCHAR(40) NOT NULL UNIQUE,
 customer_id INT UNSIGNED NULL,
 user_id INT UNSIGNED NOT NULL,
 subtotal DECIMAL(10,2) NOT NULL,
 total DECIMAL(10,2) NOT NULL,
 paid_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
 balance DECIMAL(10,2) NOT NULL DEFAULT 0,
 payment_method ENUM('Cash','PhonePe/UPI','Card','Due') NOT NULL DEFAULT 'Cash',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE SET NULL,
 FOREIGN KEY(user_id) REFERENCES users(id),
 INDEX idx_sales_created(created_at), INDEX idx_sales_balance(balance)
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS sale_items (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 sale_id BIGINT UNSIGNED NOT NULL,
 product_id INT UNSIGNED NULL,
 product_name VARCHAR(160) NOT NULL,
 qty INT NOT NULL,
 unit_price DECIMAL(10,2) NOT NULL,
 cost_price DECIMAL(10,2) NOT NULL,
 line_total DECIMAL(10,2) NOT NULL,
 FOREIGN KEY(sale_id) REFERENCES sales(id) ON DELETE CASCADE,
 FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE SET NULL
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS swim_sessions (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 customer_id INT UNSIGNED NULL,
 swimmer_name VARCHAR(140) NOT NULL,
 phone VARCHAR(40) NULL,
 duration_minutes INT NOT NULL DEFAULT 60,
 started_at DATETIME NOT NULL,
 ends_at DATETIME NOT NULL,
 finished_at DATETIME NULL,
 status ENUM('active','completed','expired') NOT NULL DEFAULT 'active',
 created_by INT UNSIGNED NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE SET NULL,
 FOREIGN KEY(created_by) REFERENCES users(id),
 INDEX idx_sessions_status(status), INDEX idx_sessions_ends(ends_at)
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS bookings (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 customer_name VARCHAR(140) NOT NULL,
 phone VARCHAR(40) NULL,
 booking_date DATE NOT NULL,
 booking_time TIME NOT NULL,
 people INT NOT NULL DEFAULT 1,
 booking_type VARCHAR(60) NOT NULL DEFAULT 'General swim',
 notes VARCHAR(500) NULL,
 status ENUM('booked','arrived','cancelled') NOT NULL DEFAULT 'booked',
 created_by INT UNSIGNED NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(created_by) REFERENCES users(id),
 INDEX idx_bookings_date(booking_date,status)
) ENGINE=InnoDB;
