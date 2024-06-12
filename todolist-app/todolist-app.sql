CREATE TABLE [user] (
  [user_id] integer PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(100) NOT NULL,
  [last_name] varchar(150) NOT NULL,
  [birthdate] datetime NOT NULL
)
GO

CREATE TABLE [project] (
  [project_id] integer PRIMARY KEY IDENTITY(1, 1),
  [user_id] integer NOT NULL,
  [name] varchar(150) NOT NULL,
  [hexadecimal_color] varchar(20) NOT NULL,
  [favorite_flag] boolean DEFAULT (false),
  [active_flag] boolean DEFAULT (true)
)
GO

CREATE TABLE [task_type] (
  [task_type_id] integer PRIMARY KEY IDENTITY(1, 1),
  [description] varchar[30] NOT NULL
)
GO

CREATE TABLE [priority_type] (
  [priority_id] integer PRIMARY KEY IDENTITY(1, 1),
  [description] varchar[30] NOT NULL,
  [hexadecimal_color] varchar(20) NOT NULL
)
GO

CREATE TABLE [task] (
  [task_id] integer PRIMARY KEY IDENTITY(1, 1),
  [created_time] datetime DEFAULT (now()),
  [project_id] integer NOT NULL,
  [task_type_id] integer NOT NULL,
  [priority_id] integer NOT NULL,
  [user_autor] integer NOT NULL,
  [parent_task] integer,
  [user_assignee] integer,
  [name] varchar(280) NOT NULL,
  [description] varchar(1000),
  [due_date] datetime
)
GO

CREATE TABLE [comment] (
  [comment_id] integer PRIMARY KEY IDENTITY(1, 1),
  [task_id] integer NOT NULL,
  [description] varchar(1000) NOT NULL
)
GO

CREATE TABLE [task_label] (
  [label_id] integer NOT NULL,
  [task_id] integer NOT NULL,
  PRIMARY KEY ([label_id], [task_id])
)
GO

CREATE TABLE [label] (
  [label_id] integer PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(150) NOT NULL
)
GO

CREATE TABLE [project_involvement] (
  [user_id] integer,
  [project_id] integer,
  PRIMARY KEY ([user_id], [project_id])
)
GO

CREATE TABLE [reminder] (
  [reminder_id] integer IDENTITY(1, 1),
  [task_id] integer NOT NULL,
  [user_id] integer NOT NULL,
  [reminder_date] datetime NOT NULL,
  PRIMARY KEY ([reminder_id], [user_id])
)
GO

CREATE TABLE [attachment] (
  [attachment_id] integer IDENTITY(1, 1),
  [comment_id] integer NOT NULL,
  [file_path] varchar(500) NOT NULL,
  [file_name] varchar(150) NOT NULL,
  PRIMARY KEY ([attachment_id], [comment_id])
)
GO

ALTER TABLE [project] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [task] ADD FOREIGN KEY ([project_id]) REFERENCES [project] ([project_id])
GO

ALTER TABLE [task] ADD FOREIGN KEY ([task_type_id]) REFERENCES [task_type] ([task_type_id])
GO

ALTER TABLE [task] ADD FOREIGN KEY ([priority_id]) REFERENCES [priority_type] ([priority_id])
GO

ALTER TABLE [task] ADD FOREIGN KEY ([user_autor]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [task] ADD FOREIGN KEY ([parent_task]) REFERENCES [task] ([task_id])
GO

ALTER TABLE [task] ADD FOREIGN KEY ([user_assignee]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [comment] ADD FOREIGN KEY ([task_id]) REFERENCES [task] ([task_id])
GO

ALTER TABLE [task_label] ADD FOREIGN KEY ([label_id]) REFERENCES [label] ([label_id])
GO

ALTER TABLE [task_label] ADD FOREIGN KEY ([task_id]) REFERENCES [task] ([task_id])
GO

ALTER TABLE [project_involvement] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [project_involvement] ADD FOREIGN KEY ([project_id]) REFERENCES [project] ([project_id])
GO

ALTER TABLE [reminder] ADD FOREIGN KEY ([task_id]) REFERENCES [task] ([task_id])
GO

ALTER TABLE [reminder] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [attachment] ADD FOREIGN KEY ([comment_id]) REFERENCES [comment] ([comment_id])
GO
