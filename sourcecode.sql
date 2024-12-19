-- User Authentication
CREATE OR REPLACE PROCEDURE SignUp(
    p_Username IN Users.Username%TYPE,
    p_Password IN Users.Password%TYPE
    p_Name IN Users.Name%TYPE;
    p_Email IN Users.Email%TYPE;
    p_Phone IN Users.Phone%TYPE;
    p_Address IN Users.Address%TYPE;
    v_MaxUserID IN Users.UserID%TYPE;
) AS
BEGIN

    SELECT MAX(UserID) INTO v_MaxUserID FROM Users;

    -- If no existing users, set UserID to 1
    IF v_MaxUserID IS NULL THEN
        v_MaxUserID := 1;
    ELSE
        -- Increment the maximum UserID to generate a new one
        v_MaxUserID := v_MaxUserID + 1;
    END IF;

    INSERT INTO Users(UserID, Username, Password, Name, Email, Phone, Address)
    VALUES (v_MaxUserID, p_Username, p_Password, p_Name, p_Email, p_Phone, p_Address);
    
    COMMIT;
END SignUp;
/


CREATE OR REPLACE PROCEDURE Login(
    p_Username IN Users.Username%TYPE,
    p_Password IN Users.Password%TYPE
) AS
    v_UserID Users.UserID%TYPE;
    v_Option INT;
BEGIN
    SELECT UserID
    INTO v_UserID
    FROM Users
    WHERE Username = p_Username
    AND Password = p_Password;
 
    IF v_UserID IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Login Successful');
       
        DBMS_OUTPUT.PUT_LINE('Welcome, ' || p_Username || '! Choose an option:');
        DBMS_OUTPUT.PUT_LINE('1. Add Expense');
        DBMS_OUTPUT.PUT_LINE('2. Add Income');
        DBMS_OUTPUT.PUT_LINE('3. Add Investment');
        DBMS_OUTPUT.PUT_LINE('4. Add Savings');
        DBMS_OUTPUT.PUT_LINE('5. View Transactions');
        DBMS_OUTPUT.PUT_LINE('6. View Expenses');
        DBMS_OUTPUT.PUT_LINE('7. View Incomes');
        DBMS_OUTPUT.PUT_LINE('8. View Investments');
        DBMS_OUTPUT.PUT_LINE('9. View Savings');

        v_Option := 1;

        CASE v_Option
            WHEN 1 THEN
                -- Add Expense
                AddExpense(v_UserID);
            WHEN 2 THEN
                -- Add Income
                AddIncome(v_UserID);
            WHEN 3 THEN
                -- Add Investment
                AddInvestment(v_UserID);
            WHEN 4 THEN
                -- Add Savings
                AddSavings(v_UserID);
            WHEN 5 THEN
                -- View Transactions
                ViewTransactions(v_UserID);
            WHEN 6 THEN
                -- View Expenses
                ViewExpenses(v_UserID);
            WHEN 7 THEN
                -- View Incomes
                ViewIncomes(v_UserID);
            WHEN 8 THEN
                -- View Investments
                ViewInvestments(v_UserID);
            WHEN 9 THEN
                -- View Savings
                ViewSavings(v_UserID);
	    WHEN 10 THEN
		-- Get total expense for each category
		GetExpenseTotalByCategory(v_UserID);

	    WHEN 11 THEN
		--Get users with expense higher than a threshold
		GetUsersWithHighExpenses(v_UserID);
	    WHEN 12 THEN
		--Get sorted list of expenses
		GetSortedExpenses(v_UserID);
	    WHEN 13 THEN
		--Distribute a specific amount between multiple users
		DistributeAmount(v_UserID);
	
            ELSE
                DBMS_OUTPUT.PUT_LINE('Invalid option');
        END CASE;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid username or password');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid username or password');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END Login;
/



CREATE OR REPLACE PROCEDURE ViewTransactions(
    p_UserID IN Transactions.UserID%TYPE
) AS
BEGIN
    FOR trans IN (SELECT * FROM Transactions WHERE UserID = p_UserID) LOOP
        DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || trans.TransactionID || ', Type: ' || trans.TransactionType || ', Amount: ' || trans.Amount || ', Date: ' || trans.TransactionDate);
    END LOOP;
END ViewTransactions;
/

CREATE OR REPLACE PROCEDURE AddExpense(
    p_UserID IN Expenses.UserID%TYPE
    v_Category IN Expenses.Category%TYPE;
    v_Amount IN Expenses.Amount%TYPE;
    v_TransactionDate IN Expenses.TransactionDate%TYPE;
    v_TagID IN Expenses.TagID%TYPE;
    v_MaxExpenseID IN Expenses.ExpenseID%TYPE;
) AS
BEGIN
    
    SELECT MAX(ExpenseID) INTO v_MaxExpenseID FROM Expenses;

    -- If no existing expenses, set ExpenseID to 1
    IF v_MaxExpenseID IS NULL THEN
        v_MaxExpenseID := 1;
    ELSE
        -- Increment the maximum ExpenseID to generate a new one
        v_MaxExpenseID := v_MaxExpenseID + 1;
    END IF;

    INSERT INTO Expenses(ExpenseID, UserID, Category, Amount, TransactionDate, TagID)
    VALUES (v_MaxExpenseID, p_UserID, v_Category, v_Amount, v_TransactionDate, v_TagID);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding expense: ' || SQLERRM);
END AddExpense;
/



CREATE OR REPLACE PROCEDURE AddIncome(
    p_UserID IN Income.UserID%TYPE
    v_Source IN Income.Source%TYPE;
    v_Amount IN Income.Amount%TYPE;
    v_TransactionDate IN Income.TransactionDate%TYPE;
    v_MaxIncomeID IN Income.IncomeID%TYPE;
) AS
BEGIN
    SELECT MAX(IncomeID) INTO v_MaxIncomeID FROM Income;

    -- If no existing income records, set IncomeID to 1
    IF v_MaxIncomeID IS NULL THEN
        v_MaxIncomeID := 1;
    ELSE
        -- Increment the maximum IncomeID to generate a new one
        v_MaxIncomeID := v_MaxIncomeID + 1;
    END IF;

    INSERT INTO Income(IncomeID, UserID, Source, Amount, TransactionDate)
    VALUES (v_MaxIncomeID, p_UserID, v_Source, v_Amount, v_TransactionDate);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding income: ' || SQLERRM);
END AddIncome;
/



CREATE OR REPLACE PROCEDURE AddInvestment(
    p_UserID IN Investments.UserID%TYPE
    v_InvestmentName IN Investments.InvestmentName%TYPE;
    v_InvestmentType IN Investments.InvestmentType%TYPE;
    v_Amount IN Investments.Amount%TYPE;
    v_ReturnRate IN Investments.ReturnRate%TYPE;
    v_StartDate IN Investments.StartDate%TYPE;
    v_EndDate IN Investments.EndDate%TYPE;
    v_MaxInvestmentID IN Investments.InvestmentID%TYPE;
) AS
BEGIN
    SELECT MAX(InvestmentID) INTO v_MaxInvestmentID FROM Investments;

    -- If no existing investments, set InvestmentID to 1
    IF v_MaxInvestmentID IS NULL THEN
        v_MaxInvestmentID := 1;
    ELSE
        -- Increment the maximum InvestmentID to generate a new one
        v_MaxInvestmentID := v_MaxInvestmentID + 1;
    END IF;

    INSERT INTO Investments(InvestmentID, UserID, InvestmentName, InvestmentType, Amount, ReturnRate, StartDate, EndDate)
    VALUES (v_MaxInvestmentID, p_UserID, v_InvestmentName, NULL, v_Amount, NULL, v_StartDate, NULL);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding investment: ' || SQLERRM);
END AddInvestment;
/



CREATE OR REPLACE PROCEDURE AddSavings(
    p_UserID IN Savings.UserID%TYPE
    v_BankName Savings.BankName%TYPE;
    v_AccountNumber Savings.AccountNumber%TYPE;
    v_Amount Savings.Amount%TYPE;
    v_MaxSavingID Savings.SavingID%TYPE;
) AS
BEGIN
    SELECT MAX(SavingID) INTO v_MaxSavingID FROM Savings;

    -- If no existing savings records, set SavingID to 1
    IF v_MaxSavingID IS NULL THEN
        v_MaxSavingID := 1;
    ELSE
        -- Increment the maximum SavingID to generate a new one
        v_MaxSavingID := v_MaxSavingID + 1;
    END IF;

    INSERT INTO Savings(SavingID, UserID, BankName, AccountNumber, Amount)
    VALUES (v_MaxSavingID, p_UserID, v_BankName, v_AccountNumber, v_Amount);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding savings: ' || SQLERRM);
END AddSavings;
/
CREATE OR REPLACE PROCEDURE ViewExpenses(
    p_UserID INT
)
IS
BEGIN
    -- Display expense details for the specified user
    FOR expense_rec IN (
        SELECT ExpenseID, Category, Amount, TransactionDate
        FROM Expenses
        WHERE UserID = p_UserID
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Expense ID: ' || expense_rec.ExpenseID);
        DBMS_OUTPUT.PUT_LINE('Category: ' || expense_rec.Category);
        DBMS_OUTPUT.PUT_LINE('Amount: ' || TO_CHAR(expense_rec.Amount, '99999.99'));
        DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(expense_rec.TransactionDate, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('----------------------');
    END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE ViewIncomes(
    p_UserID INT
)
IS
BEGIN
    -- Display income details for the specified user
    FOR income_rec IN (
        SELECT IncomeID, Source, Amount, TransactionDate
        FROM Income
        WHERE UserID = p_UserID
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Income ID: ' || income_rec.IncomeID);
        DBMS_OUTPUT.PUT_LINE('Source: ' || income_rec.Source);
        DBMS_OUTPUT.PUT_LINE('Amount: ' || TO_CHAR(income_rec.Amount, '99999.99'));
        DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(income_rec.TransactionDate, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('----------------------');
    END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE ViewInvestments(
    p_UserID INT
)
IS
BEGIN
    -- Display investment details for the specified user
    FOR investment_rec IN (
        SELECT InvestmentID, InvestmentName, InvestmentType, Amount, ReturnRate, StartDate, EndDate
        FROM Investments
        WHERE UserID = p_UserID
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Investment ID: ' || investment_rec.InvestmentID);
        DBMS_OUTPUT.PUT_LINE('Investment Name: ' || investment_rec.InvestmentName);
        DBMS_OUTPUT.PUT_LINE('Investment Type: ' || investment_rec.InvestmentType);
        DBMS_OUTPUT.PUT_LINE('Amount: ' || TO_CHAR(investment_rec.Amount, '99999.99'));
        DBMS_OUTPUT.PUT_LINE('Return Rate: ' || TO_CHAR(investment_rec.ReturnRate, '999.99') || '%');
        DBMS_OUTPUT.PUT_LINE('Start Date: ' || TO_CHAR(investment_rec.StartDate, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('End Date: ' || TO_CHAR(investment_rec.EndDate, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('----------------------');
    END LOOP;
END;
/

-- Cursor
CREATE OR REPLACE PROCEDURE ViewSavings(
    p_UserID IN Savings.UserID%TYPE
) AS
    CURSOR c_savings IS
        SELECT * FROM Savings WHERE UserID = p_UserID;
    v_savings Savings%ROWTYPE;
BEGIN
    OPEN c_savings;
    LOOP
        FETCH c_savings INTO v_savings;
        EXIT WHEN c_savings%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Bank: ' || v_savings.BankName || ', Account Number: ' || v_savings.AccountNumber || ', Amount: ' || v_savings.Amount);
    END LOOP;
    CLOSE c_savings;
END ViewSavings;
/


CREATE OR REPLACE PROCEDURE GetExpenseTotalByCategory(
    p_UserID INT
)
IS
BEGIN
    FOR expense_rec IN (
        SELECT Category, SUM(Amount) AS TotalAmount
        FROM Expenses
        WHERE UserID = p_UserID
        GROUP BY Category
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Category: ' || expense_rec.Category);
        DBMS_OUTPUT.PUT_LINE('Total Amount: ' || TO_CHAR(expense_rec.TotalAmount, '99999.99'));
        DBMS_OUTPUT.PUT_LINE('----------------------');
    END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE GetUsersWithHighExpenses(p_UserID INT)
IS
    v_ThresholdAmount DECIMAL;
BEGIN
    -- Prompt user to enter the threshold amount
    DBMS_OUTPUT.PUT('Enter the threshold amount: ');
    DBMS_OUTPUT.GET_LINE(v_ThresholdAmount);

    FOR user_rec IN (
        SELECT UserID, SUM(Amount) AS TotalExpense
        FROM Expenses
        GROUP BY UserID
        HAVING SUM(Amount) > v_ThresholdAmount
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('User ID: ' || user_rec.UserID);
        DBMS_OUTPUT.PUT_LINE('Total Expense: ' || TO_CHAR(user_rec.TotalExpense, '99999.99'));
        DBMS_OUTPUT.PUT_LINE('----------------------');
    END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE GetSortedExpenses(
    p_UserID INT
)
IS
BEGIN
    FOR expense_rec IN (
        SELECT ExpenseID, Category, Amount, Date
        FROM Expenses
        WHERE UserID = p_UserID
        ORDER BY Date DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Expense ID: ' || expense_rec.ExpenseID);
        DBMS_OUTPUT.PUT_LINE('Category: ' || expense_rec.Category);
        DBMS_OUTPUT.PUT_LINE('Amount: ' || TO_CHAR(expense_rec.Amount, '99999.99'));
        DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(expense_rec.Date, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('----------------------');
    END LOOP;
END;
/



CREATE OR REPLACE PROCEDURE DistributeAmount(
    p_UserID INT
)
IS
    v_Amount DECIMAL;
    v_TotalUsers INT;
    v_AmountPerUser DECIMAL;
BEGIN
    -- Prompt user to enter the amount
    DBMS_OUTPUT.PUT('Enter the amount to distribute: ');
    DBMS_OUTPUT.GET_LINE(v_Amount);

    -- Get the total number of users
    SELECT COUNT(*) INTO v_TotalUsers FROM User;

    -- Calculate the amount to be distributed per user
    v_AmountPerUser := v_Amount / v_TotalUsers;

    -- Deduct the amount from each user except the input user
    UPDATE User
    SET Amount = Amount - v_AmountPerUser
    WHERE UserID <> p_UserID;

    -- Add the amount to the input user
    UPDATE User
    SET Amount = Amount + v_Amount
    WHERE UserID = p_UserID;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Amount distributed successfully.');
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Error: Division by zero.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
-- Triggers
CREATE OR REPLACE TRIGGER trg_transactions
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
    IF :NEW.Amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Amount must be greater than zero');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_expenses
BEFORE INSERT ON Expenses
FOR EACH ROW
BEGIN
    IF :NEW.Amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Amount must be greater than zero');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_income
BEFORE INSERT ON Income
FOR EACH ROW
BEGIN
    IF :NEW.Amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Amount must be greater than zero');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_investments
BEFORE INSERT ON Investments
FOR EACH ROW
BEGIN
    IF :NEW.Amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Amount must be greater than zero');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_savings
BEFORE INSERT ON Savings
FOR EACH ROW
BEGIN
    IF :NEW.Amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Amount must be greater than zero');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_transaction_after_insert
AFTER INSERT ON Income
FOR EACH ROW
DECLARE
    v_MaxTransactionID Transactions.TransactionID%TYPE;
BEGIN
    SELECT MAX(TransactionID) INTO v_MaxTransactionID FROM Transactions;

    -- If no existing transactions, set TransactionID to 1
    IF v_MaxTransactionID IS NULL THEN
        v_MaxTransactionID := 1;
    ELSE
        -- Increment the maximum TransactionID to generate a new one
        v_MaxTransactionID := v_MaxTransactionID + 1;
    END IF;

    INSERT INTO Transactions(TransactionID, UserID, TransactionType, Description, Amount, TransactionDate, PaymentMethod, TagID)
    VALUES (v_MaxTransactionID, :NEW.UserID, 'Income', :NEW.Source, :NEW.Amount, :NEW.TransactionDate, NULL, NULL);

    COMMIT;
END;
/

CREATE OR REPLACE TRIGGER trg_transaction_after_insert_expense
AFTER INSERT ON Expenses
FOR EACH ROW
DECLARE
    v_MaxTransactionID Transactions.TransactionID%TYPE;
BEGIN
    SELECT MAX(TransactionID) INTO v_MaxTransactionID FROM Transactions;

    -- If no existing transactions, set TransactionID to 1
    IF v_MaxTransactionID IS NULL THEN
        v_MaxTransactionID := 1;
    ELSE
        -- Increment the maximum TransactionID to generate a new one
        v_MaxTransactionID := v_MaxTransactionID + 1;
    END IF;

    INSERT INTO Transactions(TransactionID, UserID, TransactionType, Description, Amount, TransactionDate, PaymentMethod, TagID)
    VALUES (v_MaxTransactionID, :NEW.UserID, 'Expense', NULL, :NEW.Amount, :NEW.TransactionDate, NULL, :NEW.TagID);

    COMMIT;
END;
/

CREATE OR REPLACE TRIGGER trg_transaction_after_insert_investment
AFTER INSERT ON Investments
FOR EACH ROW
DECLARE
    v_MaxTransactionID Transactions.TransactionID%TYPE;
BEGIN
    SELECT MAX(TransactionID) INTO v_MaxTransactionID FROM Transactions;

    -- If no existing transactions, set TransactionID to 1
    IF v_MaxTransactionID IS NULL THEN
        v_MaxTransactionID := 1;
    ELSE
        -- Increment the maximum TransactionID to generate a new one
        v_MaxTransactionID := v_MaxTransactionID + 1;
    END IF;

    INSERT INTO Transactions(TransactionID, UserID, TransactionType, Description, Amount, TransactionDate, PaymentMethod, TagID)
    VALUES (v_MaxTransactionID, :NEW.UserID, 'Investment', :NEW.InvestmentName, :NEW.Amount, :NEW.StartDate, NULL, NULL);

    COMMIT;
END;
/

CREATE OR REPLACE TRIGGER trg_transaction_after_insert_recurring
AFTER INSERT ON RecurringTransactions
FOR EACH ROW
DECLARE
    v_MaxTransactionID Transactions.TransactionID%TYPE;
BEGIN
    SELECT MAX(TransactionID) INTO v_MaxTransactionID FROM Transactions;

    -- If no existing transactions, set TransactionID to 1
    IF v_MaxTransactionID IS NULL THEN
        v_MaxTransactionID := 1;
    ELSE
        -- Increment the maximum TransactionID to generate a new one
        v_MaxTransactionID := v_MaxTransactionID + 1;
    END IF;

    INSERT INTO Transactions(TransactionID, UserID, TransactionType, Description, Amount, TransactionDate, PaymentMethod, TagID)
    VALUES (v_MaxTransactionID, :NEW.UserID, :NEW.TransactionType, :NEW.Description, :NEW.Amount, :NEW.StartDate, :NEW.PaymentMethod, NULL);

    COMMIT;
END;
/



set serveroutput on;
DECLARE
    v_Username Users.Username%TYPE := '&username'; -- Provide username input
    v_Password Users.Password%TYPE := '&password'; -- Provide password input
    v_UserCount INT;
BEGIN
    SELECT COUNT(*)
    INTO v_UserCount
    FROM Users
    WHERE Username = v_Username
    AND Password = v_Password;

    IF v_UserCount = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Login Successful');
        Login(v_Username, v_Password);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid username or password');
        -- Redirect to signup
        DBMS_OUTPUT.PUT_LINE('Redirecting to signup...');
        SignUp(v_Username, v_Password); -- Redirect to signup with the provided username and password
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid username or password');
        -- Redirect to signup
        DBMS_OUTPUT.PUT_LINE('Redirecting to signup...');
        SignUp(v_Username, v_Password); -- Redirect to signup with the provided username and password
END;
/
