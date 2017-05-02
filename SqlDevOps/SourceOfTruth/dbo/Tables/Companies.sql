CREATE TABLE [dbo].[Companies] (
    [Id]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]     NVARCHAR (150) NOT NULL,
    [TenantId] INT            DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_dbo.Companies] PRIMARY KEY CLUSTERED ([Id] ASC)
);

