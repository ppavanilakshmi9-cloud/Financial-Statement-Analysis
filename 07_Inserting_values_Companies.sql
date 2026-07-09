use financialstatementanalysis
select * from companies

Insert into companies
values(2,'Microsoft','MSFT','Software & Cloud Computing','United States','USD',1975),
(3,'Amazon','AMZN','E-Commerce & Cloud Computing','United States','USD',1994),
(4,'NVIDIA','NVDA','Semiconducters','United States','USD',1993),
(5,'Tesla','TSLA','Electric Vehicles & Clean Energy','United States','USD',2003)

select column_name,data_type from information_schema.columns
where table_name = 'companies';