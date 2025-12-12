CREATE FUNCTION Student_5.ufn_ProductsJsonCategory
(
	@Category NVARCHAR(100)
)
RETURNS NVARCHAR(max)
AS
BEGIN
	DECLARE @JsonResult NVARCHAR(max);

	SET @JsonResult = 
	(
	SELECT p.ProductCategoryID, p.Name AS ProductName, p.ListPrice, pc.Name AS CategoryName 
	FROM SalesLT.Product p 
	JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID 
	WHERE pc.Name LIKE @Category
	FOR JSON PATH, ROOT('Products')
	);

	RETURN @JsonResult;
END;
