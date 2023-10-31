USE gravity_books_DW
go

-- Dropping the foreign keys
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'FK_SalesFact_BookDim'
           AND parent_object_id = Object_id('SalesFact'))
	ALTER TABLE SalesFact
    DROP CONSTRAINT FK_SalesFact_BookDim;

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'BookDim')
	DROP TABLE BookDim
go
CREATE TABLE BookDim
  (
     book_PK        INT NOT NULL IDENTITY(1, 1),            
     book_BK        INT NOT NULL,              -- Business key
     title			NVARCHAR(400),
     language       NVARCHAR(50),
	 publisher	    NVARCHAR(400),
	 author			NVARCHAR(400),

	 -- SCD
     start_date         DATETIME NOT NULL DEFAULT (Getdate()),    
     end_date           DATETIME NULL,							  
     is_current         TINYINT NOT NULL DEFAULT (1),             
     CONSTRAINT PK_BookDim PRIMARY KEY CLUSTERED (book_PK)
  );

  -- Create Foreign Key
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'SalesFact')
  ALTER TABLE SalesFact
    ADD CONSTRAINT FK_SalesFact_BookDim FOREIGN KEY (book_SK)
    REFERENCES BookDim(book_PK);

-- Create Indexes
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'BookDim_bookBK'
                  AND object_id = Object_id('BookDim'))
	DROP INDEX BookDim.BookDim_bookBK
go
CREATE INDEX BookDim_bookBK
ON BookDim(book_BK);
