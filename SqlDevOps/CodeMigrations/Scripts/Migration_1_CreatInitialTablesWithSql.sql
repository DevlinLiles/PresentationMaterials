/*
Deployment script for SourceOfTruth-Dev

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "SourceOfTruth-Dev"
:setvar DefaultFilePrefix "SourceOfTruth-Dev"
:setvar DefaultDataPath "C:\Users\capsc\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLOCALDB"
:setvar DefaultLogPath "C:\Users\capsc\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLOCALDB"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
USE [$(DatabaseName)];


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
ALTER DATABASE [$(DatabaseName)]
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

GO
PRINT N'Creating [dbo].[Activities]...';


GO
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
    [TenantId]          INT             NOT NULL,
    CONSTRAINT [PK_Activities] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Activities].[IX_DescriptionId]...';


GO
CREATE NONCLUSTERED INDEX [IX_DescriptionId]
    ON [dbo].[Activities]([DescriptionId] ASC);


GO
PRINT N'Creating [dbo].[Activities].[IX_ReportingPeriodId]...';


GO
CREATE NONCLUSTERED INDEX [IX_ReportingPeriodId]
    ON [dbo].[Activities]([ReportingPeriodId] ASC);


GO
PRINT N'Creating [dbo].[Activities].[IX_ReviewerId]...';


GO
CREATE NONCLUSTERED INDEX [IX_ReviewerId]
    ON [dbo].[Activities]([ReviewerId] ASC);


GO
PRINT N'Creating [dbo].[Activities].[IX_UserId]...';


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[Activities]([UserId] ASC);


GO
PRINT N'Creating [dbo].[ActivityAreas]...';


GO
CREATE TABLE [dbo].[ActivityAreas] (
    [Id]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (150) NOT NULL,
    [Description] NVARCHAR (500) NULL,
    [CompanyId]   BIGINT         NOT NULL,
    [IsActive]    BIT            NOT NULL,
    [TenantId]    INT            NOT NULL,
    CONSTRAINT [PK_dbo.ActivityAreas] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[ActivityAreas].[IX_CompanyId]...';


GO
CREATE NONCLUSTERED INDEX [IX_CompanyId]
    ON [dbo].[ActivityAreas]([CompanyId] ASC);


GO
PRINT N'Creating [dbo].[ActivityData]...';


GO
CREATE TABLE [dbo].[ActivityData] (
    [Id]                    BIGINT         IDENTITY (1, 1) NOT NULL,
    [FieldName]             NVARCHAR (150) NOT NULL,
    [DataType]              INT            NOT NULL,
    [ActivityDescriptionId] BIGINT         NOT NULL,
    [TenantId]              INT            NOT NULL,
    CONSTRAINT [PK_dbo.ActivityData] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[ActivityData].[IX_ActivityDescriptionId]...';


GO
CREATE NONCLUSTERED INDEX [IX_ActivityDescriptionId]
    ON [dbo].[ActivityData]([ActivityDescriptionId] ASC);


GO
PRINT N'Creating [dbo].[ActivityDescriptions]...';


GO
CREATE TABLE [dbo].[ActivityDescriptions] (
    [Id]                     BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]                   NVARCHAR (150) NOT NULL,
    [OccuranceName]          NVARCHAR (75)  NULL,
    [PointsPerOccurance]     INT            NOT NULL,
    [MaxOccurancesPerPeriod] INT            NOT NULL,
    [AreaId]                 BIGINT         NOT NULL,
    [IsActive]               BIT            NOT NULL,
    [TenantId]               INT            NOT NULL,
    CONSTRAINT [PK_dbo.ActivityDescriptions] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[ActivityDescriptions].[IX_AreaId]...';


GO
CREATE NONCLUSTERED INDEX [IX_AreaId]
    ON [dbo].[ActivityDescriptions]([AreaId] ASC);


GO
PRINT N'Creating [dbo].[Addresses]...';


GO
CREATE TABLE [dbo].[Addresses] (
    [Id]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [AddressOne] NVARCHAR (100) NOT NULL,
    [AddressTwo] NVARCHAR (100) NULL,
    [StateId]    INT            NOT NULL,
    [City]       NVARCHAR (75)  NOT NULL,
    [ZipCode]    NVARCHAR (10)  NOT NULL,
    [AddressId]  BIGINT         NOT NULL,
    [TenantId]   INT            NOT NULL,
    CONSTRAINT [PK_dbo.Addresses] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Addresses].[IX_AddressId]...';


GO
CREATE NONCLUSTERED INDEX [IX_AddressId]
    ON [dbo].[Addresses]([AddressId] ASC);


GO
PRINT N'Creating [dbo].[Companies]...';


GO
CREATE TABLE [dbo].[Companies] (
    [Id]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]     NVARCHAR (150) NOT NULL,
    [TenantId] INT            NOT NULL,
    CONSTRAINT [PK_dbo.Companies] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Exceptions]...';


GO
CREATE TABLE [dbo].[Exceptions] (
    [Id]              BIGINT           IDENTITY (1, 1) NOT NULL,
    [GUID]            UNIQUEIDENTIFIER NOT NULL,
    [ApplicationName] NVARCHAR (50)    NOT NULL,
    [MachineName]     NVARCHAR (50)    NOT NULL,
    [CreationDate]    DATETIME         NOT NULL,
    [Type]            NVARCHAR (100)   NOT NULL,
    [IsProtected]     BIT              NOT NULL,
    [Host]            NVARCHAR (100)   NULL,
    [Url]             NVARCHAR (500)   NULL,
    [HTTPMethod]      NVARCHAR (10)    NULL,
    [IPAddress]       NVARCHAR (40)    NULL,
    [Source]          NVARCHAR (100)   NULL,
    [Message]         NVARCHAR (1000)  NULL,
    [Detail]          NVARCHAR (MAX)   NULL,
    [StatusCode]      INT              NULL,
    [SQL]             NVARCHAR (MAX)   NULL,
    [DeletionDate]    DATETIME         NULL,
    [FullJson]        NVARCHAR (MAX)   NULL,
    [ErrorHash]       INT              NULL,
    [DuplicateCount]  INT              NOT NULL,
    CONSTRAINT [PK_Exceptions] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Exceptions].[IX_Exceptions_GUID_App_Del_Cre]...';


GO
CREATE NONCLUSTERED INDEX [IX_Exceptions_GUID_App_Del_Cre]
    ON [dbo].[Exceptions]([GUID] ASC, [ApplicationName] ASC, [DeletionDate] ASC, [CreationDate] DESC);


GO
PRINT N'Creating [dbo].[Exceptions].[IX_Exceptions_Hash_App_Cre_Del]...';


GO
CREATE NONCLUSTERED INDEX [IX_Exceptions_Hash_App_Cre_Del]
    ON [dbo].[Exceptions]([ErrorHash] ASC, [ApplicationName] ASC, [CreationDate] DESC, [DeletionDate] ASC);


GO
PRINT N'Creating [dbo].[Exceptions].[IX_Exceptions_App_Del_Cre]...';


GO
CREATE NONCLUSTERED INDEX [IX_Exceptions_App_Del_Cre]
    ON [dbo].[Exceptions]([ApplicationName] ASC, [DeletionDate] ASC, [CreationDate] DESC);


GO
PRINT N'Creating [dbo].[Languages]...';


GO
CREATE TABLE [dbo].[Languages] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [LanguageId]   NVARCHAR (10) NOT NULL,
    [LanguageName] NVARCHAR (50) NOT NULL,
    [TenantId]     INT           NOT NULL,
    CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[ReportingPeriods]...';


GO
CREATE TABLE [dbo].[ReportingPeriods] (
    [Id]        BIGINT        IDENTITY (1, 1) NOT NULL,
    [StartDate] DATETIME      NOT NULL,
    [EndDate]   DATETIME      NOT NULL,
    [Grace]     INT           NOT NULL,
    [Name]      VARCHAR (100) NOT NULL,
    [CompanyId] BIGINT        NOT NULL,
    [TenantId]  INT           NOT NULL,
    [Active]    AS            (CASE WHEN getdate() <= dateadd(day, [Grace], [ENDDATE])
                                         AND getdate() >= [StartDate] THEN (1) ELSE (0) END),
    CONSTRAINT [PK_dbo.ReportingPeriods] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[ReportingPeriods].[IX_CompanyId]...';


GO
CREATE NONCLUSTERED INDEX [IX_CompanyId]
    ON [dbo].[ReportingPeriods]([CompanyId] ASC);


GO
PRINT N'Creating [dbo].[RolePermissions]...';


GO
CREATE TABLE [dbo].[RolePermissions] (
    [RolePermissionId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [RoleId]           BIGINT         NOT NULL,
    [PermissionKey]    NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_RolePermissions] PRIMARY KEY CLUSTERED ([RolePermissionId] ASC)
);


GO
PRINT N'Creating [dbo].[RolePermissions].[UQ_RolePerm_RoleId_PermKey]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_RolePerm_RoleId_PermKey]
    ON [dbo].[RolePermissions]([RoleId] ASC, [PermissionKey] ASC);


GO
PRINT N'Creating [dbo].[Roles]...';


GO
CREATE TABLE [dbo].[Roles] (
    [RoleId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [RoleName] NVARCHAR (100) NOT NULL,
    [TenantId] INT            NOT NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([RoleId] ASC)
);


GO
PRINT N'Creating [dbo].[States]...';


GO
CREATE TABLE [dbo].[States] (
    [Id]   INT           NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [Abbr] NVARCHAR (2)  NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Teams]...';


GO
CREATE TABLE [dbo].[Teams] (
    [Id]        BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (150) NOT NULL,
    [CompanyId] BIGINT         NOT NULL,
    [TenantId]  INT            NOT NULL,
    CONSTRAINT [PK_dbo.Teams] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Teams].[IX_CompanyId]...';


GO
CREATE NONCLUSTERED INDEX [IX_CompanyId]
    ON [dbo].[Teams]([CompanyId] ASC);


GO
PRINT N'Creating [dbo].[Tenants]...';


GO
CREATE TABLE [dbo].[Tenants] (
    [TenantId]   INT            IDENTITY (1, 1) NOT NULL,
    [TenantName] NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Tenants] PRIMARY KEY CLUSTERED ([TenantId] ASC)
);


GO
PRINT N'Creating [dbo].[UserPermissions]...';


GO
CREATE TABLE [dbo].[UserPermissions] (
    [UserPermissionId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserId]           BIGINT         NOT NULL,
    [PermissionKey]    NVARCHAR (100) NOT NULL,
    [Granted]          BIT            NOT NULL,
    CONSTRAINT [PK_UserPermissions] PRIMARY KEY CLUSTERED ([UserPermissionId] ASC)
);


GO
PRINT N'Creating [dbo].[UserPermissions].[UQ_UserPerm_UserId_PermKey]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_UserPerm_UserId_PermKey]
    ON [dbo].[UserPermissions]([UserId] ASC, [PermissionKey] ASC);


GO
PRINT N'Creating [dbo].[UserPreferences]...';


GO
CREATE TABLE [dbo].[UserPreferences] (
    [UserPreferenceId] INT            IDENTITY (1, 1) NOT NULL,
    [UserId]           BIGINT         NOT NULL,
    [PreferenceType]   NVARCHAR (100) NOT NULL,
    [Name]             NVARCHAR (200) NOT NULL,
    [Value]            NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_UserPreferences] PRIMARY KEY CLUSTERED ([UserPreferenceId] ASC)
);


GO
PRINT N'Creating [dbo].[UserPreferences].[IX_UserPref_UID_PrefType_Name]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserPref_UID_PrefType_Name]
    ON [dbo].[UserPreferences]([UserId] ASC, [PreferenceType] ASC, [Name] ASC);


GO
PRINT N'Creating [dbo].[UserRoles]...';


GO
CREATE TABLE [dbo].[UserRoles] (
    [UserRoleId] BIGINT IDENTITY (1, 1) NOT NULL,
    [UserId]     BIGINT NOT NULL,
    [RoleId]     BIGINT NOT NULL,
    CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED ([UserRoleId] ASC)
);


GO
PRINT N'Creating [dbo].[UserRoles].[UQ_UserRoles_UserId_RoleId]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_UserRoles_UserId_RoleId]
    ON [dbo].[UserRoles]([UserId] ASC, [RoleId] ASC);


GO
PRINT N'Creating [dbo].[UserRoles].[IX_UserRoles_RoleId_UserId]...';


GO
CREATE NONCLUSTERED INDEX [IX_UserRoles_RoleId_UserId]
    ON [dbo].[UserRoles]([RoleId] ASC, [UserId] ASC);


GO
PRINT N'Creating [dbo].[Users]...';


GO
CREATE TABLE [dbo].[Users] (
    [UserId]              BIGINT         IDENTITY (1, 1) NOT NULL,
    [Username]            NVARCHAR (100) NOT NULL,
    [FirstName]           NVARCHAR (100) NOT NULL,
    [LastName]            NVARCHAR (100) NOT NULL,
    [DisplayName]         NVARCHAR (100) NOT NULL,
    [Email]               NVARCHAR (100) NOT NULL,
    [Source]              NVARCHAR (4)   NOT NULL,
    [PasswordHash]        NVARCHAR (86)  NOT NULL,
    [PasswordSalt]        NVARCHAR (10)  NOT NULL,
    [LastDirectoryUpdate] DATETIME       NULL,
    [UserImage]           NVARCHAR (100) NULL,
    [InsertDate]          DATETIME       NOT NULL,
    [InsertUserId]        INT            NOT NULL,
    [UpdateDate]          DATETIME       NULL,
    [UpdateUserId]        INT            NULL,
    [IsActive]            SMALLINT       NOT NULL,
    [TenantId]            INT            NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserId] ASC)
);


GO
PRINT N'Creating [dbo].[UserTeams]...';


GO
CREATE TABLE [dbo].[UserTeams] (
    [Id]     BIGINT IDENTITY (1, 1) NOT NULL,
    [UserId] BIGINT NOT NULL,
    [TeamId] BIGINT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[UserTeams].[IX_UserTeams]...';


GO
CREATE NONCLUSTERED INDEX [IX_UserTeams]
    ON [dbo].[UserTeams]([UserId] ASC, [TeamId] ASC);


GO
PRINT N'Creating unnamed constraint on [dbo].[Activities]...';


GO
ALTER TABLE [dbo].[Activities]
    ADD DEFAULT ((1)) FOR [TenantId];


GO
PRINT N'Creating unnamed constraint on [dbo].[ActivityAreas]...';


GO
ALTER TABLE [dbo].[ActivityAreas]
    ADD DEFAULT ((1)) FOR [TenantId];


GO
PRINT N'Creating unnamed constraint on [dbo].[ActivityData]...';


GO
ALTER TABLE [dbo].[ActivityData]
    ADD DEFAULT ((1)) FOR [TenantId];


GO
PRINT N'Creating unnamed constraint on [dbo].[ActivityDescriptions]...';


GO
ALTER TABLE [dbo].[ActivityDescriptions]
    ADD DEFAULT ((1)) FOR [TenantId];


GO
PRINT N'Creating unnamed constraint on [dbo].[Addresses]...';


GO
ALTER TABLE [dbo].[Addresses]
    ADD DEFAULT ((1)) FOR [TenantId];


GO
PRINT N'Creating unnamed constraint on [dbo].[Companies]...';


GO
ALTER TABLE [dbo].[Companies]
    ADD DEFAULT ((1)) FOR [TenantId];


GO
PRINT N'Creating [dbo].[DF_Exceptions_IsProtected]...';


GO
ALTER TABLE [dbo].[Exceptions]
    ADD CONSTRAINT [DF_Exceptions_IsProtected] DEFAULT ((1)) FOR [IsProtected];


GO
PRINT N'Creating [dbo].[DF_Exceptions_DuplicateCount]...';


GO
ALTER TABLE [dbo].[Exceptions]
    ADD CONSTRAINT [DF_Exceptions_DuplicateCount] DEFAULT ((1)) FOR [DuplicateCount];


GO
PRINT N'Creating [dbo].[DF_Languages_TenantId]...';


GO
ALTER TABLE [dbo].[Languages]
    ADD CONSTRAINT [DF_Languages_TenantId] DEFAULT ((1)) FOR [TenantId];


GO
PRINT N'Creating unnamed constraint on [dbo].[ReportingPeriods]...';


GO
ALTER TABLE [dbo].[ReportingPeriods]
    ADD DEFAULT ((1)) FOR [TenantId];


GO
PRINT N'Creating [dbo].[DF_Roles_TenantId]...';


GO
ALTER TABLE [dbo].[Roles]
    ADD CONSTRAINT [DF_Roles_TenantId] DEFAULT ((1)) FOR [TenantId];


GO
PRINT N'Creating [dbo].[DF_UserPermissions_Granted]...';


GO
ALTER TABLE [dbo].[UserPermissions]
    ADD CONSTRAINT [DF_UserPermissions_Granted] DEFAULT ((1)) FOR [Granted];


GO
PRINT N'Creating [dbo].[DF_Users_IsActive]...';


GO
ALTER TABLE [dbo].[Users]
    ADD CONSTRAINT [DF_Users_IsActive] DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating [dbo].[DF_Users_TenantId]...';


GO
ALTER TABLE [dbo].[Users]
    ADD CONSTRAINT [DF_Users_TenantId] DEFAULT ((1)) FOR [TenantId];


GO
PRINT N'Creating [dbo].[FK_Activities_ActivityAreas_AreaId]...';


GO
ALTER TABLE [dbo].[Activities]
    ADD CONSTRAINT [FK_Activities_ActivityAreas_AreaId] FOREIGN KEY ([AreaId]) REFERENCES [dbo].[ActivityAreas] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Activities_ActivityDescriptions_DescriptionId]...';


GO
ALTER TABLE [dbo].[Activities]
    ADD CONSTRAINT [FK_Activities_ActivityDescriptions_DescriptionId] FOREIGN KEY ([DescriptionId]) REFERENCES [dbo].[ActivityDescriptions] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Activities_ReportingPeriods_ReportingPeriodId]...';


GO
ALTER TABLE [dbo].[Activities]
    ADD CONSTRAINT [FK_Activities_ReportingPeriods_ReportingPeriodId] FOREIGN KEY ([ReportingPeriodId]) REFERENCES [dbo].[ReportingPeriods] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[FK_Activities_Users_ReviewerId]...';


GO
ALTER TABLE [dbo].[Activities]
    ADD CONSTRAINT [FK_Activities_Users_ReviewerId] FOREIGN KEY ([ReviewerId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating [dbo].[FK_Activities_Users_UserId]...';


GO
ALTER TABLE [dbo].[Activities]
    ADD CONSTRAINT [FK_Activities_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating [dbo].[FK_dbo.ActivityAreas_dbo.Companies_CompanyId]...';


GO
ALTER TABLE [dbo].[ActivityAreas]
    ADD CONSTRAINT [FK_dbo.ActivityAreas_dbo.Companies_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Companies] ([Id]);


GO
PRINT N'Creating [dbo].[FK_dbo.ActivityData_dbo.ActivityDescriptions_ActivityDescriptionId]...';


GO
ALTER TABLE [dbo].[ActivityData]
    ADD CONSTRAINT [FK_dbo.ActivityData_dbo.ActivityDescriptions_ActivityDescriptionId] FOREIGN KEY ([ActivityDescriptionId]) REFERENCES [dbo].[ActivityDescriptions] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[FK_dbo.ActivityDescriptions_dbo.ActivityAreas_AreaId]...';


GO
ALTER TABLE [dbo].[ActivityDescriptions]
    ADD CONSTRAINT [FK_dbo.ActivityDescriptions_dbo.ActivityAreas_AreaId] FOREIGN KEY ([AreaId]) REFERENCES [dbo].[ActivityAreas] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Addresses_State]...';


GO
ALTER TABLE [dbo].[Addresses]
    ADD CONSTRAINT [FK_Addresses_State] FOREIGN KEY ([StateId]) REFERENCES [dbo].[States] ([Id]);


GO
PRINT N'Creating [dbo].[FK_dbo.Addresses_dbo.Companies_AddressId]...';


GO
ALTER TABLE [dbo].[Addresses]
    ADD CONSTRAINT [FK_dbo.Addresses_dbo.Companies_AddressId] FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Companies] ([Id]);


GO
PRINT N'Creating [dbo].[FK_dbo.ReportingPeriods_dbo.Companies_CompanyId]...';


GO
ALTER TABLE [dbo].[ReportingPeriods]
    ADD CONSTRAINT [FK_dbo.ReportingPeriods_dbo.Companies_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Companies] ([Id]);


GO
PRINT N'Creating [dbo].[FK_RolePermissions_RoleId]...';


GO
ALTER TABLE [dbo].[RolePermissions]
    ADD CONSTRAINT [FK_RolePermissions_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId]);


GO
PRINT N'Creating [dbo].[FK_dbo.Teams_dbo.Companies_CompanyId]...';


GO
ALTER TABLE [dbo].[Teams]
    ADD CONSTRAINT [FK_dbo.Teams_dbo.Companies_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Companies] ([Id]);


GO
PRINT N'Creating [dbo].[FK_UserPermissions_UserId]...';


GO
ALTER TABLE [dbo].[UserPermissions]
    ADD CONSTRAINT [FK_UserPermissions_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating [dbo].[FK_UserRoles_RoleId]...';


GO
ALTER TABLE [dbo].[UserRoles]
    ADD CONSTRAINT [FK_UserRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId]);


GO
PRINT N'Creating [dbo].[FK_UserRoles_UserId]...';


GO
ALTER TABLE [dbo].[UserRoles]
    ADD CONSTRAINT [FK_UserRoles_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating [dbo].[FK_UserTeams_Teams]...';


GO
ALTER TABLE [dbo].[UserTeams]
    ADD CONSTRAINT [FK_UserTeams_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[Teams] ([Id]);


GO
PRINT N'Creating [dbo].[FK_UserTeams_Users]...';


GO
ALTER TABLE [dbo].[UserTeams]
    ADD CONSTRAINT [FK_UserTeams_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating [dbo].[ActivityReport]...';


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
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO