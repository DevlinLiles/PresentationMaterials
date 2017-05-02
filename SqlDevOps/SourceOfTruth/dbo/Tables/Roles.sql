CREATE TABLE [dbo].[Roles] (
    [RoleId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [RoleName] NVARCHAR (100) NOT NULL,
    [TenantId] INT            CONSTRAINT [DF_Roles_TenantId] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([RoleId] ASC)
);

