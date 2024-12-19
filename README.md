# ExpenseTracker
## CHAPTER 1: INTRODUCTION
Keeping track of money can be tricky, especially with bills, savings, and spending all
happening at once. That's where our Expense Management System comes in. It's like a
digital notebook where you can write down all your money stuff—like how much you earn,
what you spend it on, and where you put your savings.
Our system is designed to make money management easy and understandable. You can see
where your money goes, how your investments are doing, and how close you are to reaching
your savings goals. It's like having a friendly helper to guide you through your finances.
Here's what our system can do:
- Record Transactions: Write down what you earn and what you spend. We'll keep track
of it all for you.
- Sort and Understand: We'll organize your transactions so you can see where you
spend the most and where you can save more.
- Track Investments: If you're investing money, we'll help you see how it's doing and if
it's making you more money.
- Manage Savings: Keep track of your savings goals and see how close you are to
reaching them.
- Remember Bills: We'll remind you about regular payments, like rent or utilities, so you
don't forget.

## CHAPTER 2: PROBLEM STATEMENT &
### OBJECTIVES
Problem Statement:
Managing personal finances in today's complex financial landscape is challenging. With
diverse income sources, various expenses, and fluctuating investment opportunities,
individuals often struggle to track income, monitor expenses, and plan for the future
effectively. This lack of financial clarity hampers decision-making and impedes progress
toward financial stability and long-term goals.
Objectives:
- Simplify Money Management: Our main goal is to create a system that simplifies
money management for individuals. We want to make it easy for users to track their income,
expenses, investments, and savings in one place.
- Provide Finacial Information: We aim to provide users with insights into their
financial activities. By categorizing transactions and generating reports, users can better
understand their spending habits, investment performance, and progress towards savings
goals.
- Help in Goal Achievement: Another objective is to help users achieve their financial
goals. Whether it's saving for a vacation, paying off debt, or investing for the future, our
system will provide tools and guidance to help users stay on track.


## CHAPTER 3: METHODOLOGY
### 3.1 : ER Diagram

![image](https://github.com/Aditya-1503/ExpenseTracker/assets/63710968/29f07d8e-c801-4bc7-8e7e-87cfcbac6c8a)

### 3.2 : Schema Conversion
#### Step 1: Identifying Strong Entity Sets:
1. User (UserID, Username, Password, Name, Email, Phone, Address)
2. Transactions (TransactionID, UserID, TransactionType, Description, Amount, Date,
PaymentMethod)
3. Investments (InvestmentID, UserID, InvestmentName, InvestmentType, Amount,
ReturnRate, StartDate, EndDate)
4. Expenses (ExpenseID, UserID, Category, Amount, Date, TagID)
5. RecurringTransactions (RecurringTransactionID, UserID, TransactionType, Description,
Amount, StartDate, EndDate, PaymentMethod, RecurrencePattern)
6. Savings (SavingID, UserID, BankName, AccountNumber, Amount, InterestRate)
7. Income (IncomeID, UserID, Source, Amount, Date)
8. Tags (TagID, TagName, Location, Date)
We create a table for each of these strong entity sets. </br>
#### Step 2: Identify Weak Entities Sets: The ER model has no weak entities. </br>
#### Step 3: Reduce the Relationship Set by assigning valid primary keys:
1. User-Transactions(TransactionID,UserID)
2. User-Expenses(ExpenseID,UserID)
3. User-RecurringTransactions(RecurringTransactionsID,UserID)
4. Tag-Transactions(TransactionID,TagID)
5. User-Income(IncomeID,UserID)
6. User-Investments(InvestmentID,UserID)
7. User-Savings(SavingID,UserID) </br>
#### Step 4: Remove Redundant Schemas: There are redundant schemas.</br>
#### Step 5: Merge the Schemas: The relationship sets get merged with the many end of their respective tables except the TransactionTags relationship set as it is a many-to-many relationship.</br>
#### Final Schema :</br>
1. User (UserID, Username, Password, Name, Email, Phone, Address)
2. Transactions (TransactionID, UserID, TransactionType, Description, Amount, Date, PaymentMethod)
3. Investments (InvestmentID, UserID, InvestmentName, InvestmentType, Amount, ReturnRate, StartDate, EndDate)
4. Expenses (ExpenseID, UserID, Category, Amount, Date, TagID)
5. RecurringTransactions (RecurringTransactionID, UserID, TransactionType, Description, Amount, StartDate, EndDate, PaymentMethod, RecurrencePattern)
6. Savings (SavingID, UserID, BankName, AccountNumber, Amount, InterestRate)
7. Income (IncomeID, UserID, Source, Amount, Date)
8. Tags (TagID, TagName, Location, Date)
9. TransactionTags (TransactionID, TagID)

### 3.3 : Normalisation
#### Step 1: Remove Redundant Data </br>
- The schema already appears to be in a relatively normalized form, as each table seems to represent a distinct entity or relationship.
- No redundant data seems present.</br>
#### Step 2: Identify Functional Dependencies: </br>
1. User: UserID -> Username, Password, Name, Email, Phone, Address
2. Transactions: TransactionID -> UserID, TransactionType, Description, Amount, Date, PaymentMethod
3. Investments: InvestmentID -> UserID, InvestmentName, InvestmentType, Amount, ReturnRate, StartDate, EndDate
4. Expenses: ExpenseID -> UserID, Category, Amount, Date, TagID
5. RecurringTransactions: RecurringTransactionID -> UserID, TransactionType, Description, Amount, StartDate, EndDate, PaymentMethod, RecurrencePattern
6. Savings: SavingID -> UserID, BankName, AccountNumber, Amount, InterestRate
7. Income: IncomeID -> UserID, Source, Amount, Date
8. Tags: TagID -> TagName, Location, Date
9. TransactionTags: (TransactionID, TagID) </br>
    
#### Step 3: Group Attributes into Tables: </br>
- Based on the identified dependencies, the schema appears to be already grouped into tables effectively.
No further normalization steps are necessary. </br>

### 3.4 : PL/SQL
- Procedures, If-Else, Exception Handling</br></br>
  ![image](https://github.com/Aditya-1503/ExpenseTracker/assets/63710968/6830ffb9-6493-44b1-8009-9ce360b832d1)

- Triggers</br></br>
 ![image](https://github.com/Aditya-1503/ExpenseTracker/assets/63710968/0540f416-e2ba-444a-9787-80b24d425a2a)

- Cursors</br></br>
  ![image](https://github.com/Aditya-1503/ExpenseTracker/assets/63710968/733e5d7a-6806-4331-82b3-4885aff732d3)

## CHAPTER 4: RESULTS & SNAPSHOTS
### 4.1 : DDL commands
- Create table </br></br>
  ![image](https://github.com/Aditya-1503/ExpenseTracker/assets/63710968/29df57c1-0eb0-4267-8a23-b101d9112480)

### 4.2 : DML commands
- Insert Values </br></br>
 ![image](https://github.com/Aditya-1503/ExpenseTracker/assets/63710968/6ad5ca4c-39f6-423c-ab7c-05aecf3e6d58)

- Queries (Group By and Having) </br></br>
  ![image](https://github.com/Aditya-1503/ExpenseTracker/assets/63710968/3c43b943-3698-4b17-9f48-c06176bfe76f)

- OrderBy </br></br>
  ![image](https://github.com/Aditya-1503/ExpenseTracker/assets/63710968/d50224fb-982b-4d17-9bc4-e32cf9f4e16b)

- Update </br></br>
  ![image](https://github.com/Aditya-1503/ExpenseTracker/assets/63710968/f200ee05-6401-415f-9435-4f8b2d5b93e5)

## CHAPTER 5: CONCLUSION
In conclusion, our Expense Management System offers a comprehensive solution to the
challenges individuals face in managing their personal finances. By providing a user-friendly
platform to track income, expenses, investments, and savings, our system aims to empower
users with the tools and insights needed to make informed financial decisions. Through
effective financial management, users can enhance their financial literacy, achieve their
financial goals, and ultimately strive towards greater financial stability and well-being.

## CHAPTER 6: LIMITATIONS & FUTURE WORK
### Limitations:
One limitation is the reliance on accurate and timely data input from users, which may be
subject to errors or omissions. Additionally, the system's effectiveness may be influenced by
external factors such as market volatility(affectiing the investments of the user) or economic
conditions, which are beyond its control.
### Future Work:
One area for future work is the integration of machine learning algorithms to provide more
personalized financial insights and recommendations to users. Additionally, expanding the
system's functionality to include features such as goal-based savings planning, debt
management tools, and financial education resources could further enhance its value to
users.
