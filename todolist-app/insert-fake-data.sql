-- Before executing this script, make sure the tables are empty

INSERT INTO [User] ([Name], [LastName], [Birthdate]) VALUES
('John', 'Doe', '1980-05-15'),
('Jane', 'Smith', '1990-07-22'),
('Alice', 'Johnson', '1985-11-02'),
('Bob', 'Brown', '1978-03-30');
GO

INSERT INTO [Project] ([UserId], [Name], [HexadecimalColor], [FavoriteFlag], [ActiveFlag]) VALUES
(1, 'Scarlett', '#99FB31', 1, 1),
(2, 'Brooklin', '#31FBF2', 0, 1),
(3, 'Ellewood', '#431903', 0, 0),
(4, 'Durango', '#921792', 1, 1);
GO


INSERT INTO [TaskType] ([Description]) VALUES
('Task'),
('Subtask')
GO


INSERT INTO [PriorityType] ([Description], [HexadecimalColor]) VALUES
('High', '#FB3D31'),
('Medium', '#FBF831'),
('Low', '#31ACFB');
GO


INSERT INTO [Task] ([ProjectId], [TaskTypeId], [PriorityId], [UserAutor], [ParentTask], [UserAssignee], [Name], [Description], [DueDate]) VALUES
(1, 1, 1, 1, NULL, 2, 'Task 1', 'Description for task 1', '2024-06-01'),
(1, 2, 2, 1, 1, 3, 'Task 2', 'Description for task 2', '2024-06-02')
GO


INSERT INTO [Comment] ([TaskId], [Description]) VALUES
(1, 'Comment on task 1'),
(2, 'Comment on task 2')
GO


INSERT INTO [Label] ([Name]) VALUES
('Urgent'),
('Review'),
('Completed');
GO


INSERT INTO [TaskLabel] ([LabelId], [TaskId]) VALUES
(1, 1),
(2, 2);
GO


INSERT INTO [ProjectInvolvement] ([UserId], [ProjectId]) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);
GO


INSERT INTO [Reminder] ([TaskId], [UserId], [ReminderDate]) VALUES
(1, 1, '2024-06-20'),
(2, 2, '2024-06-21');
GO


INSERT INTO [Attachment] ([CommentId], [FilePath], [FileName]) VALUES
(1, '/path/to/file1', 'file1.txt'),
(2, '/path/to/file2', 'file2.txt');
GO
