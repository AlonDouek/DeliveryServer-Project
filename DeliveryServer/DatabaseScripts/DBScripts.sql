Use master
Create Database DeliveryDB
Go

Use DeliveryDB
Go


CREATE TABLE "User"(
    "UserID" INT NOT NULL IDENTITY(1, 1),
    "Email" NVARCHAR(255) NOT NULL,
    "Username" NVARCHAR(255) NOT NULL,
    "Password" NVARCHAR(255) NOT NULL,
    "Address" NVARCHAR(255) NOT NULL,
    "PhoneNumber" NVARCHAR(255) NOT NULL,
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
    "OrderID" INT NOT NULL IDENTITY(1, 1),
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
    "ItemID" INT NOT NULL IDENTITY(1, 1),
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
    "RestaurantID" INT NOT NULL IDENTITY(1, 1),
    "Name" NVARCHAR(255) NOT NULL,
    "Description" INT NOT NULL,
    "OpeningHours" TIME NOT NULL,
    "ClosingHours" TIME NOT NULL
);
CREATE INDEX "restaurant_restaurantid_index" ON
    "Restaurant"("RestaurantID");
ALTER TABLE
    "Restaurant" ADD CONSTRAINT "restaurant_restaurantid_primary" PRIMARY KEY("RestaurantID");
CREATE UNIQUE INDEX "restaurant_name_unique" ON
    "Restaurant"("Name");
CREATE TABLE "Menu"(
    "MenuID" INT NOT NULL,
    "RestaurantID" INT NOT NULL
);
CREATE INDEX "menu_restaurantid_menuid_index" ON
    "Menu"("RestaurantID", "MenuID");
ALTER TABLE
    "Menu" ADD CONSTRAINT "menu_menuid_primary" PRIMARY KEY("MenuID");
CREATE TABLE "MenuItem"(
    "MenuItemID" INT NOT NULL IDENTITY(1, 1),
    "MenuID" INT NOT NULL,
    "CategoryID" INT NOT NULL,
    "Name" NVARCHAR(255) NOT NULL,
    "Description" INT NOT NULL,
    "Price" DECIMAL(8, 2) NOT NULL,
    "Image" NVARCHAR(255) NULL
);
CREATE INDEX "menuitem_menuitemid_index" ON
    "MenuItem"("MenuItemID");
CREATE INDEX "menuitem_menuid_index" ON
    "MenuItem"("MenuID");
ALTER TABLE
    "MenuItem" ADD CONSTRAINT "menuitem_menuitemid_primary" PRIMARY KEY("MenuItemID");
CREATE TABLE "ItemCategory"(
    "CategoryID" INT NOT NULL IDENTITY(1, 1),
    "Name" NVARCHAR(255) NOT NULL
);
CREATE INDEX "itemcategory_categoryid_index" ON
    "ItemCategory"("CategoryID");
ALTER TABLE
    "ItemCategory" ADD CONSTRAINT "itemcategory_categoryid_primary" PRIMARY KEY("CategoryID");
ALTER TABLE
    "Order" ADD CONSTRAINT "order_statusid_foreign" FOREIGN KEY("StatusID") REFERENCES "OrderStatus"("StatusID");
ALTER TABLE
    "Order" ADD CONSTRAINT "order_userid_foreign" FOREIGN KEY("UserID") REFERENCES "User"("UserID");
ALTER TABLE
    "MenuItem" ADD CONSTRAINT "menuitem_menuid_foreign" FOREIGN KEY("MenuID") REFERENCES "Menu"("MenuID");
ALTER TABLE
    "Menu" ADD CONSTRAINT "menu_restaurantid_foreign" FOREIGN KEY("RestaurantID") REFERENCES "Restaurant"("RestaurantID");
ALTER TABLE
    "OrderItem" ADD CONSTRAINT "orderitem_menuitemid_foreign" FOREIGN KEY("MenuItemID") REFERENCES "MenuItem"("MenuItemID");
ALTER TABLE
    "MenuItem" ADD CONSTRAINT "menuitem_categoryid_foreign" FOREIGN KEY("CategoryID") REFERENCES "ItemCategory"("CategoryID");

	INSERT INTO [ItemCategory] ([Name])
   VALUES ('Starters');
   INSERT INTO [ItemCategory] ([Name])
   VALUES ('SideDish');
   INSERT INTO [ItemCategory] ([Name])
   VALUES ('MainMeal');
   INSERT INTO [ItemCategory] ([Name])
   VALUES ('Drinks');
   INSERT INTO [ItemCategory] ([Name])
   VALUES ('Desserts');