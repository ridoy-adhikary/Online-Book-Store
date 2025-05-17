-- --create database--
create database OnlineBookStore;
use OnlineBookStore;

-- create tables
drop table if exists Books;
create table Books(
     Book_ID serial primary key,
     Title varchar(100),
     Author varchar(100),
     Genre varchar(50),
     Published_Year int,
     Price numeric (10, 2),
     Stock int
);

drop table if exists customers;
create table Customers(
     Customer_ID serial primary key,
     Name varchar(50),
     Email varchar(50) ,
     Phone varchar(15),
     City varchar(50),
     Country varchar (150)
);

drop table if exists orders;
create table Orders(
     Order_ID serial primary key,
     Customer_ID int references Customers(Customer_ID),
     Book_ID int references Books(Book_ID),
     Order_Date date,
     Quantity int,
     Total_Amount numeric(10,2)
);

select * from Books;
select * from Customers;
select * from Orders;


-- Queation- 1) Retrieve all books in the "fiction" genre:
select * from books 
where genre='Fiction';

-- Question-2) Find Books published after the year 1950:
select * from books 
where published_year>1950;

-- Question-3) List all customers from the canada:
select * from customers 
where country='Canada';

-- Question-4) Show orders placed in November 2023: 
select * from Orders
where order_date between '2023-11-01' and '2023-11-30';

-- Question-5) Retrieve the total stock of books available :
select sum(stock) as Total_Stock
from Books;

-- Question-6) Find the details of the most expensive book :

select * from books b 
order by Price desc 
limit 1;

-- Question-7) Show all customers who ordered more than 1 quantity of a book :
select * from orders o 
where quantity>1;

-- Question-8) Retrieve all orders where the total amount exceeds $20 :
select * from orders o 
where total_amount>20;

-- Question-9) List all genres available in the Books table :
select distinct genre from Books;

-- Question-10) Find the book with the lowest stock :
select * from books b 
order by stock
limit 1;

-- Question-11) Calculate the total revenue generated from all orders:
select sum(total_amount) as revenue 
from Orders;


-- Advanced Queries
-- Question-1) Retrieve the total number of books sold for each genre :
select * from Orders;

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.book_id = b.Book_ID
GROUP BY b.Genre
LIMIT 0, 200;

-- Question-2) Find the average price of books in the "Fantasy" genre: 
select avg(price) as Average_Price
from books b 
where Genre='Fantasy';
-- Question-3) List customers who have placed at least 2 orders :
select o.customer_id, c.name, count(o.Order_id) as  ORDER_COUNT
from orders o
join customers c on o.customer_id=c.customer_id
group by o.customer_id, c.name
having count(Order_id)>=2;

-- Question-4) Find the most frequently ordered book:
select o.Book_id, b.Title, count(o.order_id) as ORDER_COUNT
from orders o 
join books b on o.book_id= b.book_id
group by o.book_id, b.title
order by ORDER_COUNT desc
limit 1;

-- Question-5) Show the top 3 most expensive books of 'Fantasy' Genre: 
select * from books b 
where genre ='Fantasy'
order by price desc
limit 3;
-- Question-6) Retrieve the total quantity of books sold by each author :
select b.author, sum(o.quantity) as Total_Books_Sold
from Orders o
join books b on o.book_id=b.book_id
group by b.Author;

-- Question-7) List the cities where customers who spent over $30 are located: 
select distinct c.city, total_amount
from Orders o
join Customers c on o.customer_id=c.Customer_ID
where o.total_amount>30;

-- Question-8) Find the customer who spent the most on orders :
select c.customer_id, c.name, sum(o.total_amount) as Total_Spent
from Orders o
join Customers c on o.customer_id=c.Customer_ID 
group by c.customer_id, c.Name
order by Total_Spent desc
limit 1;

-- Question-9) Calculate the stock remaining after fulfilling all orders:
select b.book_id, b.title, b.stock, coalesce(sum(quantity),0) as Order_quantity,
       b.stock - coalesce(sum(quantity),0) as Remaining_Quantity
from books b
left join orders o on b.book_id=o.Book_ID
group by b.book_id;




























