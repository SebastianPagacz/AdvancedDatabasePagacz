-- ============================
-- Sebastian  X = S
-- Pagacz	  Y = 234595
-- 234595	  N = 5
-- ============================

-- =============================================
-- Zadanie 1
-- =============================================


-- =============================================
-- Zadanie 2
-- =============================================

ALTER TABLE [234595].Customer
ADD
    SysStartTime datetime2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT Default_Start_Time DEFAULT SYSUTCDATETIME(),
    SysEndTime datetime2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT Default_End_Time DEFAULT CONVERT(datetime2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

ALTER TABLE [234595].Customer 
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.CustomerHistory));

-- =============================================
-- Zadanie 3
-- =============================================

SELECT CustomerID, CompanyName
FROM [234595].Customer
WHERE CustomerID % 10 = 5;
GO

UPDATE [234595].Customer
SET CompanyName = 'Heineken'
WHERE CustomerID % 10 = 5;
GO

UPDATE [234595].Customer
SET CompanyName = 'HGSS'
WHERE CustomerID = 5
GO

INSERT INTO [234595].Customer (FirstName, LastName, CompanyName, EmailAddress, PasswordHash, PasswordSalt)
VALUES
('Abigejl', 'Sejczel', 'Marymont entrprise', 'xdd@diuawbdiuba.com', 'xddx123A', 'xddx123A'),
('Ziomek', 'SLuzny', 'To niezla swieczka', 'xdd@swieczka.com', 'HasloMaslo', 'HasloMaslo'),
('Martinez', 'SMajkootez', 'hej gorale', 'xdd@ko0taz.pl', 'Pisanie', 'Pisanie'),
('Ziomek', 'Salazar', 'To niezla swieczka', 'xdd1@swieczka.com', 'HasloMaslo', 'HasloMaslo'),
('Cazorla', 'Santi', 'fuiab', 'xdd@ko0taz.pl', 'Pisanie', 'Pisanie');
GO

-- =============================================
-- Zadanie 4
-- =============================================

SELECT *
FROM [234595].Customer
FOR SYSTEM_TIME ALL
WHERE CustomerID = 5;
GO

-- =============================================
-- Zadanie 5
-- =============================================

SELECT *
FROM [234595].Customer
FOR SYSTEM_TIME AS OF '2025-12-07 19:00:16.8497232';
GO

-- =============================================
-- Zadanie 6
-- =============================================


CREATE XML SCHEMA COLLECTION ProductSchema AS N'
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xs:element name="Product" type="ProductType"/>
    <xs:complexType name="ProductType">
        <xs:sequence>
            <xs:element name="Color" type="xs:string"/>
            <xs:element name="Weight" type="xs:decimal"/>
            <xs:element name="Size" type="xs:string"/>
            <xs:element name="LastPrice" type="xs:decimal"/>
            <xs:element name="Name" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
';
GO

CREATE TABLE SalesLT.ProductAttribute 
(
    ProductID INT PRIMARY KEY,
    Attributes xml(ProductSchema) NULL,

    CONSTRAINT FK_ProductAttribute_Product
        FOREIGN KEY (ProductID) REFERENCES SalesLT.Product(ProductID)
);
GO

-- =============================================
-- Zadanie 7
-- =============================================

INSERT INTO SalesLT.ProductAttribute (ProductID, Attributes)
SELECT TOP 5
p.ProductID,
(
SELECT
    p.Color,
    p.Weight,
    p.Size,
    p.ListPrice AS 'LastPrice',
    p.Name
FOR XML PATH('Product'), TYPE
)
FROM SalesLT.Product AS p
WHERE 
p.Color IS NOT NULL
AND p.Weight IS NOT NULL
AND p.Size IS NOT NULL;
GO

-- =============================================
-- Zadanie 8
-- =============================================

UPDATE SalesLT.ProductAttribute
SET 
Attributes.modify('replace value of (/Product/Color)[1] with concat("S", (/Product/Color)[1])');
GO

UPDATE SalesLT.ProductAttribute
SET 
Attributes.modify('replace value of (/Product/Name)[1] with concat("S", (/Product/Name)[1])');
GO

SELECT * FROM SalesLT.ProductAttribute;
GO

-- =============================================
-- Zadanie 9
-- =============================================

DECLARE @x NVARCHAR(max) = N'{"person":
{
    "name": "John Doe",
    "age": 30
}}';

SELECT @x

SET @x = JSON_MODIFY(@x, '$.person.age', 234595);

SELECT @x
GO