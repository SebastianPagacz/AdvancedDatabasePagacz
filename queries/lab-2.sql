---- ============================
---- Sebastian  X = S
---- Pagacz	  Y = 234595
---- 234595	  N = 5
---- ============================

---- ============================
---- Zadanie 2
---- ============================
--DECLARE @Litera CHAR(1) = 'S';
--DECLARE @cyfra INT = 5;

--SELECT CustomerID, FirstName, LastName 
--FROM SalesLT.Customer
--WHERE FirstName LIKE @Litera + '%' AND (CustomerID % 10 = @cyfra)
--GO

---- ============================
---- Zadanie 3
---- ============================
--DECLARE @Produkty TABLE
--(
--ProductID INT,
--Name NVARCHAR(50),
--ListPrice money
--)

--INSERT INTO @Produkty (ProductID, Name, ListPrice)
--SELECT ProductID, Name, ListPrice FROM SalesLT.Product
--WHERE Name LIKE '%S%';

--SELECT * FROM @Produkty;
--GO

---- ============================
---- Zadanie 4
---- ============================

--CREATE TABLE #KlienciMiasta 
--(
--CustomerID INT PRIMARY KEY,
--FirstName NVARCHAR(50),
--LastName NVARCHAR(80),
--City NVARCHAR(50)
--);

--INSERT INTO #KlienciMiasta (CustomerID, FirstName, LastName, City)
--SELECT c.CustomerID, c.FirstName, c.LastName, a.City
--FROM SalesLT.Address a
--LEFT JOIN SalesLT.CustomerAddress ca ON a.AddressID = ca.AddressID
--INNER JOIN SalesLT.Customer c ON ca.CustomerID = c.CustomerID
--WHERE a.City LIKE 'S%';

--GO

---- ============================
---- Zadanie 5
---- ============================

--CREATE SCHEMA Student_5
--AUTHORIZATION dbo;
--GO 

--CREATE TABLE Student_5.ProduktyS
--(
--ProductID INT PRIMARY KEY,
--Name nvarchar(100),
--Category nvarchar(100),
--ListPrice money
--); 

--INSERT INTO Student_5.ProduktyS (ProductID, Name, Category, ListPrice)
--SELECT p.ProductID, p.Name, pc.Name, p.ListPrice
--FROM SalesLT.Product p 
--LEFT JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID

--GO

---- ============================
---- Zadanie 6
---- ============================

--DECLARE @Podsumowanie TABLE 
--(
--Category NVARCHAR(100),
--SredniaCena money
--);

--INSERT INTO @Podsumowanie (Category, SredniaCena)
--SELECT pc.Name, AVG(p.ListPrice)
--FROM SalesLT.ProductCategory pc
--JOIN SalesLT.Product p ON pc.ProductCategoryID = p.ProductCategoryID
--WHERE pc.ProductCategoryID % 10 = 5
--GROUP BY pc.Name;

--SELECT * FROM @Podsumowanie;

--GO

---- ============================
---- Zadanie 7
---- ============================

--CREATE SCHEMA [234595]
--AUTHORIZATION dbo;
--GO

--ALTER SCHEMA [234595] TRANSFER SalesLT.Customer;
--ALTER SCHEMA [234595] TRANSFER SalesLT.CustomerAddress;

--GO