CREATE TABLE [dbo].[Languages] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [LanguageId]   NVARCHAR (10) NOT NULL,
    [LanguageName] NVARCHAR (50) NOT NULL,
    [TenantId]     INT           CONSTRAINT [DF_Languages_TenantId] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED ([Id] ASC)
);

