CREATE TABLE [dbo].[ReportingPeriods] (
    [Id]        BIGINT        IDENTITY (1, 1) NOT NULL,
    [StartDate] DATETIME      NOT NULL,
    [EndDate]   DATETIME      NOT NULL,
    [Grace]     INT           NOT NULL,
    [Name]      VARCHAR (100) NOT NULL,
    [CompanyId] BIGINT        NOT NULL,
    [TenantId]  INT           DEFAULT ((1)) NOT NULL,
    [Active]    AS            (case when getdate()<=dateadd(day,[Grace],[ENDDATE]) AND getdate()>=[StartDate] then (1) else (0) end),
    CONSTRAINT [PK_dbo.ReportingPeriods] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.ReportingPeriods_dbo.Companies_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Companies] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_CompanyId]
    ON [dbo].[ReportingPeriods]([CompanyId] ASC);

