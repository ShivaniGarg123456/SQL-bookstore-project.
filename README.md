# 📚 SQL Bookstore Project  

This project demonstrates simple and advanced SQL queries on a **Bookstore Database**.  
It includes database schema, sample data import from CSV files, and queries ranging from basic selection to advanced analytics.  

---

## 📂 Database Schema  

- **Books**  
  - Book_ID (PK)  
  - Title  
  - Author  
  - Genre  
  - Published_Year  
  - Price  
  - Stock  

- **Customers**  
  - Customer_ID (PK)  
  - Name  
  - Email  
  - Phone  
  - City  
  - Country  

- **Orders**  
  - Order_ID (PK)  
  - Customer_ID (FK → Customers.Customer_ID)  
  - Book_ID (FK → Books.Book_ID)  
  - Order_Date  
  - Quantity  
  - Total_Amount  

---

## ⚡ Features  

✅ Create tables with constraints  
✅ Import data from CSV files  
✅ Run **basic queries** (filtering, ordering, aggregation)  
✅ Run **advanced queries** (joins, grouping, analytics)  

---

## 📊 Example Queries  

### 🔹 Basic Queries  
- Retrieve all Fiction books  
- Find books published after 1950  
- List customers from Canada  
- Show orders placed in November 2023  
- Calculate total stock of books available  

### 🔹 Advanced Queries  
- Total number of books sold per genre  
- Average price of Fantasy books  
- Customers who placed at least 2 orders  
- Most frequently ordered book  
- Remaining stock after fulfilling orders  

---

## 🚀 How to Run  

1. Install **PostgreSQL** (or use any SQL-compatible tool).  
2. Clone this repository:  
   ```bash
  https://github.com/ShivaniGarg123456/SQL-bookstore-project.