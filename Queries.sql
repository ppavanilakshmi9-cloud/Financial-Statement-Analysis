 

--Top 5 companies With the Highest Gross profit
select top 5 I.company_ID,c.company_name,I.gross_profit
from Income_statements as I
inner join 
companies as c
on c.company_id = I.company_id
order by I.gross_profit desc

--Companies Whose Net Income is greater than 50000
select company_id,net_income 
from Income_statements
where net_income > 50000

--companies whose Operating margin is greater than 25%
select company_id,Operating_income,Revenue,
((operating_income * 100.0)/revenue) as Operating_margin
from Income_statements 
where ((operating_income * 100.0)/revenue) > 25

--Top 3 companies with the Highest  Cash & CashEquivalents
select  top 3 Company_Id,
cash_And_CashEquivalents as HighestcashAndCashEquivalents
from Balance_sheets
order by HighestcashAndCashEquivalents desc

--companies whose inventory is less than 10000
select company_id,inventory
from Balance_sheets
where inventory < 10000

--Display company name,Revenue,Net Income order by Revenue(Highest first)
select c.company_name,I.Revenue,I.Net_Income
from companies as c
inner join income_statements as I
on C.company_Id = I.Company_id
order by Revenue desc


--Display company name,Total assets,Net Income order by total assets
select c.company_name,I.net_income,
(
b.cash_and_cashEquivalents + 
b.Accounts_Receivable + 
b.Inventory +
b.other_current_assets + 
b.Property_plant_Equipment +
b.Intangible_assets +
b.Other_noncurrent_assets
)
as totalassets
from companies as c
inner join Income_statements as I
on c.company_id = I.company_id
inner join Balance_sheets as b
on c.company_id = b.company_id
order by totalassets desc

--Display company Name,CFO,Capital expenditure,Free cash flow
select c.company_name,CF.cash_from_operating_Activities,CF.capital_Expenditure,
(CF.cash_from_Operating_activities - CF.Capital_Expenditure) as FreeCashFlow
from companies as c
inner join Cash_flow_statements as CF
on c.company_id = CF.Company_id

--company with the Highest Revenue per Total Assets
select top 1 I.company_id,I.Revenue/
(
B.cash_and_cashequivalents +
B.Accounts_receivable +
B.Inventory +
B.Other_current_assets +
B.Property_plant_Equipment +
B.Intangible_assets +
B.Other_noncurrent_assets
) as HighestRevenueperTotalAssets
from companies as c
inner join balance_sheets as B
on c.company_id = B.company_id
inner join Income_statements as I
on c.company_id = I.company_id

--All companies Where Revenue greater than 300000 AND Net Income greater than 50000
select Company_id, Revenue,Net_income
from Income_statements
where revenue > 300000 AND Net_income > 50000

--Calculate Gross margin % for every Company
select company_id,((gross_profit * 100.0)/Revenue)
as Gross_Margin
from Income_statements

--Calculate Operating margin % for every Company
select company_id,((operating_income*100.0)/Revenue)
as Operating_margin
from Income_statements

--Calculate Net profit margin % for every Company
select *
from
(
 select company_id,Net_income,Revenue,((net_income*100.0)/Revenue)
 as NetProfit_Margin
 from Income_statements
 )t

--Calculate ROA for every Company
select *,(I.Net_Income/(t.Totalassets)*100.0)
from
(
select
  company_id, 
 (cash_and_cashEquivalents+
  Accounts_Receivable+
  Inventory+
  Other_current_Assets+
  property_plant_equipment+
  Intangible_Assets+
  Other_noncurrent_assets) as TotalAssets
 from Balance_sheets as B
 )t
 inner join income_statements as I
 on I.company_id = t.company_id

--Calculate Free cash Flow  for every Company
select company_id,(cash_from_operating_activities - capital_Expenditure) as FreeCashFlow
from Cash_flow_Statements

--Which company generated Highest Operating cashFlow
select top 1 company_id,
max(Cash_from_operating_activities) as HighestCFO
from cash_flow_statements
order by HighestCFO desc

--Which company invested most in Capital Expenditure
select top 1 c.company_name,
max(CF.cash_from_investing_activities)  as HighestCapEx
from companies as c
inner join Cash_flow_statements as CF
on c.company_id = CF.company_id
group by company_name
order by HighestCapEx desc

--Find companies with Revenue > 200000,Total Assets > 300000, Net Income > 50000
select I.company_id,I.Revenue,t.TotalAssets,I.Net_income
from Income_statements as I
Inner join
(
  select company_id,
    (cash_and_cashEquivalents+
     Accounts_Receivable+
     Inventory+
     Other_current_Assets+
     property_plant_equipment+
     Intangible_Assets+
     Other_noncurrent_assets
     ) as TotalAssets
     from Balance_sheets 
   )t
   on I.company_id = t.company_id
 where I.revenue > 200000 AND t.Totalassets >300000 AND I.Net_income > 50000

 --Which company has the highest EPS
 select  top 1 company_id,max(Basic_EPS) as HighestEPS
 from Income_statements
 group by company_id
 order by HighestEPS desc

 --Top 3 most profitable companies based on net income
 select top 3 company_id,net_income
 from income_statements
 order by net_income desc
 
 --Rank companies by Revenue
 select company_id,revenue,
   rank() over ( order by revenue desc) as RankRevenue
  from income_statements
 
 --Rank companies by Net Income
 select company_id,net_income,
 rank() over(order by net_income desc) as RankNI
 from Income_statements
 
 --Show companies Whose Revenue is above the average Revenue
 select *
 from Income_statements
 where revenue >
 (
  select avg(revenue) as avgrevenue
  from Income_statements
  )

--Show companies Whose Net Income is above the average Net Income
 select *
 from Income_statements
 where Net_Income >
 (
 select  Avg(net_income) as AVGNI
 from Income_statements
 )
 
  --create a report with company Name,Revenue,Gross Profit,Operating Income,Net Income<Total Assets,Free Cash Flow order it by net income desc
 select c.company_name,I.Revenue,I.Gross_profit,I.Operating_income,I.Net_income,
 (
B.cash_and_cashequivalents +
B.Accounts_receivable +
B.Inventory +
B.Other_current_assets +
B.Property_plant_Equipment +
B.Intangible_assets +
B.Other_noncurrent_assets
) as TotalAssets,
(CF.cash_from_operating_activities-CF.capital_Expenditure) as FreeCashFlow
 from companies as c
 inner join Income_statements as I
 on c.company_id = I.company_id
 inner join Balance_sheets as B
 on c.company_id = B.company_id
 inner join cash_flow_statements as CF
 on c.company_id = CF.company_id

 --Top 5 companies by Revenue
 select top 5 * from Income_statements
 order by Revenue desc

 --Bottom 5 companies by Net income
 select top 5 * from Income_statements
 order by Net_income asc

 --companies with Gross Margin above 50%
 select company_id,(gross_profit * 100.0/Revenue) as GrossMargin
 from Income_statements
 where (gross_profit * 100.0/Revenue) > 50

 --Companies whose operating income is greater than Net income
 select company_id,operating_income,Net_income 
 from income_statements
 where operating_income > Net_income

 --Highest Revenue per Total Assets
 select I.company_id,(I.revenue/t.TotalAssets) as HighestRevenueperTA
 from Income_statements as I
 inner join VW_TotalAssets as t
 on I.company_id = t.company_id

--Companies whose cash flow from operations is greater than Net income
 select CF.company_id,CF.Cash_from_operating_activities,I.net_income
 from cash_flow_statements as CF
  inner join income_statements as i
  on CF.company_id = I.company_id 
 where CF.cash_from_operating_activities >I.net_income

--Rank companies by revenue
  select *,
 rank() over(order by Revenue desc) as RankRevenue
 from Income_statements

 --Rank companies by Net Income
 select *,
 rank() over(order by net_income desc) as RankNI
 from Income_statements

 --Dense Rank companies by EPS
 select *,
 dense_rank() over(order by Basic_eps desc) as RankEPS
 from income_statements
 
 --Row Number based on Revenue
 select company_id,revenue,
 Row_Number ( ) over( order by Revenue desc) as RowRevenue
 from income_statements
 
 --Companies whose EPS is above average
 select company_id,basic_EPS
 from Income_statements
 where Basic_EPS >
  (
   select avg(Basic_EPS) from Income_statements
   )

 --Companies whose revenue is above average
 select company_id,revenue 
 from income_statements
 where revenue >
  (
   select avg(revenue) from Income_statements
   )

 --companies whose Net income is below average
 select company_id,Net_income 
 from Income_statements
 where net_income <
   (
   select avg(net_income) from Income_statements
   )

 --Companies with highest Free Cash Flow
 select  top 1 company_id,(cash_from_operating_activities-capital_expenditure) as FCF from
 cash_flow_statements
 order by FCF desc

 --Calculate Return on Sales
 select company_id,(operating_income*100.0/Revenue) as Returnonsales
 from income_statements

 --calculate operating margin
  select * from VW_Operatingmargin
 
 --Find companies having total assets above Average
 select * from VW_TotalAssets
 where totalassets >
 (
 select avg(totalassets) from  VW_TotalAssets
 )

 --Highest Accounts Receivable
 select top 1 B.company_id,c.company_name,max(B.Accounts_receivable) as HighestAR
 from companies as c
 inner join balance_sheets as B
 on c.company_id=B.company_id
 group by B.company_id,c.company_name

 --Highest Inventory
 select top 1 company_id,max(inventory) as HighestInventory
 from balance_sheets
 group by company_id

 --Calculate current assets
 select company_id,
       (cash_and_cashEquivalents +
        Accounts_Receivable +
        Inventory +
        Other_Current_assets) as CurrentAssets
from balance_sheets

--calculate Non current Assets
  select  company_id,(Property_plant_equipment +
           Intangible_assets +
           other_noncurrent_assets) as NonCurrentAssets 
from balance_sheets

--Display company name,Revenue,Net income,CFO,Total Assets in one query
select  c.company_id,c.company_name,I.revenue,I.net_income,CF.cash_from_operating_activities,T.TotalAssets
from companies as c
inner join income_statements as I
on c.company_id = I.company_id
inner join cash_flow_statements as CF
on c.company_id = CF.company_id
inner join VW_TotalAssets as T
on c.company_id = t.company_id

 --Find companies with Revenue > Average Revenue,Net income > Average Net income, CFO > average CFO
 select I.company_id,I.Revenue,I.Net_income,CF.cash_from_operating_activities
 from income_statements as I
 inner join cash_flow_statements as CF
 on I.company_id = CF.company_id
  where I.revenue >
            (
               select avg(revenue) from Income_statements
               )
      and  I.Net_income >
               (
               select avg(Net_income) from Income_statements
               ) 
   and    CF.cash_from_operating_activities >
                (
                  select avg(cash_from_operating_activities) from cash_flow_statements
                  )

 /*Create a report showing company name,revenue,Gross profit,Operating income,Net Income,Free cash flow
 ,operating margin,Net profit margin,Total assets sort by revenue DESC*/
 Go 
 create view  VW_operatingMargin as
 (
 select  company_id,(operating_income*100.0/revenue) as OperatingMargin
 from Income_statements
 )
 select * from  VW_operatingMargin;
 Go

 create view  VW_NetProfitMargin as
 (
 select company_id,(net_income*100.0/revenue) as NetProfitMargin
 from income_statements
 )
 select * from  VW_NetProfitMargin;

 alter  view VW_TotalAssets as
 (
 select company_id,
       (  cash_and_cashequivalents +
          Accounts_receivable +
          Inventory +
          Other_current_assets +
          Property_plant_Equipment +
          Intangible_assets +
          Other_noncurrent_assets
         ) as TotalAssets
      from Balance_sheets
  )
  select * from VW_TotalAssets


with CTE_FreeCashFlow as
(
select  company_id,
  (Cash_from_Operating_activities-capital_Expenditure) as FCF
from Cash_flow_statements
 )
 select c.company_name,I.revenue,I.gross_profit,I.Operating_income,I.net_income,
       cte.FCF,t.TotalAssets
       from companies as c
inner join VW_TotalAssets as t
 on c.company_id = t.company_id
inner join Income_statements as I
on c.company_id=I.company_id
inner join VW_OperatingMargin as O
on c.company_id = o.company_id
inner join VW_NetprofitMargin as N
on c.company_id = N.company_id
inner join balance_sheets as B
on c.company_id = B.company_id
inner join  CTE_FreeCashFlow as cte
on c.company_id = Cte.company_id
order by revenue desc

--Assign a row number to each company based on revenue (Highest Revenue gets Row number 1
select *,
row_number() over( order by revenue desc) as RowRevenue
from Income_statements

--rank companies by Revenue
select *,
rank() over(order by Revenue desc) as RankRevenue
from Income_statements

--Rank companies by net income using DENSE_Rank
select *,
Dense_rank() over(order by net_income desc) as DenseRankNI
from Income_statements

--show the top 3 companies by Revenue using a window function instead of tOP
with CTE_Revenue as
(
select company_id,Revenue,
       Row_number() over(order by Revenue desc) as RowNumberRevenue
from Income_statements
)
 select company_id,Revenue from CTE_Revenue
 where RowNumberRevenue <=3

--Display each company's revenue and the previous company's Revenue using LAG()
select company_id,Revenue,
LAG(Revenue,1,0) over(order by Revenue desc) as PreviousCompanyRevenue
from Income_statements

--Display each company's revenue and the previous company's Revenue using LEAD()
select company_id,Revenue,
LEAD(Revenue,1,0) over(order by Revenue desc) as PreviouscompanyRevenue
from Income_statements

--Show a running total of Revenue
select company_id,Revenue,
sum(Revenue) over(order by revenue desc) as Runningtotal
from Income_statements

--Find the companies whose revenue is greater than the previous company's Revenue
with CTE_previousRevenue as
(
select company_id,Revenue,
LAG(Revenue,1,0) over(order by Revenue desc) as previousCompanyRevenue
from Income_statements
)
select company_id,Revenue
from CTE_PreviousRevenue
where revenue > previousCompanyRevenue

--Find companies whose Net Income increased compared to the previous ranked company.
with CTE_PreviousNI as
(
select company_id,Net_income,
LAG(Net_income,1,0) over(order by net_income desc) as PrevNI
from Income_statements
)
select company_id,Net_income
from CTE_PreviousNI
where Net_income > PrevNI

--prepare a report showing company name,revenue,Revenue Rank,Previous Revenue,Difference from previous Revenue
With CTE_Revenue as
(
select c.company_name,I.Revenue,
Rank() over(order by I.Revenue desc) as RevenueRank,
LAG(I.Revenue,1,0) over(order by I.Revenue desc) as PrevRevenue
from companies as c
inner join Income_statements as I
on c.company_id = I.company_id
)
select*,(Revenue-PrevRevenue) as RevenueDiff
from CTE_Revenue

/*classify companies based on
  .Revenue > 100000 High Revenue
  .revenue  between 50000 and 100000 medium Revenue
  .Otherwise Low Revenue*/
   select *, 
   case
        when revenue > 100000 then 'High Revenue'
        when revenue  Between 50000 and 100000 then 'Medium Revenue'

        else 'Low Revenue' 
   END
   as RevenueClassification
   from Income_statements

 /*Classify companies based on Net profit margin
   .20% Excellent
   .10-20% Good
   .<10% poor */
select *,
     case
         when NetProfitMargin > 0.20 then 'Excellent'
         When  NetProfitMargin Between 0.10 and 0.20 then 'Good'
        Else 'Poor'
      END
from VW_NetProfitMargin
   
 /*Display company_name,Revenue,Net Income,profit status
    Rules:
    NI>0 profit
    NI=0 Break Even
    NI<0 Loss*/
    select c.company_name,I.Revenue,I.Net_income,
        case
           when I.Net_income >0 then 'Profit'
           when I.Net_income =0 then 'Break even'
           Else 'Loss'
        End as ProfitStatus
From companies as c
inner join Income_statements as I
on c.company_id = I.company_id


--find companies whose operating margin is above the overall average operating margin
select * from VW_OperatingMargin
where Operatingmargin >
(
   select avg(operatingMargin) as AverageOM
   from VW_OperatingMargin
   )
   
 --Find companies with Highest Return On Assets (ROA)
 select top 1 company_id,(operating_income*100.0/TotalAssets)
 as HighestROA
 from
 (
     select I.company_id,I.Operating_income,t.TotalAssets
     from Income_statements as I
     inner join VW_TotalAssets as t
     on I.company_id = t.company_id
  )t

--Find companies whose Current Ratio is greater than 10
alter view VW_CurrentRatio as

select company_id, ((cash_And_cashEquivalents + Accounts_Receivable + inventory + other_current_assets)/ (Accounts_payable))
      as CurrentRatio
 from Balance_sheets
 
 select * from VW_CurrentRatio  
 where CurrentRatio > 10
 
 --Find companies whose Debt-to-equity Ratio is less than 1
 create View VW_DebtToEquityRatio as
 (
 select company_id,((Accounts_payable + short_trm_debt +Long_term_debt + other_liabilities)/(share_holders_Equity))
 as DebtToEquityRatio
 from balance_sheets
 )
 select * from VW_DebtToEquityRatio
 where DebtToEquityRatio < 1

--Display company name,Revenue,Running Revenue,Revenue Rank,Previous Revenue,next revenue
select c.company_name,I.Revenue,
sum(I.Revenue) over(order by I.Revenue desc) as RunningRevenue, 
Rank() over(order by I.Revenue desc) as RevenueRank,
LAG(I.Revenue,1,0) over(order by I.Revenue desc) as PreviousRevenue,
LEAD(I.Revenue,1,0) over(order by I.Revenue desc) as NextRevenue
from companies as c
inner join Income_statements as I
on c.company_id = I.company_id

 /*Display companies whose Revenue is greater than the previous company's Revenue
    Return:
    company name,Revenue,Previous Revenue status(increased/Decreased)*/
select *,
 case
    when Revenue > PrevRevenue then 'Increased'
    when Revenue < PrevRevenue then 'Decreased'
 END as RevenueStatus
from
(
 select c.company_name,I.Revenue,
 LAG(I.Revenue,1,0) over(order by I.Revenue desc) as PrevRevenue
 from companies as c
 inner join Income_statements as I
 on c.company_id = I.company_id
 )t

 /*Create one final report showing:
     company name,Revenue,GrossMargin,operating Margin,Net profit Margin,ROA,FCF,RevenueRank,Revenue category(HIGH/Medium/Low)
     sort by Revenue(highest first)*/
     select *,
        case 
           when RevenueRank between 1 and 3 then 'High'
           when RevenueRank = 4 then 'Medium'
           Else 'Low'
         END as RevenueCategory
     from
     (
        select c.company_name,(I.gross_profit*100.0/I.Revenue) as Grossmargin,O.OperatingMargin,N.NetprofitMargin,(I.Operating_income*100.0/t.totalAssets) as ROA,
     Rank() over(order by I.Revenue desc) as RevenueRank
     from companies as c
     inner join VW_NetProfitMargin as N
     on c.company_id = N.company_id
     inner join VW_OperatingMargin as O
     on c.company_id = O.company_id
     inner join Income_Statements as I
     on I.company_id = c.company_id
     inner join VW_TotalAssets as t
     on c.company_id = t.company_id
     )t

 --create a CTE to calculate FCF,Display companyname,Revenue,FCF
 with CTE_FCF as
 (
 select company_id,(cash_from_operating_activities-capital_Expenditure) as FCF
 from cash_flow_statements
 )
 select c.company_name,I.Revenue,F.FCF
 from companies as c
 inner join Income_statements as I
 on c.company_id = I.company_id
 inner join CTE_FCF as F
 on c.company_id = F.company_id

--Using Two CTE's,CTE 1:Totsl Assets,CTE:2 Operating margin,Display company name,Total asets,Operating margin
with CTE_TotalAssets as
(
select * from VW_TotalAssets
),
 CTE_OperatingMargin as
 (
 select  * from VW_OperatingMargin
 )
 select company_name,TotalAssets,OperatingMargin
 from companies as c
 inner join CTE_TotalAssets as t
 on c.company_id= t.company_id
 inner join CTE_OperatingMargin as O
 on c.company_id = O.company_id

 alter view VW_FCF as
 (
 select company_id, (cash_from_operating_activities-capital_expenditure) as FCF
 from Cash_flow_statements
 )

--Create a report showing companies whose:: revenue > Average revenue,Total Assets > Average Total assets,FCF > average FCF
select c.company_name,I.revenue,t.TotalAssets,F.FCF 
from companies as c
inner join income_statements as I
on c.company_id = I.company_id
inner join VW_FCF as F
on c.company_id= F.company_id
inner join VW_TotalAssets as t
on c.company_id = t.company_id
where revenue >
          (
            select avg(revenue) from income_statements
           ) and
       TotalAssets >
           (
             select avg(TotalAssets) from VW_TotalAssets
           ) and
           FCF >
           (
            select avg(FCF) from VW_FCF
            )

 --using a CTE,calculate rOA,Displaay only companies where ROA > 10%

  with CTE_ROA as
 (
 select I.company_id,(I.Net_income/t.TotalAssets) as ROA
 from income_statements as I
 inner join VW_Totalassets as t
 on I.company_id = t.company_id
 )
 select * from CTE_ROA
 where ROA >0.10

 --Find the Top 5 companies by Operating Margin,Dont use top 
 select *,
 Row_number() over(order by OperatingMargin) as Top5companies
 from VW_OperatingMargin

  --Display company name,Revenue,revenue rank,Operating margin,Operating margin Rank
  select c.company_name,I.Revenue,OperatingMargin,
  Rank() over(order by I.Revenue desc) as RevenueRank,
  Rank() over(order by O.OperatingMargin desc) as OperatingmargiRank
  from companies as c
  inner join Income_statements as I
  on c.company_id = I.company_id
  inner join VW_OperatingMargin as O
  on c.company_id = O.company_id

--create a CTE containing:company id,Revenue,Net income,Net profit margin,then display companies whose net profit margin is above average
with CTE_companiesDetails as
(
select I.company_id,I.Revenue,I.Net_income,N.NetProfitMargin
from Income_statements as I
inner join VW_NetprofitMargin as N
on I.company_id = N.company_id
)
select * from CTE_companiesDetails 
where NetProfitMargin >
            (
              select avg(Netprofitmargin) from CTE_companiesDetails
            )

/*Prepare a Financial health report,
  Display:company name,Revenue,Net Income,Total Assets,FCF,Current Ratio,Debt-toEquity Ratio
  Add a CASE column Excellent,Good,Poor*/
  select c.company_name,I.Revenue,I.Net_income,t.TotalAssets,F.FCF,CR.CurrentRatio,D.DebtToEquityRatio,
    case
      when D.DebtToEquityRatio < 1 and CR.CurrentRatio >= 2 then 'Excellent'
      when D.DebtToEquityRatio < 2 and CR.CurrentRatio >= 1 then 'Good'
      Else 'Needs Review'
  END as FinancialHealth
  from companies as c
   inner join Income_statements as I
  on c.company_id = I.company_id
  inner join VW_TotalAssets as t
  on c.company_id = t.company_id
  inner join VW_FCF as F
  on c.company_id = F.company_id
  inner join VW_CurrentRatio as CR
  on c.company_id= CR.company_id
  inner join VW_DebtToEquityRatio as D
  on c.company_id = D.company_id 


 /* Find companies where:
    CFO > Net Income
    Operating Margin > Net profit Margin*/
    select c.company_id,company_name 
    from companies as c
    inner join income_statements as I
    on c.company_id = I.company_id
    inner join cash_flow_statements as CF
    on c.company_id = CF.company_id
    inner join VW_OperatingMargin as O
    on c.company_id = o.company_id
    inner join VW_NetProfitMargin as N
    on c.company_id = N.company_id
    where  CF.cash_from_operating_activities > I.net_income and
          O.OperatingMargin > N.NetProfitMargin

--Creating View for ReturnOnAssets

create view VW_ROA as
select I.company_id,((I.Net_income*100.0)/(t.totalassets)) as ReturnOnAssets
from income_statements as I
inner join VW_Totalassets as t
on I.company_id = t.company_id
select * from VW_ROA

/* Prepare one sql query returning:
 company name,revenue,gross margin,operating margin,Net profit Margin,ROA<FCF,Revenue Rank,Financial Health,sort by Revenue DESC*/
 
 select *,
 case
    when RevenueRank <=2 then 'Excellent'
    when RevenueRank <=5 then 'Good'
    Else 'Poor'
End as FinancialHealth from
 (
 select c.Company_name,I.Revenue,(I.gross_profit/I.Revenue) as GrossMargin,O.OperatingMargin,N.NetProfitMargin,F.FCF,
    rank() over(order by Revenue) as RevenueRank
from companies as c
inner join Income_statements as I
on c.company_id = I.company_id
inner join VW_operatingMargin as O
on c.company_id = O.company_id
inner join VW_NetProfitMargin as N
on c.company_id = N.company_id
inner join VW_FCF as F
on c.company_id = F.company_id
inner join VW_ROA as R
on c.company_id = R.company_id
)t

--Top 3 companies by ROA,Expected columns: Company name,RoA
select top 3 c.company_name,R.ReturnOnassets
from companies as c
inner join VW_ROA as R
on c.company_id = R.company_id
order by R.ReturnOnassets desc

--companies whose operating margin is greater than the average operating margin
select * from VW_OperatingMargin
where  operatingMargin > 
(
select avg(OperatingMargin)  from VW_OperatingMargin
)

--companies whose  ROA is greater than average ROA
select * from VW_ROA
where  ReturnOnAssets > 
(
select avg(ReturnOnAssets)  from VW_ROA
)

--Rank companies by ROA
select*,
rank() over(order by ReturnOnAssets desc) as RANKROA
from VW_ROA
--companies with the highest Asset Turnover Ratio

with CTE_AssetTurnOverRatio as
(
select I.company_id,(I.Revenue/t.TotalAssets) as AssetTurnOverRatio
from Income_statements as I
inner join VW_TotalAssets as t
on I.company_id=t.company_id
)
select top 1 company_id,AssetTurnOverRatio 
from CTE_AssetTurnOverRatio
order by AssetTurnOverRatio desc

--create a Financial Score,ROA and current Ratio
select R.company_id,
case
    when R.ReturnOnAssets >20 and CR.CurrentRatio >2 then 'Excellent'
      when R.ReturnOnAssets >10 then 'Good'
      Else 'Poor'
      End as Financialscore
from VW_ROA as R
inner join VW_CurrentRatio as CR
on R.company_id=CR.company_id

--Find companies satisfying all conditions,Revenue>avgRevenue,ROA>AvgROA,CurrentRatio>2,Debt-to-Equity Ratio<1
select I.company_id,I.Revenue,CR.CurrentRatio,D.DebtToEquityRatio,R.ReturnOnAssets
from Income_statements as I
inner join VW_currentRatio as CR
on I.company_id = CR.company_id
inner join VW_ROA as R
on I.company_id = R.company_id
inner join VW_DebtToEquityRatio as D
on I.company_id=D.company_id
where Revenue >
            (select avg(Revenue) from Income_statements) and
       ReturnOnAssets >
            (select avg(ReturnOnAssets) from VW_ROA) and
        CurrentRatio > 2 and DebtToEquityRatio <1


/*Display company performance summary
 company name,Revenue,GrossMargin,Operating margin,NetProfitMargin,ROA,
 Current Ratio,Debt-to-Equity Ratio,Revenue Rank,Financial health*/
 alter View VW_FinancialHealth as
 (
 select c.company_name,I.company_id,I.Revenue,(I.Gross_profit/I.Revenue) as GrossMargin,O.operatingMargin,
        N.netProfitMargin,R.ReturnOnAssets,CR.currentRatio,D.DebtToEquityRatio,
         Rank() over(order by Revenue desc) as Revenuerank
        from companies as c
        inner join Income_statements as I
   on c.company_id = I.company_id
   inner join VW_TotalAssets as t
   on c.company_id = t.company_id
   inner join VW_ROA as R
   on c.company_id = R.company_id
   inner join VW_FCF as F
   on c.company_id =F.company_id
   inner join VW_CurrentRatio as CR
   on c.company_id = CR.company_id
   inner join VW_DebtToEquityRatio as D
   on c.company_id = D.company_id
    inner join VW_OperatingMargin as O
   on c.company_id = O.company_id
    inner join VW_NetProfitmargin as N
   on c.company_id = N.company_id
   )
   select *,
    case
        when Revenuerank <=2 then 'Excellent'
        when RevenueRank >=3 then 'Good'
        Else 'Poor'
    End as FinancialReport
  from VW_FinancialHealth
   
--Running Total of Revenue,Display:company name,Revenue,Running Revenue
select c.company_name,I.Revenue,
sum(I.Revenue) over(order by I.Revenue desc) as RunningRevenue
from companies as c
inner join income_statements as I
on c.company_id=I.company_id

 /*create one single query that returns:
   company name,Revenue,GrossProfit,Operating Income,NetIncome,Total Assets,FCF
   GrossMargin,OperatingMargin,NetProfitMargin,ROA,CurrentRatio,Debt-to-Equity Ratio
   Revenue Rank,Financial Health,sort by RevenueRank*/
   with CTE_companyDetails as
   (
       select c.company_name,I.Revenue,I.Gross_profit,I.Operating_income,I.Net_income,t.TotalAssets,F.FCF,
          (I.Gross_profit/I.Revenue) as GrossMargin,O.OperatingMargin,N.NetProfitMargin,
          R.ReturnOnAssets,CR.CurrentRatio,D.DebtToEquityRatio,
          rank() over(order by Revenue desc) as RevenueRank
   from companies as c
   inner join Income_statements as I
   on c.company_id = I.company_id
   inner join VW_TotalAssets as t
   on c.company_id = t.company_id
   inner join VW_ROA as R
   on c.company_id = R.company_id
   inner join VW_FCF as F
   on c.company_id =F.company_id
   inner join VW_CurrentRatio as CR
   on c.company_id = CR.company_id
   inner join VW_DebtToEquityRatio as D
   on c.company_id = D.company_id
    inner join VW_OperatingMargin as O
   on c.company_id = O.company_id
    inner join VW_NetProfitmargin as N
   on c.company_id = N.company_id
   )
   select *,
    case
        when currentratio >2 and DebtToEquityRatio<1 and ReturnOnAssets>=10 and FCF>0 then 'Excellent'
        when currentratio >=1.5 and DebtToEquityRatio<2 and  FCF>0 then 'Good'
        Else 'Poor'
    End as FinancialHealth
    from CTE_companyDetails

/*creating VIEW for AssetTurnOverRatio*/
create view  VW_AssetTurnOverRatio as
(

select I.company_id,(I.Revenue/t.TotalAssets) as AssetTurnOverRatio
from Income_statements as I
inner join VW_TotalAssets as t
on I.company_id=t.company_id
)

--Top 3 companies by AssetTurnOverRatio,Display company name,AssetTurnoverRatio
select top 3 c.company_name,AssetTurnOverRatio
from companies as c
inner join  VW_AssetTurnOverRatio as A
on c.company_id = A.company_id
order by AssetTurnOverRatio desc

--companies with ROA than the Industry Average
select * from VW_ROA
where ReturnOnAssets >
 (
 select avg(ReturnOnAssets) from VW_ROA
 )

--rank companies by FinancialHealth

with CTE_Health as
(
select Company_name,Revenue,
 case
        when currentratio >2 and DebtToEquityRatio<1 and ReturnOnAssets>=10 and FCF>0 then 'Excellent'
        when currentratio >=1.5 and DebtToEquityRatio<2 and  FCF>0 then 'Good'
        Else 'Poor'
    End as FinancialHealth
from companies as c
inner join Income_statements As I
on c.company_id=I.company_id
inner join VW_currentratio as CR
on c.company_id=CR.company_id
inner join VW_ROA as R
on c.company_id = R.company_id
inner join VW_DebtToEquityRatio as D
on c.company_id = D.company_id
inner join VW_FCF as F
on c.company_id = F.company_id
)
select *,
Rank() over(order by 
 case 
 when FinancialHealth = 'Excellent' then 1
 when FinancialHealth ='Good' then 2
 Else 3
 END,Revenue desc) as FinancialHealthRank
 from CTE_Health

--Use DENSE_Rank,display company name,Revenue,Revenue Rank,Revenue_Dense_Rank
select c.company_name,I.Revenue,
Rank() over(order by I.Revenue desc) as RevenueRank,
DENSE_rank() over(order by I.Revenue desc) as RevenueDENSERank
from companies as c
inner join Income_statements as I
on c.company_Id=I.company_id

--Use Row_number,Display company name,Revenue,Row number order by Revenue desc
select c.company_name,I.Revenue,
Row_number() over(order by I.Revenue desc) as RowNumberRevenue
from companies as c
inner join Income_statements as I
on c.company_id=I.company_id

--Divide companies into performance groups using NTILE
with CTE_Performance as
(
select c.company_name,
       case
        when CR.currentratio >2 and D.DebtToEquityRatio<1  and F.FCF>0 then 'Excellent'
        when CR.currentratio >=1.5 and D.DebtToEquityRatio<2 and  F.FCF>0 then 'Good'
        Else 'Poor'
    End as FinancialHealth
    from companies as c
    inner join VW_currentratio as CR
on c.company_id=CR.company_id

inner join VW_DebtToEquityRatio as D
on c.company_id = D.company_id
inner join VW_FCF as F
on c.company_id = F.company_id
)
select *,
  NTILE(3) over(order by 
                         case 
                           when FinancialHealth = 'Excellent' then 1
                           when FinancialHealth ='Good' then 2
                           Else 3
                         END)
                as PerformanceGroup
  from CTE_Performance


--compare each companies revenue with the previous company
select company_name,Revenue,
LAG(Revenue,1,0) over(order by Revenue desc) as PreviousCompany
from companies as c
inner join Income_statements as I
on c.company_id=I.company_id
--compare each companies revenue with the Next company
select company_name,Revenue,
LEAD(Revenue,1,0) over(order by Revenue desc) as NextCompany
from companies as c
inner join Income_statements as I
on c.company_id=I.company_id
/*Executive Financial summary Query,Display:
     company name,Revenue,GrossMargin,OperatigMargin,NetProfitMargin,ReturnOnAssets,
     AssetTurnOverRatio,CurrentRatio,DebttoEquityRatio,FCF,RevenueRank,FinancialHealth
sort vy Revenue DESC*/
alter View VW_company_Metrics as
(
select c.company_id,c.company_name,I.Revenue,(I.Gross_profit/I.Revenue) as GrossMargin,N.NetProfitmargin,R.ReturnOnAssets,
       A.AssetTurnOverRatio,CR.CurrentRatio,O.OperatingMargin,F.FCF,
       Rank() over(order by Revenue desc) as RevenueRank
        from companies as c
   inner join Income_statements as I
   on c.company_id = I.company_id
   inner join VW_TotalAssets as t
   on c.company_id = t.company_id
   inner join VW_ROA as R
   on c.company_id = R.company_id
   inner join VW_FCF as F
   on c.company_id =F.company_id
   inner join VW_CurrentRatio as CR
   on c.company_id = CR.company_id
   inner join VW_DebtToEquityRatio as D
   on c.company_id = D.company_id
    inner join VW_OperatingMargin as O
   on c.company_id = O.company_id
    inner join VW_NetProfitmargin as N
   on c.company_id = N.company_id
   inner join  VW_AssetTurnOverRatio as A
   on c.company_id = A.company_id
   )
   select *,
         case
              when RevenueRank <=2 then 'Excellent'
              when RevenueRank<=5 then 'Good'
              Else 'Needs Review'
         End as FinancialHealth
    from VW_company_metrics

/*Final DashBoard DataSet:
   company name,Revenue,gross profit,Operating income,Net income,Total assets,FCF,Gross Margin,Operating margin
   NetProfitMargin,ROA,AsssetTurnoverRatio,CurrentRatio,DebtToEquityRatio,RevenueRank,ROARank,FinancialHealth
sort by RevenueRank*/
  With CTE_FinalReport as
  (
  select c.company_id,c.company_name,I.Revenue,(I.Gross_profit/I.Revenue) as GrossMargin,N.NetProfitmargin,
       A.AssetTurnOverRatio,CR.CurrentRatio,O.OperatingMargin,F.FCF,I.Gross_profit,I.operating_income,I.Net_income,t.TotalAssets,
       R.ReturnOnAssets,D.DebtToEquityRatio,
  Rank() over(order by I.Revenue desc) as RevenueRank,
   Rank() over(order by R.ReturnOnAssets desc) as RankROA
  from VW_company_metrics as CM
  inner join Income_statements as I
  on CM.company_id = I.company_id
  inner join VW_TotalAssets as t
  on cm.company_id = t.company_id
  inner join VW_ROA as R
   on cm.company_id = R.company_id
   inner join VW_FCF as F
   on cm.company_id =F.company_id
   inner join VW_CurrentRatio as CR
   on cm.company_id = CR.company_id
   inner join VW_DebtToEquityRatio as D
   on cm.company_id = D.company_id
    inner join VW_OperatingMargin as O
   on cm.company_id = O.company_id
    inner join VW_NetProfitmargin as N
   on cm.company_id = N.company_id
   inner join  VW_AssetTurnOverRatio as A
   on cm.company_id = A.company_id
   inner join companies as c
   on cm.company_id = c.company_id
   )
    select *,
         case
              when RevenueRank <=2 then 'Excellent'
              when RevenueRank<=5 then 'Good'
              Else 'Needs Review'
         End as FinancialHealth
         from CTE_FinalReport

       




       
   
       

