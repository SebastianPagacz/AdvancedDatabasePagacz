CREATE TABLE [lab5].[Sprzedaz2025] (
    [TransakcjaID]     INT            NOT NULL,
    [PracownikID]      INT            NOT NULL,
    [NazwaProduktu]    NVARCHAR (100) NOT NULL,
    [WartoscSprzedazy] MONEY          NOT NULL,
    PRIMARY KEY CLUSTERED ([TransakcjaID] ASC),
    CONSTRAINT [FK_Sprzedaz2025_Pracownicy] FOREIGN KEY ([PracownikID]) REFERENCES [lab5].[Pracownicy] ([PracownikID])
);

