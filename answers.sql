-- Question 1: Achieving 1NF (First Normal Form)

SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail
JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) n
    ON CHAR_LENGTH(Products)
    -CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1
ORDER BY OrderID, n.n;


-- Question 2: Achieving 2NF (Second Normal Form)

CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

INSERT INTO Customers (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

CREATE TABLE OrderDetailsNew (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)
);

INSERT INTO OrderDetailsNew (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

DROP TABLE OrderDetails;
RENAME TABLE OrderDetailsNew TO OrderDetails;
