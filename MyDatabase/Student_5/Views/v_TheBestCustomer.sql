CREATE VIEW Student_5.v_TheBestCustomer AS
SELECT TOP 3 c.CustomerID, c.FirstName, c.LastName, c.CompanyName, SUM(s.TotalDue) as TotalSpend FROM [234595].Customer c
JOIN SalesLt.SalesOrderHeader s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.CompanyName
ORDER BY TotalSpend DESC;
