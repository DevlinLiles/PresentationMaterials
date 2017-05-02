CREATE TABLE [dbo].[Addresses] (
    [Id]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [AddressOne] NVARCHAR (100) NOT NULL,
    [AddressTwo] NVARCHAR (100) NULL,
    [StateId]    INT            NOT NULL,
    [City]       NVARCHAR (75)  NOT NULL,
    [ZipCode]    NVARCHAR (10)  NOT NULL,
    [AddressId]  BIGINT         NOT NULL,
    [TenantId]   INT            DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_dbo.Addresses] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Addresses_State] FOREIGN KEY ([StateId]) REFERENCES [dbo].[States] ([Id]),
    CONSTRAINT [FK_dbo.Addresses_dbo.Companies_AddressId] FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Companies] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_AddressId]
    ON [dbo].[Addresses]([AddressId] ASC);

