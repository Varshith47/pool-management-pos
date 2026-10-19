-- Optional demo products. Import after schema.sql.
USE pool_pos;
INSERT INTO products(name,category,cost_price,selling_price,stock_qty,low_stock_level) VALUES
('Classic swim tube','Tubes',90.00,150.00,20,5),
('Silicone swim cap','Caps',70.00,120.00,25,6),
('Anti-fog goggles','Goggles',180.00,299.00,12,4),
('Training swim shorts','Shorts',220.00,349.00,10,3);
