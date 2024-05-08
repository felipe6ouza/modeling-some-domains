CREATE TABLE [budget] (
  [id] integer PRIMARY KEY,
  [user_id] integer NOT NULL,
  [start_date] datetime2 DEFAULT (now()),
  [end_date] datetime2,
  [name] varchar(100) NOT NULL,
  [budget_amount] DECIMAL(10,2) NOT NULL,
  [remaining_value] DECIMAL(10,2) NOT NULL
)
GO

CREATE TABLE [user] (
  [id] integer PRIMARY KEY,
  [first_name] varchar(50) NOT NULL,
  [last_name] varchar(100) NOT NULL,
  [birth_date] date NOT NULL
)
GO

CREATE TABLE [account_type] (
  [id] integer PRIMARY KEY,
  [description] varchar(100) NOT NULL
)
GO

CREATE TABLE [account] (
  [id] integer PRIMARY KEY,
  [user_id] integer NOT NULL,
  [account_type_id] integer NOT NULL,
  [balance] DECIMAL(10,2) NOT NULL,
  [account_name] varchar(100) NOT NULL,
  [currency_code] int NOT NULL
)
GO

CREATE TABLE [transaction] (
  [id] integer PRIMARY KEY,
  [account_id] integer NOT NULL,
  [transaction_type_id] integer NOT NULL,
  [start_date] datetime2 DEFAULT (now()),
  [description] varchar(300) NOT NULL
)
GO

CREATE TABLE [transaction_type] (
  [id] integer PRIMARY KEY,
  [description] varchar(100) NOT NULL
)
GO

CREATE TABLE [expense] (
  [transaction_id] integer PRIMARY KEY,
  [transaction_type_id] integer NOT NULL,
  [operation_value] DECIMAL(10,2) NOT NULL,
  [category_id] integer
)
GO

CREATE TABLE [income] (
  [transaction_id] integer PRIMARY KEY NOT NULL,
  [transaction_type_id] integer NOT NULL,
  [operation_value] DECIMAL(10,2) NOT NULL,
  [category_id] integer
)
GO

CREATE TABLE [transfer] (
  [transaction_id] integer PRIMARY KEY,
  [source_account_id] integer NOT NULL,
  [destination_account_id] integer NOT NULL,
  [transferred_amount] DECIMAL(10,2) NOT NULL,
  [transfer_date] datetime2 DEFAULT (now()),
  [category_id] integer NOT NULL,
  [transaction_type_id] integer NOT NULL
)
GO

CREATE TABLE [category] (
  [id] integer PRIMARY KEY,
  [name] varchar(100) NOT NULL,
  [parent_category_id] integer,
  [transaction_type_id] integer NOT NULL,
  [created_at] datetime2 DEFAULT (now())
)
GO

ALTER TABLE [budget] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id])
GO

ALTER TABLE [account] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id])
GO

ALTER TABLE [account] ADD FOREIGN KEY ([account_type_id]) REFERENCES [account_type] ([id])
GO

ALTER TABLE [transaction] ADD FOREIGN KEY ([account_id]) REFERENCES [account] ([id])
GO

ALTER TABLE [transaction] ADD FOREIGN KEY ([transaction_type_id]) REFERENCES [transaction_type] ([id])
GO

ALTER TABLE [expense] ADD FOREIGN KEY ([transaction_id]) REFERENCES [transaction] ([id])
GO

ALTER TABLE [expense] ADD FOREIGN KEY ([transaction_type_id]) REFERENCES [transaction_type] ([id])
GO

ALTER TABLE [expense] ADD FOREIGN KEY ([category_id]) REFERENCES [category] ([id])
GO

ALTER TABLE [income] ADD FOREIGN KEY ([transaction_id]) REFERENCES [transaction] ([id])
GO

ALTER TABLE [income] ADD FOREIGN KEY ([transaction_type_id]) REFERENCES [transaction_type] ([id])
GO

ALTER TABLE [income] ADD FOREIGN KEY ([category_id]) REFERENCES [category] ([id])
GO

ALTER TABLE [transfer] ADD FOREIGN KEY ([transaction_id]) REFERENCES [transaction] ([id])
GO

ALTER TABLE [transfer] ADD FOREIGN KEY ([source_account_id]) REFERENCES [account] ([id])
GO

ALTER TABLE [transfer] ADD FOREIGN KEY ([destination_account_id]) REFERENCES [account] ([id])
GO

ALTER TABLE [transfer] ADD FOREIGN KEY ([category_id]) REFERENCES [category] ([id])
GO

ALTER TABLE [transfer] ADD FOREIGN KEY ([transaction_type_id]) REFERENCES [transaction_type] ([id])
GO

ALTER TABLE [category] ADD FOREIGN KEY ([parent_category_id]) REFERENCES [category] ([id])
GO

ALTER TABLE [category] ADD FOREIGN KEY ([transaction_type_id]) REFERENCES [transaction_type] ([id])
GO
