
--SQLP Workshop Day 1

--No 1
---a
	select * from Shippers;
---b
	select * from Shippers order by CompanyName;

--No 2
---a
	select FirstName, LastName, Title, BirthDate, City from Employees;
---b
	select distinct Title from Employees;
	

--No 3
	select * from Orders where OrderDate = '1997-05-19'

--No 4
	select * from Customers where City = 'London' OR City ='Madrid'

--No 5
	select CustomerID, CompanyName from Customers where Country ='UK' order by CompanyName

--No 6
	select OrderID , OrderDate from Orders where CustomerID='Hanar'

--No 7
	select (TitleOfCourtesy + ' ' + FirstName +' '+ LastName) As NameOfEmployee from Employees order by LastName

--No 8
	select a.OrderID, a.OrderDate from Orders As a, Customers As b where a.CustomerID = b.CustomerID and b.CompanyName='Maison Dewey'
	select OrderID, OrderDate from Orders where CustomerID IN (Select CustomerID from Customers where CompanyName='Maison Dewey')

--No 9
	select * from Products where ProductName like '%lager%'

--No 10
	select CustomerID, ContactName 
	from Customers 
	where CustomerID not in (Select CustomerID from Orders)

--No 11
	select AVG(UnitPrice)
	from Products

--No 12
	select distinct City 
	from Customers

--No 13
	select count(distinct CustomerID) from Orders

--No 14
	select CompanyName, Phone from Customers where fax is null

--No 15
	select sum(Quantity * UnitPrice) as TotalSale from [Order Details]

--No 16
	select a.OrderID
	from Orders a, Customers b 
	where a.CustomerID = b.CustomerID and (b.CompanyName='Alan Out' or b.CompanyName='Blone Coy' )
	
--No 17
	select o.CustomerID, Count(*)
	from Customers c, Orders o
	where c.CustomerID=o.CustomerID
	group by o.CustomerID

--No 18 
	select c.CompanyName, o.OrderID
	from Customers c, Orders o
	where c.CustomerID='BONAP' and c.CustomerID=o.CustomerID
	group by c.CompanyName, o.OrderID

--No 19(a)
	select count(*) As Num,c.CustomerID,c.CompanyName
	from Customers c, Orders o
	where c.CustomerID=o.CustomerID
	group by c.CustomerID, c.CompanyName
	having count(*)>10 
	order by count(*) desc

--No 19(b)
	select count(*) As Num,c.CustomerID,c.CompanyName
	from Customers c, Orders o
	where c.CustomerID='BONAP' and c.CustomerID= o.CustomerID
	group by c.CustomerID, c.CompanyName

--No 19(c)
	select count(*) As Num,c.CustomerID,c.CompanyName
	from Customers c, Orders o
	where c.CustomerID=o.CustomerID
	group by c.CustomerID, c.CompanyName
	having count(*)> 
	(	select count(*)
	from Customers c, Orders o
	where c.CustomerID='BONAP' and c.CustomerID= o.CustomerID
	group by c.CustomerID, c.CompanyName
	) 

--No 20(a)
	select *
	from Products
	where CategoryID='1' or CategoryID='2'
	order by ProductID,ProductName

--No 20(b)
	select p.ProductID,p.ProductName
	from Products p, Categories ct
	where p.CategoryID=ct.CategoryID and (ct.CategoryName='Beverages' or ct.CategoryName='Condiments')
	group by p.ProductID,p.ProductName

--No 21(a)
	select Count(*)
	from Employees

--No 21(b)
	select Count(*)
	from Employees
	where Country='USA'

--N0 22
	select *
	from Orders o, Shippers s, Employees e
	where o.ShipVia=s.ShipperID and e.EmployeeID= o.EmployeeID and e.Title='Sales Representative' and s.CompanyName='United Package'
	
--No 23
	select (a.FirstName+' '+a.LastName) as [Name of the Employee] , (b.FirstName+' '+b.LastName) as [Manager]
	from Employees a left outer join Employees b
	on a.ReportsTo= b.EmployeeID

--No 24
	select top 5 ProductID, sum(UnitPrice*Quantity*Discount) as [Discounted Price]
	from [Order Details]
	group by ProductID
	order by sum(UnitPrice*Quantity*Discount) desc

	--No24 by yun kwan
	select top 5 od.ProductID, sum(
		od.UnitPrice*od.Quantity*od.Discount) as TotalDiscount
	from [Order Details] od
	group by od.ProductID
	order by TotalDiscount desc
	
	--first we use order by and then remove and use group by because of removing duplication
	--order by od.ProductID

--No 25
	select CompanyName
	from Customers
	where city not in (select city from Suppliers)

--No 26
	select distinct city
	from Customers
	where city in (select city from Suppliers)

--No 27(a)
	select CompanyName as [Business Associates' Names], Address, Phone
	from Customers
	Union
	select CompanyName, Address, Phone
	from Suppliers

--No 27(b)
	select CompanyName as [Business Associates' Names], Address, Phone
	from Customers
	Union
	select CompanyName, Address, Phone
	from Suppliers
	Union
	select CompanyName,Null as Address, Phone
	from Shippers

--No 28
	select (b.FirstName+' '+b.LastName) as [Manager Name], (a.FirstName+' '+a.LastName) as [Employee]
	from Employees a, Employees b
	where a.ReportsTo=b.EmployeeID and a.EmployeeID = (
	select EmployeeID from Orders where OrderID='10248')

--No 29
	select ProductName, ProductID
	from Products
	where UnitPrice > (select Avg(UnitPrice) from Products)

--No 30
	select OrderID
	from [Order Details]
	group by OrderID
	having Sum(UnitPrice*Quantity) >10000

--No 31
	select od.OrderID,c.CustomerID
	from [Order Details] od, Orders o, Customers c
	where od.OrderID=o.OrderID and o.CustomerID=c.CustomerID
	group by od.OrderID, c.CustomerID
	having Sum(UnitPrice*Quantity) >10000

--No 32
	select od.OrderID,c.CustomerID, c.CompanyName
	from [Order Details] od, Orders o, Customers c
	where od.OrderID=o.OrderID and o.CustomerID=c.CustomerID
	group by od.OrderID, c.CustomerID, c.CompanyName
	having Sum(UnitPrice*Quantity) >10000

--No 33
	select o.CustomerID,Count(*) as [Orders Made], sum(od.UnitPrice*od.Quantity) as Amount
	from  Orders o , [Order Details] od
	where od.OrderID=o.OrderID
	group by o.CustomerID

--No 34
	select (sum(od.UnitPrice*od.Quantity)/count( distinct o.CustomerID)) as [Average Amount of Business]
	from  Orders o , [Order Details] od
	where od.OrderID=o.OrderID

--No 35
	select o.CustomerID,c.CompanyName, sum(od.UnitPrice*od.Quantity) as Amount
	from  Orders o , [Order Details] od, Customers c
	where od.OrderID=o.OrderID and c.CustomerID= o.CustomerID
	group by o.CustomerID
	having sum(od.UnitPrice*od.Quantity)>
	(
	select (sum(od.UnitPrice*od.Quantity)/count( distinct o.CustomerID)) as [Average Amount of Business]
	from  Orders o , [Order Details] od
	where od.OrderID=o.OrderID
	)

--No 36
	select o.CustomerID,Count(*) as [Orders Made], sum(od.UnitPrice*od.Quantity) as Amount
	from  Orders o , [Order Details] od
	where od.OrderID=o.OrderID and year(o.OrderDate)=1997
	group by o.CustomerID 
	