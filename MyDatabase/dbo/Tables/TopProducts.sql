CREATE TABLE [dbo].[TopProducts] (
    [ProductID] INT            NOT NULL,
    [Name]      NVARCHAR (100) NULL,
    [ListPrice] MONEY          NULL,
    PRIMARY KEY CLUSTERED ([ProductID] ASC)
);

