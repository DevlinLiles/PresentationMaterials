CREATE TABLE [dbo].[ActivityDescriptions] (
    [Id]                     BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]                   NVARCHAR (150) NOT NULL,
    [OccuranceName]          NVARCHAR (75)  NULL,
    [PointsPerOccurance]     INT            NOT NULL,
    [MaxOccurancesPerPeriod] INT            NOT NULL,
    [AreaId]                 BIGINT         NOT NULL,
    [IsActive]               BIT            NOT NULL,
    [TenantId]               INT            DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_dbo.ActivityDescriptions] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.ActivityDescriptions_dbo.ActivityAreas_AreaId] FOREIGN KEY ([AreaId]) REFERENCES [dbo].[ActivityAreas] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_AreaId]
    ON [dbo].[ActivityDescriptions]([AreaId] ASC);

