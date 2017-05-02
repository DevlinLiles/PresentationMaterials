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
    [IsActive]            SMALLINT       CONSTRAINT [DF_Users_IsActive] DEFAULT ((1)) NOT NULL,
    [TenantId]            INT            CONSTRAINT [DF_Users_TenantId] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserId] ASC)
);

