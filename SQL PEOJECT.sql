-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books(
Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_year INT,
Price NUMERIC(10,2),
Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers(
Customer_ID SERIAl PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE Orders(
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(10,2)
);

SELECT*FROM Books;
SELECT*FROM Customers;
SELECT*FROM Orders;

--Import Data into Books Table
COPY Books(Book_ID,	Title,	Author,	Genre,	Published_Year,	Price,	Stock)
FROM 'C:\Program Files\PostgreSQL\17\Books.csv'
CSV HEADER;

--Import Data into Customers Table
COPY Customers(Customer_ID,	Name,	Email,	Phone,	City,	Country)
FROM 'C:\Program Files\PostgreSQL\17\Customers.csv'
CSV HEADER;

--Import Data into Orders Table
COPY Orders(Order_ID,	Customer_ID,	Book_ID,	Order_Date,	Quantity,	Total_Amount)
FROM 'C:\Program Files\PostgreSQL\17\Orders.csv'
CSV HEADER;


--1) Retrieve all books in "Fiction" genre:
SELECT*FROM Books
WHERE genre = 'Fiction';

--2) Find books published after the year 1950:
SELECT*FROM Books
WHERE published_year>1950;

--3) List all the customers from Canada:
SELECT*FROM Customers
WHERE country = 'Canada';

--4) Show orders placed in Novermber 2023:
SELECT*FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--5) Retreive the total stock of books available:
SELECT sum(stock) AS Total_stock
FROM Books;


--6) Find the details of the most expensive book:
SELECT * FROM Books ORDER BY price DESC LIMIT 1;

--7) Show all customers who ordered more thean 1 quantity of a book:
SELECT * FROM Orders
WHERE quantity >1;

--8) Retreive all orders where the total amount exceeds $20:
SELECT*FROM Orders
WHERE total_amount >20;

--9) List all genre available in the Books table:
SELECT DISTINCT genre FROM Books;

--10) Find the book with the lowest stock:
SELECT*FROM Books ORDER BY stock LIMIT 1;

--11) Calculate the total revenue generated from all orders
SELECT sum(total_amount) AS revenue
FROM Orders;




--ADVANCE QUERIES:



--1) Retreive the total number of books sold for each genre:
SELECT b.genre, SUM(o.Quantity) AS total_books_sold 
FROM Orders o 
JOIN Books b ON O.book_id = b.book_id
GROUP BY b.genre;

--2) Find the average price of books in the "fanatasy" genre:
SELECT AVG(price) AS Avg_price
FROM Books
WHERE genre = 'Fantasy';

--3) List customers who have placed atelast 2 orders:
SELECT o.customer_id,c.name,COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY O.customer_id, c.name
HAVING COUNT(Order_id)>=2;

--4) Find the most frequently ordered book:
SELECT o.book_id,b.title, COUNT(o.order_id) AS order_count
FROM Orders o
JOIN
Books b
on b.book_id = o.book_id
GROUP BY o.book_id,b.title
ORDER BY(order_count) DESC LIMIT 1 ;

--5) Show the top 3 most expensive books of 'Fantasy' Genre:
SELECT*FROM Books
WHERE genre = 'Fantasy'
ORDER BY(price) DESC LIMIT 3;

--6) Retreive the total quantity of books sold by each author:
SELECT b.author, SUM(o.quantity) AS total_books_sold
FROM Orders o
JOIN 
Books b 
ON b.book_id = o.book_id
GROUP BY b.author;

--7) List the cities whre customers who spent over $30 are located:
SELECT DISTINCT c.city,total_amount
FROM Orders o
JOIN
Customers c
ON c.customer_id = o.customer_id
WHERE 
o.total_amount>30;

--8) Find the customer who spent the most on orders:
SELECT c.customer_id,c.name,SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN 
Customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_id,c.name
ORDER BY (total_spent) DESC LIMIT 1;

--9) Calculate the stock remaining after fulfuling all orders:
SELECT b.title,b.book_id,b.stock,COALESCE(SUM(o.quantity),0) AS Order_quantity,
    b.stock- COALESCE(SUM(o.quantity),0)AS Remaining_quantity
FROM Books b
LEFT JOIN orders o 
ON b.book_id = o.book_id
Group By b.book_id ORDER BY b.book_id;




