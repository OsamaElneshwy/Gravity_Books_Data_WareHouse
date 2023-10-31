USE gravity_books_DW
go

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'SalesFact')
	DROP TABLE SalesFact;
go
CREATE TABLE SalesFact
  (
	 id		        INT NOT NULL IDENTITY(1, 1),	-- Fact table PRIMARY KEY
     customer_SK    INT NOT NULL,					-- surrogate key as a forigen key
     book_SK	    INT NOT NULL,					-- surrogate key as a forigen key
	 shipping_SK    INT NOT NULL,					-- surrogate key as a forigen key
     date_SK		INT NOT NULL,					-- surrogate key as a forigen key
	 price			MONEY,							-- Measure
     costShipping   MONEY,							-- Measure
	 
     CONSTRAINT PK_SalesFact PRIMARY KEY CLUSTERED (id),
	 CONSTRAINT FK_SalesFact_CustomerDim FOREIGN KEY (customer_SK) REFERENCES CustomerDim(customer_PK),
     CONSTRAINT FK_SalesFact_BookDim FOREIGN KEY (book_SK) REFERENCES BookDim(book_PK),
	 CONSTRAINT FK_SalesFact_ShippingDim FOREIGN KEY (shipping_SK) REFERENCES ShippingDim(shipping_PK),
     CONSTRAINT FK_SalesFact_DateDim FOREIGN KEY (date_SK) REFERENCES DateDim(date_PK)
  );

-- Create Indexes for Customer key
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'SalesFact_CustomerDim'
           AND object_id = Object_id('SalesFact'))
	DROP INDEX SalesFact.SalesFact_CustomerDim;
go
CREATE INDEX SalesFact_CustomerDim
ON SalesFact(customer_SK);

-- Create Indexes for book key
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'SalesFact_BookDim'
           AND object_id = Object_id('SalesFact'))
	DROP INDEX SalesFact.SalesFact_BookDim;
go
CREATE INDEX SalesFact_BookDim
ON SalesFact(book_SK);

-- Create Indexes for Date key
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'SalesFact_DateDim'
           AND object_id = Object_id('SalesFact'))
  DROP INDEX SalesFact.SalesFact_DateDim;
go
CREATE INDEX SalesFact_DateDim
ON SalesFact(date_SK); 