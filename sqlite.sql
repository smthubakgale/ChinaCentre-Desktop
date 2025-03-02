CREATE TABLE _File (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  table_name TEXT,
  table_idx INTEGER,
  _file TEXT
);

CREATE TABLE File_Copy (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  table_name TEXT,
  table_idx INTEGER,
  file_idx INTEGER,
  FOREIGN KEY (file_idx) REFERENCES _File(idx)
);

CREATE TABLE Products (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  item_no TEXT,
  price REAL,
  barcode TEXT,
  quantity INTEGER,
  department_no INTEGER,
  category_no INTEGER,
  brand_no INTEGER,
  availability TEXT CHECK (availability IN ('In-Stock', 'Awaiting-Order', 'Out-of-Stock', 'Discontinued')),
  FOREIGN KEY (department_no) REFERENCES Departments(idx),
  FOREIGN KEY (category_no) REFERENCES Categories(idx),
  FOREIGN KEY (brand_no) REFERENCES Brands(idx),
  UNIQUE (name, department_no, category_no, brand_no)
);

CREATE TABLE Departments (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

CREATE TABLE Categories (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  department_no INTEGER,
  FOREIGN KEY (department_no) REFERENCES Departments(idx)
);

CREATE TABLE Discounts (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  _type TEXT CHECK (_type IN ('Basic', 'Special')),
  discount_amount REAL,
  start_date TEXT,
  end_date TEXT,
  _status TEXT CHECK (_status IN ('Private', 'Public'))
);

CREATE TABLE Brands (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

CREATE TABLE Users (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  phone_number TEXT
);

CREATE TABLE Favourites (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER,
  product_no INTEGER,
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx)
);

CREATE TABLE Discount_Items (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  discount_no INTEGER,
  product_no INTEGER,
  FOREIGN KEY (discount_no) REFERENCES Discounts(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx)
);

CREATE TABLE Tips_and_Guides (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  category_no INTEGER,
  tip TEXT,
  FOREIGN KEY (category_no) REFERENCES Categories(idx)
);

CREATE TABLE Product_Ratings (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER,
  rating INTEGER,
  product_no INTEGER,
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx),
  UNIQUE (user_no, product_no)
);

CREATE TABLE Product_Reviews (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER,
  review TEXT,
  product_no INTEGER,
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx),
  UNIQUE (user_no, product_no, review)
);

CREATE TABLE Product_Colors (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

CREATE TABLE Product_Color_Items (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  color TEXT,
  rgb TEXT,
  color_group INTEGER,
  FOREIGN KEY (color_group) REFERENCES Product_Colors(idx)
);

CREATE TABLE Product_Wood_Tone (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

CREATE TABLE Product_Materials (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

CREATE TABLE Product_Material_Items (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  material TEXT,
  material_group INTEGER,
  FOREIGN KEY (material_group) REFERENCES Product_Materials(idx)
);

CREATE TABLE Product_Features (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

CREATE TABLE Product_Feature_Items (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  feature TEXT,
  feature_group INTEGER,
  FOREIGN KEY (feature_group) REFERENCES Product_Features(idx)
);

CREATE TABLE Product_Cart (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER,
  product_no INTEGER,
  quantity INTEGER,
  checkout_status TEXT CHECK (checkout_status IN ('Shopping', 'Paid')) DEFAULT 'Shopping',
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx)
);

CREATE TABLE User_Addresses (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER,
  address TEXT,
  region TEXT,
  apartment TEXT,
  province TEXT CHECK (province IN ('Gauteng')),
  city TEXT CHECK (city IN ('Johannesburg')),
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

CREATE TABLE User_Payments (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER,
  method TEXT CHECK (method IN ('Credit Card', 'Debit Card', 'Bank Transfer')),
  card_number TEXT,
  expiration_month TEXT,
  expiration_year TEXT,
  CCV TEXT,
  account_number TEXT,
  branch_code TEXT,
  reference TEXT,
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

CREATE TABLE Checkout_Cart (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER,
  product_no INTEGER,
  quantity INTEGER,
  checkout_status TEXT CHECK (checkout_status IN ('Shopping', 'Paid')) DEFAULT 'Shopping',
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (product_no) REFERENCES Products(idx)
);

CREATE TABLE Checkout_Addresses (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER,
  address TEXT,
  region TEXT,
  apartment TEXT,
  province TEXT CHECK (province IN ('Gauteng')),
  city TEXT CHECK (city IN ('Johannesburg')),
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

CREATE TABLE Checkout_Payments (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER,
  method TEXT CHECK (method IN ('Credit Card', 'Debit Card', 'Bank Transfer')),
  card_number TEXT,
  expiration_month TEXT,
  expiration_year TEXT,
  CCV TEXT,
  account_number TEXT,
  branch_code TEXT,
  reference TEXT,
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

CREATE TABLE Checkout (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  cart_no INTEGER,
  address_no INTEGER,
  payment_no INTEGER,
  checkout_no INTEGER,
  FOREIGN KEY (cart_no) REFERENCES Checkout_Cart(idx),
  FOREIGN KEY (address_no) REFERENCES Checkout_Addresses(idx),
  FOREIGN KEY (payment_no) REFERENCES Checkout_Payments(idx)
);

CREATE TABLE Affiliate_Applications (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  website TEXT NOT NULL,
  phone_number TEXT
);

CREATE TABLE Job_Applications (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  deadline TEXT
);

CREATE TABLE Forum_Thread (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER,
  title TEXT,
  message TEXT,
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

CREATE TABLE Forum_Chat (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  thread_no INTEGER,
  parent_idx INTEGER NULL,
  message TEXT,
  FOREIGN KEY (thread_no) REFERENCES Forum_Thread(idx),
  FOREIGN KEY (parent_idx) REFERENCES Forum_Chat(idx)
);

CREATE TABLE Admins (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER UNIQUE,
  role TEXT CHECK (role IN ('Super Admin', 'Moderator', 'Support Agent')),
  FOREIGN KEY (user_no) REFERENCES Users(idx)
);

CREATE TABLE Support_Chat (
  idx INTEGER PRIMARY KEY AUTOINCREMENT,
  user_no INTEGER,
  admin_no INTEGER,
  message TEXT,
  chat_date TEXT,
  message_status TEXT CHECK (message_status IN ('Sent', 'Seen', 'Delivered', 'Failed')),
  FOREIGN KEY (user_no) REFERENCES Users(idx),
  FOREIGN KEY (admin_no) REFERENCES Admins(idx)
);

