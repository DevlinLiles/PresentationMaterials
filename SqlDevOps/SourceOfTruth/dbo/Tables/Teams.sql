CREATE TABLE [dbo].[Teams] (
    [Id]        BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (150) NOT NULL,
    [CompanyId] BIGINT         NOT NULL,
    [TenantId]  INT            NOT NULL,
    CONSTRAINT [PK_dbo.Teams] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Teams_dbo.Companies_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Companies] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_CompanyId]
    ON [dbo].[Teams]([CompanyId] ASC);

