USE gravity_books_DW
go

-- Dropping the foreign keys
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'FK_SalesFact_ShippingDim'
           AND parent_object_id = Object_id('SalesFact'))
	ALTER TABLE SalesFact
    DROP CONSTRAINT FK_SalesFact_ShippingDim;

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'ShippingDim')
	DROP TABLE ShippingDim
go
CREATE TABLE ShippingDim
  (
     shipping_PK        INT NOT NULL IDENTITY(1, 1),            
     shipping_BK        INT NOT NULL,              -- Business key
     method				NVARCHAR(100),

	 -- SCD
     start_date         DATETIME NOT NULL DEFAULT (Getdate()),    
     end_date           DATETIME NULL,							  
     is_current         TINYINT NOT NULL DEFAULT (1),             
     CONSTRAINT PK_ShippingDim PRIMARY KEY CLUSTERED (shipping_PK)
  );

  -- Create Foreign Key
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'SalesFact')
  ALTER TABLE SalesFact
    ADD CONSTRAINT FK_SalesFact_ShippingDim FOREIGN KEY (shipping_SK)
    REFERENCES ShippingDim(shipping_PK);

-- Create Indexes
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'ShippingDim_shippingBK'
                  AND object_id = Object_id('ShippingDim'))
	DROP INDEX ShippingDim.ShippingDim_shippingBK
go
CREATE INDEX ShippingDim_shippingBK
ON ShippingDim(shipping_BK);
