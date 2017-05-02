-- <Migration ID="6e98b879-b3e3-475c-8959-31f01063c1ca" />
GO

PRINT N'Creating [dbo].[Users]'
GO
CREATE TABLE [dbo].[Users]
(
[UserId] [bigint] NOT NULL IDENTITY(1, 1),
[Username] [nvarchar] (100) NOT NULL,
[FirstName] [nvarchar] (100) NOT NULL,
[LastName] [nvarchar] (100) NOT NULL,
[DisplayName] [nvarchar] (100) NOT NULL,
[Email] [nvarchar] (100) NOT NULL,
[Source] [nvarchar] (4) NOT NULL,
[PasswordHash] [nvarchar] (86) NOT NULL,
[PasswordSalt] [nvarchar] (10) NOT NULL,
[LastDirectoryUpdate] [datetime] NULL,
[UserImage] [nvarchar] (100) NULL,
[InsertDate] [datetime] NOT NULL,
[InsertUserId] [int] NOT NULL,
[UpdateDate] [datetime] NULL,
[UpdateUserId] [int] NULL,
[IsActive] [smallint] NOT NULL CONSTRAINT [DF_Users_IsActive] DEFAULT ((1)),
[TenantId] [int] NOT NULL CONSTRAINT [DF_Users_TenantId] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_Users] on [dbo].[Users]'
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED  ([UserId])
GO
PRINT N'Creating [dbo].[ReportingPeriods]'
GO
CREATE TABLE [dbo].[ReportingPeriods]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[StartDate] [datetime] NOT NULL,
[EndDate] [datetime] NOT NULL,
[Grace] [int] NOT NULL,
[Name] [varchar] (100) NOT NULL,
[CompanyId] [bigint] NOT NULL,
[TenantId] [int] NOT NULL CONSTRAINT [DF__Reporting__Tenan__4E88ABD4] DEFAULT ((1)),
[Active] AS (case  when getdate()<=dateadd(day,[Grace],[ENDDATE]) AND getdate()>=[StartDate] then (1) else (0) end)
)
GO
PRINT N'Creating primary key [PK_dbo.ReportingPeriods] on [dbo].[ReportingPeriods]'
GO
ALTER TABLE [dbo].[ReportingPeriods] ADD CONSTRAINT [PK_dbo.ReportingPeriods] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_CompanyId] on [dbo].[ReportingPeriods]'
GO
CREATE NONCLUSTERED INDEX [IX_CompanyId] ON [dbo].[ReportingPeriods] ([CompanyId])
GO
PRINT N'Creating [dbo].[ActivityDescriptions]'
GO
CREATE TABLE [dbo].[ActivityDescriptions]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (150) NOT NULL,
[OccuranceName] [nvarchar] (75) NULL,
[PointsPerOccurance] [int] NOT NULL,
[MaxOccurancesPerPeriod] [int] NOT NULL,
[AreaId] [bigint] NOT NULL,
[IsActive] [bit] NOT NULL,
[TenantId] [int] NOT NULL CONSTRAINT [DF__ActivityD__Tenan__48CFD27E] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_dbo.ActivityDescriptions] on [dbo].[ActivityDescriptions]'
GO
ALTER TABLE [dbo].[ActivityDescriptions] ADD CONSTRAINT [PK_dbo.ActivityDescriptions] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_AreaId] on [dbo].[ActivityDescriptions]'
GO
CREATE NONCLUSTERED INDEX [IX_AreaId] ON [dbo].[ActivityDescriptions] ([AreaId])
GO
PRINT N'Creating [dbo].[ActivityAreas]'
GO
CREATE TABLE [dbo].[ActivityAreas]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (150) NOT NULL,
[Description] [nvarchar] (500) NULL,
[CompanyId] [bigint] NOT NULL,
[IsActive] [bit] NOT NULL,
[TenantId] [int] NOT NULL CONSTRAINT [DF__ActivityA__Tenan__46E78A0C] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_dbo.ActivityAreas] on [dbo].[ActivityAreas]'
GO
ALTER TABLE [dbo].[ActivityAreas] ADD CONSTRAINT [PK_dbo.ActivityAreas] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_CompanyId] on [dbo].[ActivityAreas]'
GO
CREATE NONCLUSTERED INDEX [IX_CompanyId] ON [dbo].[ActivityAreas] ([CompanyId])
GO
PRINT N'Creating [dbo].[Activities]'
GO
CREATE TABLE [dbo].[Activities]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[DescriptionId] [bigint] NOT NULL,
[Notes] [nvarchar] (4000) NULL,
[ReportingPeriodId] [bigint] NOT NULL,
[ActivityDate] [datetime] NOT NULL,
[Quantity] [int] NOT NULL,
[ReportedPoints] [int] NOT NULL,
[ReviewNotes] [nvarchar] (4000) NULL,
[AdjustedPoints] [int] NULL,
[ReviewedDate] [datetime] NULL,
[ReviewerId] [bigint] NULL,
[UserId] [bigint] NOT NULL,
[AreaId] [bigint] NOT NULL,
[TenantId] [int] NOT NULL CONSTRAINT [DF__Activitie__Tenan__45F365D3] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_Activities] on [dbo].[Activities]'
GO
ALTER TABLE [dbo].[Activities] ADD CONSTRAINT [PK_Activities] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_DescriptionId] on [dbo].[Activities]'
GO
CREATE NONCLUSTERED INDEX [IX_DescriptionId] ON [dbo].[Activities] ([DescriptionId])
GO
PRINT N'Creating index [IX_ReportingPeriodId] on [dbo].[Activities]'
GO
CREATE NONCLUSTERED INDEX [IX_ReportingPeriodId] ON [dbo].[Activities] ([ReportingPeriodId])
GO
PRINT N'Creating index [IX_ReviewerId] on [dbo].[Activities]'
GO
CREATE NONCLUSTERED INDEX [IX_ReviewerId] ON [dbo].[Activities] ([ReviewerId])
GO
PRINT N'Creating index [IX_UserId] on [dbo].[Activities]'
GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[Activities] ([UserId])
GO
PRINT N'Creating [dbo].[ActivityReport]'
GO
CREATE VIEW [dbo].[ActivityReport]
	AS 
Select rp.Name as ReportingPeriodName, aa.Name as AreaName, ad.Name as ActivityName, u.DisplayName as UserName, Count(a.Id) as ActivityCount, Sum(a.ReportedPoints) as TotalReported, Sum(a.AdjustedPoints) as TotalAdjusted, a.TenantId From Activities a
INNER JOIN ReportingPeriods rp on a.ReportingPeriodId = rp.Id
INNER JOIN ActivityAreas aa on a.AreaId = aa.Id
INNER JOIN ActivityDescriptions ad on a.DescriptionId = ad.Id
INNER JOIN Users as u on a.UserId = u.UserId
GROUP BY rp.Name, aa.Name, ad.Name, a.UserId, u.DisplayName, a.TenantId
GO
PRINT N'Creating [dbo].[ActivityData]'
GO
CREATE TABLE [dbo].[ActivityData]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[FieldName] [nvarchar] (150) NOT NULL,
[DataType] [int] NOT NULL,
[ActivityDescriptionId] [bigint] NOT NULL,
[TenantId] [int] NOT NULL CONSTRAINT [DF__ActivityD__Tenan__47DBAE45] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_dbo.ActivityData] on [dbo].[ActivityData]'
GO
ALTER TABLE [dbo].[ActivityData] ADD CONSTRAINT [PK_dbo.ActivityData] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_ActivityDescriptionId] on [dbo].[ActivityData]'
GO
CREATE NONCLUSTERED INDEX [IX_ActivityDescriptionId] ON [dbo].[ActivityData] ([ActivityDescriptionId])
GO
PRINT N'Creating [dbo].[Addresses]'
GO
CREATE TABLE [dbo].[Addresses]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[AddressOne] [nvarchar] (100) NOT NULL,
[AddressTwo] [nvarchar] (100) NULL,
[StateId] [int] NOT NULL,
[City] [nvarchar] (75) NOT NULL,
[ZipCode] [nvarchar] (10) NOT NULL,
[AddressId] [bigint] NOT NULL,
[TenantId] [int] NOT NULL CONSTRAINT [DF__Addresses__Tenan__49C3F6B7] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_dbo.Addresses] on [dbo].[Addresses]'
GO
ALTER TABLE [dbo].[Addresses] ADD CONSTRAINT [PK_dbo.Addresses] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_AddressId] on [dbo].[Addresses]'
GO
CREATE NONCLUSTERED INDEX [IX_AddressId] ON [dbo].[Addresses] ([AddressId])
GO
PRINT N'Creating [dbo].[Companies]'
GO
CREATE TABLE [dbo].[Companies]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (150) NOT NULL,
[TenantId] [int] NOT NULL CONSTRAINT [DF__Companies__Tenan__4AB81AF0] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_dbo.Companies] on [dbo].[Companies]'
GO
ALTER TABLE [dbo].[Companies] ADD CONSTRAINT [PK_dbo.Companies] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating [dbo].[Exceptions]'
GO
CREATE TABLE [dbo].[Exceptions]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[GUID] [uniqueidentifier] NOT NULL,
[ApplicationName] [nvarchar] (50) NOT NULL,
[MachineName] [nvarchar] (50) NOT NULL,
[CreationDate] [datetime] NOT NULL,
[Type] [nvarchar] (100) NOT NULL,
[IsProtected] [bit] NOT NULL CONSTRAINT [DF_Exceptions_IsProtected] DEFAULT ((1)),
[Host] [nvarchar] (100) NULL,
[Url] [nvarchar] (500) NULL,
[HTTPMethod] [nvarchar] (10) NULL,
[IPAddress] [nvarchar] (40) NULL,
[Source] [nvarchar] (100) NULL,
[Message] [nvarchar] (1000) NULL,
[Detail] [nvarchar] (max) NULL,
[StatusCode] [int] NULL,
[SQL] [nvarchar] (max) NULL,
[DeletionDate] [datetime] NULL,
[FullJson] [nvarchar] (max) NULL,
[ErrorHash] [int] NULL,
[DuplicateCount] [int] NOT NULL CONSTRAINT [DF_Exceptions_DuplicateCount] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_Exceptions] on [dbo].[Exceptions]'
GO
ALTER TABLE [dbo].[Exceptions] ADD CONSTRAINT [PK_Exceptions] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_Exceptions_App_Del_Cre] on [dbo].[Exceptions]'
GO
CREATE NONCLUSTERED INDEX [IX_Exceptions_App_Del_Cre] ON [dbo].[Exceptions] ([ApplicationName], [DeletionDate], [CreationDate] DESC)
GO
PRINT N'Creating index [IX_Exceptions_Hash_App_Cre_Del] on [dbo].[Exceptions]'
GO
CREATE NONCLUSTERED INDEX [IX_Exceptions_Hash_App_Cre_Del] ON [dbo].[Exceptions] ([ErrorHash], [ApplicationName], [CreationDate] DESC, [DeletionDate])
GO
PRINT N'Creating index [IX_Exceptions_GUID_App_Del_Cre] on [dbo].[Exceptions]'
GO
CREATE NONCLUSTERED INDEX [IX_Exceptions_GUID_App_Del_Cre] ON [dbo].[Exceptions] ([GUID], [ApplicationName], [DeletionDate], [CreationDate] DESC)
GO
PRINT N'Creating [dbo].[Languages]'
GO
CREATE TABLE [dbo].[Languages]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[LanguageId] [nvarchar] (10) NOT NULL,
[LanguageName] [nvarchar] (50) NOT NULL,
[TenantId] [int] NOT NULL CONSTRAINT [DF_Languages_TenantId] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_Languages] on [dbo].[Languages]'
GO
ALTER TABLE [dbo].[Languages] ADD CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating [dbo].[Roles]'
GO
CREATE TABLE [dbo].[Roles]
(
[RoleId] [bigint] NOT NULL IDENTITY(1, 1),
[RoleName] [nvarchar] (100) NOT NULL,
[TenantId] [int] NOT NULL CONSTRAINT [DF_Roles_TenantId] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_Roles] on [dbo].[Roles]'
GO
ALTER TABLE [dbo].[Roles] ADD CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED  ([RoleId])
GO
PRINT N'Creating [dbo].[UserPermissions]'
GO
CREATE TABLE [dbo].[UserPermissions]
(
[UserPermissionId] [bigint] NOT NULL IDENTITY(1, 1),
[UserId] [bigint] NOT NULL,
[PermissionKey] [nvarchar] (100) NOT NULL,
[Granted] [bit] NOT NULL CONSTRAINT [DF_UserPermissions_Granted] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_UserPermissions] on [dbo].[UserPermissions]'
GO
ALTER TABLE [dbo].[UserPermissions] ADD CONSTRAINT [PK_UserPermissions] PRIMARY KEY CLUSTERED  ([UserPermissionId])
GO
PRINT N'Creating index [UQ_UserPerm_UserId_PermKey] on [dbo].[UserPermissions]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_UserPerm_UserId_PermKey] ON [dbo].[UserPermissions] ([UserId], [PermissionKey])
GO
PRINT N'Creating [dbo].[States]'
GO
CREATE TABLE [dbo].[States]
(
[Id] [int] NOT NULL,
[Name] [nvarchar] (50) NOT NULL,
[Abbr] [nvarchar] (2) NOT NULL
)
GO
PRINT N'Creating primary key [PK__States__3214EC07BABCC2DF] on [dbo].[States]'
GO
ALTER TABLE [dbo].[States] ADD CONSTRAINT [PK__States__3214EC07BABCC2DF] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating [dbo].[Teams]'
GO
CREATE TABLE [dbo].[Teams]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (150) NOT NULL,
[CompanyId] [bigint] NOT NULL,
[TenantId] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK_dbo.Teams] on [dbo].[Teams]'
GO
ALTER TABLE [dbo].[Teams] ADD CONSTRAINT [PK_dbo.Teams] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_CompanyId] on [dbo].[Teams]'
GO
CREATE NONCLUSTERED INDEX [IX_CompanyId] ON [dbo].[Teams] ([CompanyId])
GO
PRINT N'Creating [dbo].[RolePermissions]'
GO
CREATE TABLE [dbo].[RolePermissions]
(
[RolePermissionId] [bigint] NOT NULL IDENTITY(1, 1),
[RoleId] [bigint] NOT NULL,
[PermissionKey] [nvarchar] (100) NOT NULL
)
GO
PRINT N'Creating primary key [PK_RolePermissions] on [dbo].[RolePermissions]'
GO
ALTER TABLE [dbo].[RolePermissions] ADD CONSTRAINT [PK_RolePermissions] PRIMARY KEY CLUSTERED  ([RolePermissionId])
GO
PRINT N'Creating index [UQ_RolePerm_RoleId_PermKey] on [dbo].[RolePermissions]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_RolePerm_RoleId_PermKey] ON [dbo].[RolePermissions] ([RoleId], [PermissionKey])
GO
PRINT N'Creating [dbo].[UserRoles]'
GO
CREATE TABLE [dbo].[UserRoles]
(
[UserRoleId] [bigint] NOT NULL IDENTITY(1, 1),
[UserId] [bigint] NOT NULL,
[RoleId] [bigint] NOT NULL
)
GO
PRINT N'Creating primary key [PK_UserRoles] on [dbo].[UserRoles]'
GO
ALTER TABLE [dbo].[UserRoles] ADD CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED  ([UserRoleId])
GO
PRINT N'Creating index [IX_UserRoles_RoleId_UserId] on [dbo].[UserRoles]'
GO
CREATE NONCLUSTERED INDEX [IX_UserRoles_RoleId_UserId] ON [dbo].[UserRoles] ([RoleId], [UserId])
GO
PRINT N'Creating index [UQ_UserRoles_UserId_RoleId] on [dbo].[UserRoles]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_UserRoles_UserId_RoleId] ON [dbo].[UserRoles] ([UserId], [RoleId])
GO
PRINT N'Creating [dbo].[UserTeams]'
GO
CREATE TABLE [dbo].[UserTeams]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[UserId] [bigint] NOT NULL,
[TeamId] [bigint] NOT NULL
)
GO
PRINT N'Creating primary key [PK__UserTeam__3214EC074B8704EB] on [dbo].[UserTeams]'
GO
ALTER TABLE [dbo].[UserTeams] ADD CONSTRAINT [PK__UserTeam__3214EC074B8704EB] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_UserTeams] on [dbo].[UserTeams]'
GO
CREATE NONCLUSTERED INDEX [IX_UserTeams] ON [dbo].[UserTeams] ([UserId], [TeamId])
GO
PRINT N'Creating [dbo].[Tenants]'
GO
CREATE TABLE [dbo].[Tenants]
(
[TenantId] [int] NOT NULL IDENTITY(1, 1),
[TenantName] [nvarchar] (100) NOT NULL
)
GO
PRINT N'Creating primary key [PK_Tenants] on [dbo].[Tenants]'
GO
ALTER TABLE [dbo].[Tenants] ADD CONSTRAINT [PK_Tenants] PRIMARY KEY CLUSTERED  ([TenantId])
GO
PRINT N'Creating [dbo].[UserPreferences]'
GO
CREATE TABLE [dbo].[UserPreferences]
(
[UserPreferenceId] [int] NOT NULL IDENTITY(1, 1),
[UserId] [bigint] NOT NULL,
[PreferenceType] [nvarchar] (100) NOT NULL,
[Name] [nvarchar] (200) NOT NULL,
[Value] [nvarchar] (max) NULL
)
GO
PRINT N'Creating primary key [PK_UserPreferences] on [dbo].[UserPreferences]'
GO
ALTER TABLE [dbo].[UserPreferences] ADD CONSTRAINT [PK_UserPreferences] PRIMARY KEY CLUSTERED  ([UserPreferenceId])
GO
PRINT N'Creating index [IX_UserPref_UID_PrefType_Name] on [dbo].[UserPreferences]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserPref_UID_PrefType_Name] ON [dbo].[UserPreferences] ([UserId], [PreferenceType], [Name])
GO
PRINT N'Adding foreign keys to [dbo].[Activities]'
GO
ALTER TABLE [dbo].[Activities] ADD CONSTRAINT [FK_Activities_ActivityDescriptions_DescriptionId] FOREIGN KEY ([DescriptionId]) REFERENCES [dbo].[ActivityDescriptions] ([Id])
GO
ALTER TABLE [dbo].[Activities] ADD CONSTRAINT [FK_Activities_ReportingPeriods_ReportingPeriodId] FOREIGN KEY ([ReportingPeriodId]) REFERENCES [dbo].[ReportingPeriods] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Activities] ADD CONSTRAINT [FK_Activities_Users_ReviewerId] FOREIGN KEY ([ReviewerId]) REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Activities] ADD CONSTRAINT [FK_Activities_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Activities] ADD CONSTRAINT [FK_Activities_ActivityAreas_AreaId] FOREIGN KEY ([AreaId]) REFERENCES [dbo].[ActivityAreas] ([Id])
GO
PRINT N'Adding foreign keys to [dbo].[ActivityDescriptions]'
GO
ALTER TABLE [dbo].[ActivityDescriptions] ADD CONSTRAINT [FK_dbo.ActivityDescriptions_dbo.ActivityAreas_AreaId] FOREIGN KEY ([AreaId]) REFERENCES [dbo].[ActivityAreas] ([Id])
GO
PRINT N'Adding foreign keys to [dbo].[ActivityAreas]'
GO
ALTER TABLE [dbo].[ActivityAreas] ADD CONSTRAINT [FK_dbo.ActivityAreas_dbo.Companies_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Companies] ([Id])
GO
PRINT N'Adding foreign keys to [dbo].[ActivityData]'
GO
ALTER TABLE [dbo].[ActivityData] ADD CONSTRAINT [FK_dbo.ActivityData_dbo.ActivityDescriptions_ActivityDescriptionId] FOREIGN KEY ([ActivityDescriptionId]) REFERENCES [dbo].[ActivityDescriptions] ([Id]) ON DELETE CASCADE
GO
PRINT N'Adding foreign keys to [dbo].[Addresses]'
GO
ALTER TABLE [dbo].[Addresses] ADD CONSTRAINT [FK_Addresses_State] FOREIGN KEY ([StateId]) REFERENCES [dbo].[States] ([Id])
GO
ALTER TABLE [dbo].[Addresses] ADD CONSTRAINT [FK_dbo.Addresses_dbo.Companies_AddressId] FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Companies] ([Id])
GO
PRINT N'Adding foreign keys to [dbo].[ReportingPeriods]'
GO
ALTER TABLE [dbo].[ReportingPeriods] ADD CONSTRAINT [FK_dbo.ReportingPeriods_dbo.Companies_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Companies] ([Id])
GO
PRINT N'Adding foreign keys to [dbo].[Teams]'
GO
ALTER TABLE [dbo].[Teams] ADD CONSTRAINT [FK_dbo.Teams_dbo.Companies_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Companies] ([Id])
GO
PRINT N'Adding foreign keys to [dbo].[RolePermissions]'
GO
ALTER TABLE [dbo].[RolePermissions] ADD CONSTRAINT [FK_RolePermissions_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId])
GO
PRINT N'Adding foreign keys to [dbo].[UserRoles]'
GO
ALTER TABLE [dbo].[UserRoles] ADD CONSTRAINT [FK_UserRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[UserRoles] ADD CONSTRAINT [FK_UserRoles_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
PRINT N'Adding foreign keys to [dbo].[UserTeams]'
GO
ALTER TABLE [dbo].[UserTeams] ADD CONSTRAINT [FK_UserTeams_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[Teams] ([Id])
GO
ALTER TABLE [dbo].[UserTeams] ADD CONSTRAINT [FK_UserTeams_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
PRINT N'Adding foreign keys to [dbo].[UserPermissions]'
GO
ALTER TABLE [dbo].[UserPermissions] ADD CONSTRAINT [FK_UserPermissions_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
