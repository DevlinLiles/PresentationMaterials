CREATE TABLE [dbo].[ActivityAreas] (
    [Id]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (150) NOT NULL,
    [Description] NVARCHAR (500) NULL,
    [CompanyId]   BIGINT         NOT NULL,
    [IsActive]    BIT            NOT NULL,
    [TenantId]    INT            DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_dbo.ActivityAreas] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.ActivityAreas_dbo.Companies_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Companies] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_CompanyId]
    ON [dbo].[ActivityAreas]([CompanyId] ASC);

