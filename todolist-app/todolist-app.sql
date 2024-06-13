CREATE TABLE [User] (
  [UserId] integer PRIMARY KEY IDENTITY(1, 1),
  [Name] varchar(100) NOT NULL,
  [LastName] varchar(150) NOT NULL,
  [Birthdate] datetime NOT NULL
)
GO

CREATE TABLE [Project] (
  [ProjectId] integer PRIMARY KEY IDENTITY(1, 1),
  [UserId] integer NOT NULL,
  [Name] varchar(150) NOT NULL,
  [HexadecimalColor] varchar(20) NOT NULL,
  [FavoriteFlag] boolean DEFAULT (false),
  [ActiveFlag] boolean DEFAULT (true)
)
GO

CREATE TABLE [TaskType] (
  [TaskTypeId] integer PRIMARY KEY IDENTITY(1, 1),
  [Description] varchar(30) NOT NULL
)
GO

CREATE TABLE [PriorityType] (
  [PriorityId] integer PRIMARY KEY IDENTITY(1, 1),
  [Description] varchar(30) NOT NULL,
  [HexadecimalColor] varchar(20) NOT NULL
)
GO

CREATE TABLE [Task] (
  [TaskId] integer PRIMARY KEY IDENTITY(1, 1),
  [CreatedTime] datetime DEFAULT (GETDATE()),
  [ProjectId] integer NOT NULL,
  [TaskTypeId] integer NOT NULL,
  [PriorityId] integer NOT NULL,
  [UserAutor] integer NOT NULL,
  [ParentTask] integer,
  [UserAssignee] integer,
  [Name] varchar(280) NOT NULL,
  [Description] varchar(1000),
  [DueDate] datetime
)
GO

CREATE TABLE [Comment] (
  [CommentId] integer PRIMARY KEY IDENTITY(1, 1),
  [TaskId] integer NOT NULL,
  [Description] varchar(1000) NOT NULL
)
GO

CREATE TABLE [TaskLabel] (
  [LabelId] integer NOT NULL,
  [TaskId] integer NOT NULL,
  PRIMARY KEY ([LabelId], [TaskId])
)
GO

CREATE TABLE [Label] (
  [LabelId] integer PRIMARY KEY IDENTITY(1, 1),
  [Name] varchar(150) NOT NULL
)
GO

CREATE TABLE [ProjectInvolvement] (
  [UserId] integer,
  [ProjectId] integer,
  PRIMARY KEY ([UserId], [ProjectId])
)
GO

CREATE TABLE [Reminder] (
  [ReminderId] integer IDENTITY(1, 1),
  [TaskId] integer NOT NULL,
  [UserId] integer NOT NULL,
  [ReminderDate] datetime NOT NULL,
  PRIMARY KEY ([ReminderId], [UserId])
)
GO

CREATE TABLE [Attachment] (
  [AttachmentId] integer IDENTITY(1, 1),
  [CommentId] integer NOT NULL,
  [FilePath] varchar(500) NOT NULL,
  [FileName] varchar(150) NOT NULL,
  PRIMARY KEY ([AttachmentId], [CommentId])
)
GO

ALTER TABLE [Project] ADD FOREIGN KEY ([UserId]) REFERENCES [User] ([UserId])
GO

ALTER TABLE [Task] ADD FOREIGN KEY ([ProjectId]) REFERENCES [Project] ([ProjectId])
GO

ALTER TABLE [Task] ADD FOREIGN KEY ([TaskTypeId]) REFERENCES [TaskType] ([TaskTypeId])
GO

ALTER TABLE [Task] ADD FOREIGN KEY ([PriorityId]) REFERENCES [PriorityType] ([PriorityId])
GO

ALTER TABLE [Task] ADD FOREIGN KEY ([UserAutor]) REFERENCES [User] ([UserId])
GO

ALTER TABLE [Task] ADD FOREIGN KEY ([ParentTask]) REFERENCES [Task] ([TaskId])
GO

ALTER TABLE [Task] ADD FOREIGN KEY ([UserAssignee]) REFERENCES [User] ([UserId])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([TaskId]) REFERENCES [Task] ([TaskId])
GO

ALTER TABLE [TaskLabel] ADD FOREIGN KEY ([LabelId]) REFERENCES [Label] ([LabelId])
GO

ALTER TABLE [TaskLabel] ADD FOREIGN KEY ([TaskId]) REFERENCES [Task] ([TaskId])
GO

ALTER TABLE [ProjectInvolvement] ADD FOREIGN KEY ([UserId]) REFERENCES [User] ([UserId])
GO

ALTER TABLE [ProjectInvolvement] ADD FOREIGN KEY ([ProjectId]) REFERENCES [Project] ([ProjectId])
GO

ALTER TABLE [Reminder] ADD FOREIGN KEY ([TaskId]) REFERENCES [Task] ([TaskId])
GO

ALTER TABLE [Reminder] ADD FOREIGN KEY ([UserId]) REFERENCES [User] ([UserId])
GO

ALTER TABLE [Attachment] ADD FOREIGN KEY ([CommentId]) REFERENCES [Comment] ([CommentId])
GO
