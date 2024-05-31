CREATE TABLE [Budget] (
  [Id] integer PRIMARY KEY IDENTITY(1,1),
  [UserId] integer NOT NULL,
  [StartDate] datetime DEFAULT (GETDATE()),
  [EndDate] datetime,
  [Name] varchar(100) NOT NULL,
  [BudgetAmount] DECIMAL(10,2) NOT NULL,
  [RemainingValue] DECIMAL(10,2) NOT NULL
)
GO

CREATE TABLE [User] (
  [Id] integer PRIMARY KEY IDENTITY(1,1),
  [FirstName] varchar(50) NOT NULL,
  [LastName] varchar(100) NOT NULL,
  [BirthDate] date NOT NULL
)
GO

CREATE TABLE [AccountType] (
  [Id] integer PRIMARY KEY IDENTITY(1,1),
  [Description] varchar(100) NOT NULL
)
GO

CREATE TABLE [Account] (
  [Id] integer PRIMARY KEY IDENTITY(1,1),
  [UserId] integer NOT NULL,
  [AccountTypeId] integer NOT NULL,
  [Balance] DECIMAL(10,2) NOT NULL,
  [AccountName] varchar(100) NOT NULL,
  [CurrencyCode] int NOT NULL
)
GO

CREATE TABLE [Transaction] (
  [Id] integer PRIMARY KEY IDENTITY(1,1),
  [AccountId] integer NOT NULL,
  [TransactionTypeId] integer NOT NULL,
  [StartDate] datetime DEFAULT (GETDATE()),
  [Description] varchar(300) NOT NULL
)
GO

CREATE TABLE [TransactionType] (
  [Id] integer PRIMARY KEY IDENTITY(1,1),
  [Description] varchar(100) NOT NULL
)
GO

CREATE TABLE [Expense] (
  [TransactionId] integer PRIMARY KEY,
  [TransactionTypeId] integer NOT NULL,
  [OperationValue] DECIMAL(10,2) NOT NULL CHECK (OperationValue < 0),
  [CategoryId] integer
)
GO

CREATE TABLE [Income] (
  [TransactionId] integer PRIMARY KEY,
  [TransactionTypeId] integer NOT NULL,
  [OperationValue] DECIMAL(10,2) NOT NULL,
  [CategoryId] integer
)
GO

CREATE TABLE [Transfer] (
  [TransactionId] integer PRIMARY KEY,
  [SourceAccountId] integer NOT NULL,
  [DestinationAccountId] integer NOT NULL,
  [TransferredAmount] DECIMAL(10,2) NOT NULL,
  [TransferDate] datetime DEFAULT (GETDATE()),
  [CategoryId] integer NOT NULL,
  [TransactionTypeId] integer NOT NULL
)
GO

CREATE TABLE [Category] (
  [Id] integer PRIMARY KEY IDENTITY(1,1),
  [Name] varchar(100) NOT NULL,
  [ParentCategoryId] integer,
  [TransactionTypeId] integer NOT NULL,
  [CreatedAt] datetime DEFAULT (GETDATE())
)
GO

ALTER TABLE [Budget] ADD FOREIGN KEY ([UserId]) REFERENCES [User] ([Id])
GO

ALTER TABLE [Account] ADD FOREIGN KEY ([UserId]) REFERENCES [User] ([Id])
GO

ALTER TABLE [Account] ADD FOREIGN KEY ([AccountTypeId]) REFERENCES [AccountType] ([Id])
GO

ALTER TABLE [Transaction] ADD FOREIGN KEY ([AccountId]) REFERENCES [Account] ([Id])
GO

ALTER TABLE [Transaction] ADD FOREIGN KEY ([TransactionTypeId]) REFERENCES [TransactionType] ([Id])
GO

ALTER TABLE [Expense] ADD FOREIGN KEY ([TransactionId]) REFERENCES [Transaction] ([Id])
GO

ALTER TABLE [Expense] ADD FOREIGN KEY ([TransactionTypeId]) REFERENCES [TransactionType] ([Id])
GO

ALTER TABLE [Expense] ADD FOREIGN KEY ([CategoryId]) REFERENCES [Category] ([Id])
GO

ALTER TABLE [Income] ADD FOREIGN KEY ([TransactionId]) REFERENCES [Transaction] ([Id])
GO

ALTER TABLE [Income] ADD FOREIGN KEY ([TransactionTypeId]) REFERENCES [TransactionType] ([Id])
GO

ALTER TABLE [Income] ADD FOREIGN KEY ([CategoryId]) REFERENCES [Category] ([Id])
GO

ALTER TABLE [Transfer] ADD FOREIGN KEY ([TransactionId]) REFERENCES [Transaction] ([Id])
GO

ALTER TABLE [Transfer] ADD FOREIGN KEY ([SourceAccountId]) REFERENCES [Account] ([Id])
GO

ALTER TABLE [Transfer] ADD FOREIGN KEY ([DestinationAccountId]) REFERENCES [Account] ([Id])
GO

ALTER TABLE [Transfer] ADD FOREIGN KEY ([CategoryId]) REFERENCES [Category] ([Id])
GO

ALTER TABLE [Transfer] ADD FOREIGN KEY ([TransactionTypeId]) REFERENCES [TransactionType] ([Id])
GO

ALTER TABLE [Category] ADD FOREIGN KEY ([ParentCategoryId]) REFERENCES [Category] ([Id])
GO

ALTER TABLE [Category] ADD FOREIGN KEY ([TransactionTypeId]) REFERENCES [TransactionType] ([Id])
GO

ALTER TABLE [Expense]
ADD CONSTRAINT Check_Expense_OperationValue CHECK (OperationValue < 0);
GO

ALTER TABLE [Income]
ADD CONSTRAINT Check_Income_OperationValue CHECK (OperationValue > 0);
GO
