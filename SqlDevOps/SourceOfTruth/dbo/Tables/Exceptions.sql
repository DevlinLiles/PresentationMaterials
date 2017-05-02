CREATE TABLE [dbo].[Exceptions] (
    [Id]              BIGINT           IDENTITY (1, 1) NOT NULL,
    [GUID]            UNIQUEIDENTIFIER NOT NULL,
    [ApplicationName] NVARCHAR (50)    NOT NULL,
    [MachineName]     NVARCHAR (50)    NOT NULL,
    [CreationDate]    DATETIME         NOT NULL,
    [Type]            NVARCHAR (100)   NOT NULL,
    [IsProtected]     BIT              CONSTRAINT [DF_Exceptions_IsProtected] DEFAULT ((1)) NOT NULL,
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
    [DuplicateCount]  INT              CONSTRAINT [DF_Exceptions_DuplicateCount] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Exceptions] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Exceptions_GUID_App_Del_Cre]
    ON [dbo].[Exceptions]([GUID] ASC, [ApplicationName] ASC, [DeletionDate] ASC, [CreationDate] DESC);


GO
CREATE NONCLUSTERED INDEX [IX_Exceptions_Hash_App_Cre_Del]
    ON [dbo].[Exceptions]([ErrorHash] ASC, [ApplicationName] ASC, [CreationDate] DESC, [DeletionDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Exceptions_App_Del_Cre]
    ON [dbo].[Exceptions]([ApplicationName] ASC, [DeletionDate] ASC, [CreationDate] DESC);

