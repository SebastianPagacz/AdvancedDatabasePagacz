CREATE FUNCTION [Student_5].ufn_CalcAdjustedPrices()
RETURNS @Summary TABLE
(
	ProductID INT,
	Name NVARCHAR(100),
	ListPrice MONEY,
	AdjustedPrice Money
)
AS
BEGIN
	INSERT INTO @Summary (ProductID, Name, ListPrice, AdjustedPrice)
	SELECT
		ProductID,
		Name,
		ListPrice,
		(ListPrice - (ListPrice * 0.05))
	FROM
		TopProducts;

	Return;
END;
