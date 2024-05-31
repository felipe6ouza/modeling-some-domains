-- Before executing this script, make sure the tables are empty

BEGIN TRANSACTION

--Reset the IDENTITY for the tables.
DBCC CHECKIDENT ('[User]', RESEED, 0);
DBCC CHECKIDENT ('[AccountType]', RESEED, 0);
DBCC CHECKIDENT ('[TransactionType]', RESEED, 0);
DBCC CHECKIDENT ('[Category]', RESEED, 0);
DBCC CHECKIDENT ('[Account]', RESEED, 0);
DBCC CHECKIDENT ('[Budget]', RESEED, 0);
DBCC CHECKIDENT ('[Transaction]', RESEED, 0);


INSERT INTO [User] (FirstName, LastName, BirthDate) VALUES
('Alice', 'Silva', '1990-01-01'),
('Bob', 'Oliveira', '1985-05-15');


INSERT INTO [AccountType] (Description) VALUES
('Conta Corrente'),
('Conta Poupança');

INSERT INTO [TransactionType] (Description) VALUES
('Despesa'),
('Receita'),
('Transferência');


INSERT INTO [Category] (Name, ParentCategoryId, TransactionTypeId, CreatedAt) VALUES
('Alimentos', NULL, 1, GETDATE()),
('Salário', NULL, 2, GETDATE()),
('Aluguel', NULL, 1, GETDATE());

INSERT INTO [Account] (UserId, AccountTypeId, Balance, AccountName, CurrencyCode) VALUES
(1, 1, 1500.00, 'Conta Corrente da Alice', 840),
(1, 2, 3000.00, 'Conta Poupança da Alice', 840),
(2, 1, 2000.00, 'Conta Corrente do Bob', 840);

INSERT INTO [Budget] (UserId, StartDate, EndDate, Name, BudgetAmount, RemainingValue) VALUES
(1, '2024-01-01', '2024-12-31', 'Orçamento da Alice 2024', 50000.00, 48000.00),
(2, '2024-01-01', '2024-12-31', 'Orçamento do Bob 2024', 60000.00, 59000.00);

INSERT INTO [Transaction] (AccountId, TransactionTypeId, StartDate, Description) VALUES
(1, 1, GETDATE(), 'Compras de Supermercado'),
(3, 2, GETDATE(), 'Pagamento de Salário'),
(2, 3, GETDATE(), 'Transferência para Conta Corrente');

INSERT INTO [Expense] (TransactionId, TransactionTypeId, OperationValue, CategoryId) VALUES
(1, 1, -200.00, 1);

INSERT INTO [Income] (TransactionId, TransactionTypeId, OperationValue, CategoryId) VALUES
(2, 2, 5000.00, 2);

INSERT INTO [Transfer] (TransactionId, SourceAccountId, DestinationAccountId, TransferredAmount, TransferDate, CategoryId, TransactionTypeId) VALUES
(3, 2, 1, 1000.00, GETDATE(), 3, 3);


COMMIT  -- OR ROLLBACK, You decide.

