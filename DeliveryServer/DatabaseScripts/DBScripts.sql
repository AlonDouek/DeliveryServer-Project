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
    "StatusID" INT Identity(1,1) NOT NULL,
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
    "Description" NVARCHAR(255) NOT NULL,
    "ResAddress" NVARCHAR(255) NOT NULL,
    "PhoneNumber" NVARCHAR(255) NOT NULL,
    "Image" NVARCHAR(255) NOT NULL DEFAULT 'default_Rp.jpg',
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
    "MenuID" INT Identity(1,1) NOT NULL,
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
    "Description" NVARCHAR(255) NOT NULL,
    "Price" DECIMAL(8, 2) NOT NULL,
    "Image" NVARCHAR(255) NOT NULL DEFAULT 'default_Ip.jpg'
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

   INSERT INTO [Restaurant] ([Name],[PhoneNumber],[Description],[ResAddress],[OpeningHours],[ClosingHours])
   VALUES ('PPizzaPasta','096621548','Too lazy to write anything series so I will just write some staff and leave soon, maybe? probably? i think so? ,anyhow this place has pizza and pasta like the name suggest, ......,not sure what you expected thats all (includes variations)','{Change when necessary}','08:30:00.0000000' , '23:00:00.0000000');
 

INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,1,'Focaccia','tasty Focaccia bread with olive oil,salt and herbs on top very tasty',12.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,2,'Cool Italian salad','tasty salad with tomato, sprouts, radish, lettuce ,olive oil various herbs and spices',18.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,3,'Cool Pasta cheese','tasty pasta with various cheeses and spices',35.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,3,'Cool Pasta for rich people','tasty pasta with various expensive cheeses and spices',65.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,3,'Cool Pasta cheese and veggie','tasty pasta with various cheeses , vegetables,and spices',39.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,3,'Cool Pasta tomato','tasty pasta with tomato sauce and herbs',34.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,3,'Pizza Margarita','regular pizza with basil included',32.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,3,'Pizza Expensive Margarita','regular pizza with basil included but really expensive',932.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,3,'Pepperoni pizza','regular pizza with Pepperoni on top',34.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,4,'Water','regular water',4.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,4,'Sparkling Water','regular Sparkling water',4.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,4,'Juice','Grape Juice, Orange Juice, Apple Juice,',7.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,4,'Sparkling Juice','Sparkling Grape Juice, Orange Juice, Apple Juice,',7.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,4,'Rich People wine','wine that people who are usually rich buy',24.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,4,'Coffee','regular coffee',12.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,5,'Choco Chocolate cake','chocolate cake with more chocolate on top cant be bothered to write more',23.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(1,5,'Expensive Chocolate cake','chocolate cake with more chocolate on top buta little too expensive',923.00)

     INSERT INTO [Restaurant] ([Name],[PhoneNumber],[Description],[ResAddress],[OpeningHours],[ClosingHours])
   VALUES ('burgerb','096765848','Too lazy to write anything series so I will just write some staff and leave soon, maybe? probably? i think so? ,anyhow this place has pizza and pasta like the name suggest, ......,not sure what you expected thats all (includes variations)','{Change when necessary}','08:30:00.0000000' , '23:00:00.0000000');
 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,1,'chicken wings','yummy chicken wings with a spicy BBQ sauce',22.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,2,'','tasty salad with tomato, sprouts, radish, lettuce ,olive oil various herbs and spices',18.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,3,'','tasty pasta with various cheeses and spices',35.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,3,'','tasty pasta with various expensive cheeses and spices',65.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,3,'','tasty pasta with various cheeses , vegetables,and spices',39.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,3,'','tasty pasta with tomato sauce and herbs',34.00) 
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,3,'','regular pizza with basil included',32.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,3,'','regular pizza with basil included but really expensive',932.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,3,'','regular pizza with Pepperoni on top',34.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,4,'Water','regular water',4.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,4,'Sparkling Water','regular Sparkling water',4.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,4,'Juice','Grape Juice, Orange Juice, Apple Juice,',7.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,4,'Sparkling Juice','Sparkling Grape Juice, Orange Juice, Apple Juice,',7.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,4,'Rich People wine','wine that people who are usually rich buy',24.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,4,'soda','coke cola, fanta, sprite',12.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,5,'Choco Chocolate cake','chocolate cake with more chocolate on top cant be bothered to write more',23.00)
INSERT INTO [MenuItem]([MenuID],[CategoryID],[Name],[Description],Price)
	VALUES(2,5,'Expensive Chocolate cake','chocolate cake with more chocolate on top but a little too expensive',923.00)
