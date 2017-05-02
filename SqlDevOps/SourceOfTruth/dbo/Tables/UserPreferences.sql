CREATE TABLE [dbo].[UserPreferences] (
    [UserPreferenceId] INT            IDENTITY (1, 1) NOT NULL,
    [UserId]           BIGINT         NOT NULL,
    [PreferenceType]   NVARCHAR (100) NOT NULL,
    [Name]             NVARCHAR (200) NOT NULL,
    [Value]            NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_UserPreferences] PRIMARY KEY CLUSTERED ([UserPreferenceId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserPref_UID_PrefType_Name]
    ON [dbo].[UserPreferences]([UserId] ASC, [PreferenceType] ASC, [Name] ASC);

