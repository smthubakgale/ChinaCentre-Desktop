CREATE TABLE _File (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  table_name TEXT,
  table_idx INT,
  _file TEXT
);

CREATE TABLE File_Copy (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  table_name TEXT,
  table_idx INT,
  file_idx INT,
  FOREIGN KEY (file_idx) REFERENCES _File(idx)
);

CREATE TABLE Products (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  name TEXT,
  item_no TEXT,
  price DECIMAL(10, 2),
  barcode TEXT,
  quantity INT,
  department_no INT,
  category_no INT,
  brand_no INT,
  availability TEXT CHECK (availability IN ('In-Stock', 'Awaiting-Order', 'Out-of-Stock', 'Discontinued')),
  FOREIGN KEY (department_no) REFERENCES Departments(idx),
  FOREIGN KEY (category_no) REFERENCES Categories(idx),
  FOREIGN KEY (brand_no) REFERENCES Brands(idx),
  UNIQUE (name, department_no, category_no, brand_no)
);

CREATE TABLE Departments (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  name TEXT
);

CREATE TABLE Categories (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  name TEXT,
  department_no INT,
  FOREIGN KEY (department_no) REFERENCES Departments(idx)
);

CREATE TABLE Discounts (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  name TEXT,
  _type TEXT CHECK (_type IN ('Basic', 'Special')),
  discount_amount DECIMAL(10, 2),
  start_date TEXT,
  end_date TEXT,
  _status TEXT CHECK (_status IN ('Private', 'Public'))
);

CREATE TABLE Brands (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  name TEXT
);

CREATE TABLE Users (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  phone_number TEXT
);

CREATE TABLE Favourites (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT,
  product_no INT,
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx)
);

CREATE TABLE Discount_Items (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  discount_no INT,
  product_no INT,
  FOREIGN KEY (discount_no) REFERENCES Discounts(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx)
);

CREATE TABLE Tips_and_Guides (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  category_no INT,
  tip TEXT,
  FOREIGN KEY (category_no) REFERENCES Categories(idx)
);

CREATE TABLE Product_Ratings (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT,
  rating INT,
  product_no INT,
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx),
  UNIQUE (user_no, product_no)
);

CREATE TABLE Product_Reviews (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT,
  review TEXT,
  product_no INT,
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx),
  UNIQUE (user_no, product_no, review)
);

CREATE TABLE Product_Colors (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  name TEXT
);

CREATE TABLE Product_Color_Items (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  color TEXT,
  rgb TEXT,
  color_group INT,
  FOREIGN KEY (color_group) REFERENCES Product_Colors(idx)
);

CREATE TABLE Product_Wood_Tone (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  name TEXT
);

CREATE TABLE Product_Materials (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  name TEXT
);

CREATE TABLE Product_Material_Items (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  material TEXT,
  material_group INT,
  FOREIGN KEY (material_group) REFERENCES Product_Materials(idx)
);

CREATE TABLE Product_Features (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  name TEXT
);

CREATE TABLE Product_Feature_Items (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  feature TEXT,
  feature_group INT,
  FOREIGN KEY (feature_group) REFERENCES Product_Features(idx)
);

CREATE TABLE Product_Cart (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT,
  product_no INT,
  quantity INT,
  checkout_status TEXT CHECK (checkout_status IN ('Shopping', 'Paid')) DEFAULT 'Shopping',
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx)
);

CREATE TABLE User_Addresses (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT,
  address TEXT,
  region TEXT,
  apartment TEXT,
  province TEXT CHECK (province IN ('Gauteng')),
  city TEXT CHECK (city IN ('Johannesburg')),
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

CREATE TABLE User_Payments (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT,
  method TEXT CHECK (method IN ('Credit Card', 'Debit Card', 'Bank Transfer')),
  card_number TEXT,
  expiration_month TEXT,
  expiration_year TEXT,
  CCV TEXT,
  account_number TEXT,
  branch_code TEXT ,
  reference TEXT ,
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

-- 


CREATE TABLE Checkout_Cart (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT,
  product_no INT,
  quantity INT,
  checkout_status TEXT CHECK (checkout_status IN ('Shopping', 'Paid')) DEFAULT 'Shopping',
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx)
);

CREATE TABLE Checkout_Addresses (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT,
  address TEXT,
  region TEXT,
  apartment TEXT,
  province TEXT CHECK (province IN ('Gauteng')),
  city TEXT CHECK (city IN ('Johannesburg')),
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

CREATE TABLE Checkout_Payments (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT,
  method TEXT CHECK (method IN ('Credit Card', 'Debit Card', 'Bank Transfer')),
  card_number TEXT,
  expiration_month TEXT,
  expiration_year TEXT,
  CCV TEXT,
  account_number TEXT,
  branch_code TEXT ,
  reference TEXT ,
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

--

CREATE TABLE Checkout (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  cart_no INT,
  address_no INT,
  payment_no INT,
  checkout_no INT,
  FOREIGN KEY (cart_no) REFERENCES Checkout_Cart(idx),
  FOREIGN KEY (address_no) REFERENCES Checkout_Addresses(idx),
  FOREIGN KEY (payment_no) REFERENCES Checkout_Payments(idx)
);

-- Affiliate Program

CREATE TABLE Affiliate_Applications (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  website TEXT NOT NULL,
  phone_number TEXT
);

-- Careers 
CREATE TABLE Job_Applications (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  deadline TEXT
);

-- Forum 
CREATE TABLE Forum_Thread (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT,
  title TEXT ,
  message TEXT ,
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

CREATE TABLE Forum_Chat (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  thread_no INT,
  parent_idx INT NULL,
  message TEXT,
  FOREIGN KEY (thread_no) REFERENCES Forum_Thread(idx),
  FOREIGN KEY (parent_idx) REFERENCES Forum_Chat(idx)
);

-- Chat Application 

CREATE TABLE Admins (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT UNIQUE,
  role TEXT CHECK (role IN ('Super Admin', 'Moderator', 'Support Agent')),
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

CREATE TABLE Support_Chat (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT,
  admin_no INT,
  message TEXT,
  chat_date DATETIME,
  message_status TEXT CHECK (message_status IN ('Sent', 'Seen', 'Delivered', 'Failed')),
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (admin_no) REFERENCES Admins(idx)
);

--
  
