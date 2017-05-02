CREATE TABLE [dbo].[Activities] (
    [Id]                BIGINT          IDENTITY (1, 1) NOT NULL,
    [DescriptionId]     BIGINT          NOT NULL,
    [Notes]             NVARCHAR (4000) NULL,
    [ReportingPeriodId] BIGINT          NOT NULL,
    [ActivityDate]      DATETIME        NOT NULL,
    [Quantity]          INT             NOT NULL,
    [ReportedPoints]    INT             NOT NULL,
    [ReviewNotes]       NVARCHAR (4000) NULL,
    [AdjustedPoints]    INT             NULL,
    [ReviewedDate]      DATETIME        NULL,
    [ReviewerId]        BIGINT          NULL,
    [UserId]            BIGINT          NOT NULL,
    [AreaId]            BIGINT          NOT NULL,
    [TenantId]          INT             DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Activities] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Activities_ActivityAreas_AreaId] FOREIGN KEY ([AreaId]) REFERENCES [dbo].[ActivityAreas] ([Id]),
    CONSTRAINT [FK_Activities_ActivityDescriptions_DescriptionId] FOREIGN KEY ([DescriptionId]) REFERENCES [dbo].[ActivityDescriptions] ([Id]),
    CONSTRAINT [FK_Activities_ReportingPeriods_ReportingPeriodId] FOREIGN KEY ([ReportingPeriodId]) REFERENCES [dbo].[ReportingPeriods] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Activities_Users_ReviewerId] FOREIGN KEY ([ReviewerId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_Activities_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_DescriptionId]
    ON [dbo].[Activities]([DescriptionId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ReportingPeriodId]
    ON [dbo].[Activities]([ReportingPeriodId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ReviewerId]
    ON [dbo].[Activities]([ReviewerId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[Activities]([UserId] ASC);

