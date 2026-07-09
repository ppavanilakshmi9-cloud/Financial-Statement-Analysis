create table Balance_Sheets
(
Company_ID int,
Financial_Year int,
Cash_And_CashEquivalents decimal,
Accounts_Receivable decimal,
Inventory decimal,
Other_Current_Assets decimal,
Property_Plant_Equipment decimal,
Intangible_Assets decimal,
Other_NonCurrent_Assets decimal,
Accounts_Payable decimal,
Short_Trm_Debt decimal,
Long_Term_Debt decimal,
Other_Liabilities decimal,
Share_Holders_Equity decimal
)
select * from balance_sheets
Alter table balance_sheets
drop column Company_Reference
alter table balance_sheets
add  Company_ID int

