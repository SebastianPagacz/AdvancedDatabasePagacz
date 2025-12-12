CREATE FUNCTION [Student_5].[ufn_IsPriceHigherThanCurrent](@Product NVARCHAR(MAX))
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @Result NVARCHAR(10);
	DECLARE @res Money;
	
	SET @res =(
	SELECT ListPrice FROM SalesLT.Product WHERE Name LIKE JSON_VALUE(@Product, '$.Name') OR ProductID = JSON_VALUE(@Product, '$.ProductID'));

	IF @res >= JSON_VALUE(@Product, '$.ListPrice')
		SET @Result = 'false';

	ELSE IF @res < JSON_VALUE(@Product, '$.ListPrice')
		SET @Result = 'true';

	RETURN @Result;
END;
