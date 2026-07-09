create table Cash_Flow_Statements
(
Company_ID int,
Financial_year int,
Net_Income decimal,
Depreciation_Amortization decimal,
Capital_Expenditure decimal,
Change_In_Working_captal decimal,
Cash_From_Operating_Activities decimal,
Cash_From_Investing_Activities decimal,
Cash_From_Financing_Activities decimal,
Net_Change_in_cash decimal,
Free_cash_Flow decimal
)
select * from cash_flow_statements