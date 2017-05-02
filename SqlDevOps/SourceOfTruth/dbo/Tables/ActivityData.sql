CREATE TABLE [dbo].[ActivityData] (
    [Id]                    BIGINT         IDENTITY (1, 1) NOT NULL,
    [FieldName]             NVARCHAR (150) NOT NULL,
    [DataType]              INT            NOT NULL,
    [ActivityDescriptionId] BIGINT         NOT NULL,
    [TenantId]              INT            DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_dbo.ActivityData] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.ActivityData_dbo.ActivityDescriptions_ActivityDescriptionId] FOREIGN KEY ([ActivityDescriptionId]) REFERENCES [dbo].[ActivityDescriptions] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_ActivityDescriptionId]
    ON [dbo].[ActivityData]([ActivityDescriptionId] ASC);

