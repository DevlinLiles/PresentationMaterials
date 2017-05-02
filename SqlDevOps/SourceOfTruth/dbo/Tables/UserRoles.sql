CREATE TABLE [dbo].[UserRoles] (
    [UserRoleId] BIGINT IDENTITY (1, 1) NOT NULL,
    [UserId]     BIGINT NOT NULL,
    [RoleId]     BIGINT NOT NULL,
    CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED ([UserRoleId] ASC),
    CONSTRAINT [FK_UserRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId]),
    CONSTRAINT [FK_UserRoles_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_UserRoles_UserId_RoleId]
    ON [dbo].[UserRoles]([UserId] ASC, [RoleId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_UserRoles_RoleId_UserId]
    ON [dbo].[UserRoles]([RoleId] ASC, [UserId] ASC);

