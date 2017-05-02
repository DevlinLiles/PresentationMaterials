CREATE TABLE [dbo].[UserTeams] (
    [Id]     BIGINT IDENTITY (1, 1) NOT NULL,
    [UserId] BIGINT NOT NULL,
    [TeamId] BIGINT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_UserTeams_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[Teams] ([Id]),
    CONSTRAINT [FK_UserTeams_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_UserTeams]
    ON [dbo].[UserTeams]([UserId] ASC, [TeamId] ASC);

