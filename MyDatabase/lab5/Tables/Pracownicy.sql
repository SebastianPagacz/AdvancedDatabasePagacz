CREATE TABLE [lab5].[Pracownicy] (
    [PracownikID]         INT            NOT NULL,
    [Imie]                NVARCHAR (50)  NOT NULL,
    [Nazwisko]            NVARCHAR (100) NOT NULL,
    [WynagrodzenieRoczne] MONEY          NOT NULL,
    PRIMARY KEY CLUSTERED ([PracownikID] ASC)
);

