--WORKSHOP  ON  SQL Data Definition Language and Data Modification using DML 



--No(1)

create table  MemberCategories 
(
 MemberCategory nvarchar(2) not null,
 MemberCatDescription nvarchar(200) not null,
 PRIMARY KEY (MemberCategory)
)

select * from MemberCategories

--No(2)

insert into MemberCategories (MemberCategory,MemberCatDescription) 
values ('A','Class A Members')
insert into MemberCategories (MemberCategory,MemberCatDescription) 
values ('B','Class B Members')
insert into MemberCategories (MemberCategory,MemberCatDescription) 
values ('C','Class C Members')

--No(3)
--drop table GoodCustomers
create table GoodCustomers
(
 CustomerName nvarchar(50) not null,
 Address nvarchar(65),
 PhoneNumber nvarchar(9) not null,
 MemberCategory nvarchar(2),
 PRIMARY KEY (CustomerName,PhoneNumber),
 FOREIGN KEY (MemberCategory) 
 REFERENCES  MemberCategories(MemberCategory)
)

--NO(4)
insert into GoodCustomers(CustomerName,Address,PhoneNumber,MemberCategory)
select CustomerName, null as Address, PhoneNumber,MemberCategory
from Customers 
where MemberCategory= 'A' or MemberCategory='B'

--No(5)
insert into GoodCustomers(CustomerName,Address,PhoneNumber,MemberCategory)
values ('Tracy Tan',null,'736572','B')

--No(6)
insert into GoodCustomers 
values('Grace Leong','15 Bukit Purmei Road, Singapore 0904','278865','A')

--No(7)
insert into GoodCustomers 
values('Lynn Lim','15 Bukit Purmei Road, Singapore 0904','278865','P')

--this is give the following result.
--Msg 547, Level 16, State 0, Line 55
--The INSERT statement conflicted with the FOREIGN KEY constraint "FK__GoodCusto__Membe__6E01572D". The conflict occurred in database "Dafesty", table "dbo.MemberCategories", column 'MemberCategory'.
--The statement has been terminated.

select * from GoodCustomers
select * from MemberCategories

--No(8)
update GoodCustomers
set Address= '22 Bukit Purmei Road, Singapore 0904'
where CustomerName='Grace Leong'

--No(9)
update GoodCustomers
set MemberCategory ='B'
where CustomerName = 
( 
select CustomerName
from Customers
where CustomerID='5108'
)

--No(10)
delete
from GoodCustomers
where CustomerName='Grace Leong'

--No(11)
delete
from GoodCustomers
where MemberCategory='B'

--No(12)
alter table GoodCustomers
add FaxNumber nvarchar(25)

select * from GoodCustomers

--No(13)
alter table GoodCustomers
alter column Address nvarchar(80)

--No(14)
alter table GoodCustomers
add ICNumber nvarchar(10)

select * from GoodCustomers

--No(15)
create unique index ICIndex
on GoodCustomers(ICNumber)

--That problem(15) give the following error.
--Msg 1505, Level 16, State 1, Line 106
--The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object name 'dbo.GoodCustomers' and the index name 'ICIndex'. The duplicate key value is (<NULL>).
--The statement has been terminated.

--No(16)
create index FaxNumIndex
on GoodCustomers(FaxNumber)

--No(17)
drop index FaxNumIndex on GoodCustomers

--No(18)
alter table GoodCustomers
drop column FaxNumber

select * from GoodCustomers

--No(19)
delete
from GoodCustomers

--No(20)
drop table GoodCustomers




