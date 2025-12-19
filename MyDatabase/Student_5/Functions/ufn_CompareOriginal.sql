CREATE FUNCTION Student_5.ufn_CompareOriginal(@Product NVARCHAR(MAX))
RETURNS @Result TABLE 
(
	ProductID INT,
	Name NVARCHAR(100),
	ListPrice MONEY,
	IsPriceHigher NVARCHAR(10)
)
AS
BEGIN
	INSERT INTO @Result (ProductID, Name, ListPrice, IsPriceHigher)
	VALUES (JSON_VALUE(@Product, '$.ProductID'), JSON_VALUE(@Product, '$.Name'), JSON_VALUE(@Product, '$.ListPrice'), Student_5.ufn_IsPriceHigherThanCurrent(@Product))

RETURN;
END;
