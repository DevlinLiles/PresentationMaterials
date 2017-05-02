CREATE TABLE [dbo].[Tenants] (
    [TenantId]   INT            IDENTITY (1, 1) NOT NULL,
    [TenantName] NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Tenants] PRIMARY KEY CLUSTERED ([TenantId] ASC)
);

