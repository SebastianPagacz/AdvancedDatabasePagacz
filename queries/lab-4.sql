---- ============================
---- Sebastian  X = S
---- Pagacz	  Y = 234595
---- 234595	  N = 5
---- ============================

---- =============================================
---- Zadanie 1
---- =============================================

--DECLARE @ProductInfo NVARCHAR(max) = N'[
--{"ProductID" : 680,
--"NewPrice" : 1400},
--{"ProductID" : 706,
--"NewPrice" : 1400},
--{"ProductID" : 707,
--"NewPrice" : 40},
--{"ProductID" : 708,
--"NewPrice" : 200},
--{"ProductID" : 709,
--"NewPrice" : 115}]';
--GO

--CREATE VIEW SalesLT.v_ProductInfo AS
--SELECT pif.ProductID, p.ListPrice, pif.NewPrice
--FROM OPENJSON(@ProductInfo) WITH 
--(
--ProductID INT '$.ProductID',
--NewPrice INT '$.NewPrice'
--) AS pif
--JOIN SalesLT.Product AS p ON pif.ProductID = p.ProductID

--GO
----xd

---- =============================================
---- Zadanie 2
---- =============================================

--CREATE VIEW Student_5.v_TheBestCustomer AS
--SELECT TOP 3 c.CustomerID, c.FirstName, c.LastName, c.CompanyName, SUM(s.TotalDue) as TotalSpend FROM [234595].Customer c
--JOIN SalesLt.SalesOrderHeader s ON c.CustomerID = s.CustomerID
--GROUP BY c.CustomerID, c.FirstName, c.LastName, c.CompanyName
--ORDER BY TotalSpend DESC;
--GO

---- 3 najelpszych klientów to ci, którzy wydali u nas najwiêcej kasy (proste B) )

---- =============================================
---- Zadanie 3
---- =============================================

--CREATE FUNCTION Student_5.ufn_ProductsJsonCategory
--(
--	@Category NVARCHAR(100)
--)
--RETURNS NVARCHAR(max)
--AS
--BEGIN
--	DECLARE @JsonResult NVARCHAR(max);

--	SET @JsonResult = 
--	(
--	SELECT p.ProductCategoryID, p.Name AS ProductName, p.ListPrice, pc.Name AS CategoryName 
--	FROM SalesLT.Product p 
--	JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID 
--	WHERE pc.Name LIKE @Category
--	FOR JSON PATH, ROOT('Products')
--	);

--	RETURN @JsonResult;
--END;
--GO

--SELECT Student_5.ufn_ProductsJsonCategory('Lights');
--GO

---- =============================================
---- Zadanie 4
---- =============================================

--CREATE FUNCTION Student_5.ufn_IsPriceHigherThanCurrent(@Product NVARCHAR(MAX))
--RETURNS NVARCHAR(10)
--AS
--BEGIN
--	DECLARE @Result NVARCHAR(10);
--	DECLARE @res Money;
	
--	SET @res =(
--	SELECT ListPrice FROM SalesLT.Product WHERE Name LIKE JSON_VALUE(@Product, '$.Name') OR ProductID = JSON_VALUE(@Product, '$.ProductID'));

--	IF @res >= JSON_VALUE(@Product, '$.ListPrice')
--		SET @Result = 'false';

--	ELSE IF @res < JSON_VALUE(@Product, '$.ListPrice')
--		SET @Result = 'true';

--	RETURN @Result;
--END;
--GO

--DECLARE @Product1 NVARCHAR(MAX) =
--N'
--{"ProductID" : 680,
--"Name" : "HL Road Frame - Black, 58",
--"ListPrice" : 1500}';

--SELECT Student_5.ufn_IsPriceHigherThanCurrent(@Product1); -- Moge zwracac takze bit ale z tego co pamietam i co sprawdzilem t-sql nie obsluguje natywnie boolean typu prawda/falsz
--GO
---- =============================================
---- Zadanie 5
---- =============================================

--CREATE FUNCTION Student_5.ufn_CompareOriginal(@Product NVARCHAR(MAX))
--RETURNS @Result TABLE 
--(
--	ProductID INT,
--	Name NVARCHAR(100),
--	ListPrice MONEY,
--	IsPriceHigher NVARCHAR(10)
--)
--AS
--BEGIN
--	INSERT INTO @Result (ProductID, Name, ListPrice, IsPriceHigher)
--	VALUES (JSON_VALUE(@Product, '$.ProductID'), JSON_VALUE(@Product, '$.Name'), JSON_VALUE(@Product, '$.ListPrice'), Student_5.ufn_IsPriceHigherThanCurrent(@Product))

--RETURN;
--END;
--GO

--DECLARE @Product1 NVARCHAR(MAX) =
--N'
--{"ProductID" : 680,
--"Name" : "HL Road Frame - Black, 58",
--"ListPrice" : 1500}';

--SELECT * FROM Student_5.ufn_CompareOriginal(@Product1);
--GO

---- =============================================
---- Zadanie 6
---- =============================================

--CREATE TABLE #TopProducts
--(
--	ProductID INT PRIMARY KEY,
--	Name NVARCHAR(100),
--	ListPrice MONEY
--);

--CREATE FUNCTION Studnet_5.ufn_CalcAdjustedPrices(@TopProducts)
--RETURNS @Result TABLE
