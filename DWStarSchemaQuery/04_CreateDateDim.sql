USE gravity_books_DW
go

-- Dropping the foreign keys
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'FK_SalesFact_DateDim'
           AND parent_object_id = Object_id('SalesFact'))
	ALTER TABLE SalesFact
    DROP CONSTRAINT FK_SalesFact_DateDim;

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'DateDim')
   DROP TABLE DateDim;
go
CREATE TABLE DateDim
  (
	 date_PK             INT NOT NULL,           
     full_date           DATE NOT NULL,
     calendar_year       INT NOT NULL,
     calendar_quarter    INT NOT NULL,
     calendar_month_num  INT NOT NULL,
     calendar_month_name NVARCHAR(15) NOT NULL
     CONSTRAINT PK_DateDim PRIMARY KEY CLUSTERED (date_PK)
  );

-- Create Foreign Key
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'SalesFact')
  ALTER TABLE SalesFact
    ADD CONSTRAINT FK_SalesFact_DateDim FOREIGN KEY (date_SK)
    REFERENCES DateDim(date_PK);
