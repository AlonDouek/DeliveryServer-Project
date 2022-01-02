Use master
Create Database DeliveryDB
Go

Use DeliveryDB
Go

CREATE TABLE "User"(
    "UserID" INT NOT NULL,
    "Email" NVARCHAR(255) NOT NULL,
    "Username" NVARCHAR(255) NOT NULL,
    "Password" NVARCHAR(255) NOT NULL,
    "Address" NVARCHAR(255) NOT NULL,
    "PhoneNumber" INT NOT NULL,
    "CreditCard" NVARCHAR(255) NOT NULL
);
CREATE INDEX "user_userid_index" ON
    "User"("UserID");
ALTER TABLE
    "User" ADD CONSTRAINT "user_userid_primary" PRIMARY KEY("UserID");
CREATE UNIQUE INDEX "user_email_unique" ON
    "User"("Email");
CREATE UNIQUE INDEX "user_phonenumber_unique" ON
    "User"("PhoneNumber");
CREATE TABLE "OrderStatus"(
    "StatusID" INT NOT NULL,
    "Name" NVARCHAR(255) NOT NULL
);
CREATE INDEX "orderstatus_statusid_index" ON
    "OrderStatus"("StatusID");
ALTER TABLE
    "OrderStatus" ADD CONSTRAINT "orderstatus_statusid_primary" PRIMARY KEY("StatusID");
CREATE TABLE "Order"(
    "OrderID" INT NOT NULL,
    "UserID" INT NOT NULL,
    "StatusID" INT NOT NULL,
    "Price" DECIMAL(8, 2) NOT NULL,
    "Note" NVARCHAR(255) NOT NULL
);
CREATE INDEX "order_orderid_index" ON
    "Order"("OrderID");
CREATE INDEX "order_userid_index" ON
    "Order"("UserID");
CREATE INDEX "order_statusid_index" ON
    "Order"("StatusID");
ALTER TABLE
    "Order" ADD CONSTRAINT "order_orderid_primary" PRIMARY KEY("OrderID");
CREATE TABLE "OrderItem"(
    "ItemID" INT NOT NULL,
    "OrderID" INT NOT NULL,
    "MenuItemID" INT NOT NULL,
    "Amount" INT NOT NULL
);
CREATE INDEX "orderitem_itemid_index" ON
    "OrderItem"("ItemID");
CREATE INDEX "orderitem_orderid_index" ON
    "OrderItem"("OrderID");
CREATE INDEX "orderitem_menuitemid_index" ON
    "OrderItem"("MenuItemID");
ALTER TABLE
    "OrderItem" ADD CONSTRAINT "orderitem_itemid_primary" PRIMARY KEY("ItemID");
CREATE TABLE "Restaurant"(
    "RestaurantID" INT NOT NULL,
    "MenuID" INT NOT NULL,
    "Name" NVARCHAR(255) NOT NULL,
    "Description" INT NOT NULL,
    "OpeningHours" TIME NOT NULL,
    "ClosingHours" TIME NOT NULL
);
CREATE INDEX "restaurant_restaurantid_index" ON
    "Restaurant"("RestaurantID");
CREATE INDEX "restaurant_menuid_index" ON
    "Restaurant"("MenuID");
ALTER TABLE
    "Restaurant" ADD CONSTRAINT "restaurant_restaurantid_primary" PRIMARY KEY("RestaurantID");
CREATE UNIQUE INDEX "restaurant_name_unique" ON
    "Restaurant"("Name");
CREATE TABLE "Menu"(
    "MenuID" INT NOT NULL,
    "RestaurantID" INT NOT NULL,
    "Name" NVARCHAR(255) NULL
);
ALTER TABLE
    "Menu" ADD CONSTRAINT "menu_menuid_primary" PRIMARY KEY("MenuID");
CREATE TABLE "MenuCatagory"(
    "CatagoryID" INT NOT NULL,
    "MenuID" INT NOT NULL,
    "Name" INT NOT NULL
);
CREATE INDEX "menucatagory_catagoryid_index" ON
    "MenuCatagory"("CatagoryID");
CREATE INDEX "menucatagory_menuid_index" ON
    "MenuCatagory"("MenuID");
ALTER TABLE
    "MenuCatagory" ADD CONSTRAINT "menucatagory_catagoryid_primary" PRIMARY KEY("CatagoryID");
CREATE TABLE "MenuItem"(
    "MenuItemID" INT NOT NULL,
    "CatagoryID" INT NOT NULL,
    "Name" NVARCHAR(255) NOT NULL,
    "Description" INT NOT NULL,
    "Price" DECIMAL(8, 2) NOT NULL,
    "Image" NVARCHAR(255) NULL
);
CREATE INDEX "menuitem_menuitemid_index" ON
    "MenuItem"("MenuItemID");
CREATE INDEX "menuitem_catagoryid_index" ON
    "MenuItem"("CatagoryID");
ALTER TABLE
    "MenuItem" ADD CONSTRAINT "menuitem_menuitemid_primary" PRIMARY KEY("MenuItemID");
ALTER TABLE
    "Order" ADD CONSTRAINT "order_statusid_foreign" FOREIGN KEY("StatusID") REFERENCES "OrderStatus"("StatusID");
ALTER TABLE
    "Order" ADD CONSTRAINT "order_userid_foreign" FOREIGN KEY("UserID") REFERENCES "User"("UserID");
ALTER TABLE
    "Restaurant" ADD CONSTRAINT "restaurant_menuid_foreign" FOREIGN KEY("MenuID") REFERENCES "Menu"("MenuID");
ALTER TABLE
    "Menu" ADD CONSTRAINT "menu_restaurantid_foreign" FOREIGN KEY("RestaurantID") REFERENCES "Restaurant"("RestaurantID");
ALTER TABLE
    "MenuCatagory" ADD CONSTRAINT "menucatagory_menuid_foreign" FOREIGN KEY("MenuID") REFERENCES "Menu"("MenuID");
ALTER TABLE
    "OrderItem" ADD CONSTRAINT "orderitem_menuitemid_foreign" FOREIGN KEY("MenuItemID") REFERENCES "MenuItem"("MenuItemID");
ALTER TABLE
    "MenuItem" ADD CONSTRAINT "menuitem_catagoryid_foreign" FOREIGN KEY("CatagoryID") REFERENCES "MenuCatagory"("CatagoryID");
    
INSERT INTO OrderStatus (Name)
VALUES ('Ordered'), ('Preparing'), ('Delivering'), ('Finished')
    
    
