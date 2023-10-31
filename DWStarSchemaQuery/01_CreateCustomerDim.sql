USE gravity_books_DW
go

-- Dropping the foreign keys
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'FK_SalesFact_CustomerDim'
           AND parent_object_id = Object_id('SalesFact'))
	ALTER TABLE SalesFact
    DROP CONSTRAINT FK_SalesFact_CustomerDim;

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'CustomerDim')
	DROP TABLE CustomerDim
go
CREATE TABLE CustomerDim
  (
     customer_PK        INT NOT NULL IDENTITY(1, 1),            
     customer_BK        INT NOT NULL,              -- Business key
     customer_name      NVARCHAR(401),
     city               NVARCHAR(100),
	 country	        NVARCHAR(200),                      

	 -- SCD
     start_date         DATETIME NOT NULL DEFAULT (Getdate()),    
     end_date           DATETIME NULL,							  
     is_current         TINYINT NOT NULL DEFAULT (1),             
     CONSTRAINT PK_CustomerDim PRIMARY KEY CLUSTERED (customer_PK)
  );

  -- Create Foreign Key
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'SalesFact')
  ALTER TABLE SalesFact
    ADD CONSTRAINT FK_SalesFact_CustomerDim FOREIGN KEY (customer_SK)
    REFERENCES CustomerDim(customer_PK);

-- Create Indexes
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'CustomerDim_customerBK'
                  AND object_id = Object_id('CustomerDim'))
	DROP INDEX CustomerDim.CustomerDim_customerBK
go
CREATE INDEX CustomerDim_customerBK
ON CustomerDim(customer_BK);
