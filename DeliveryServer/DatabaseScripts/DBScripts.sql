Use master
Create Database DeliveryDB
Go

Use DeliveryDB
Go


CREATE TABLE "Dishes"(
    "DishID" INT NOT NULL,
    "IDMenu" INT NOT NULL,
    "contents" NVARCHAR(255) NOT NULL,
    "DishRating" FLOAT NOT NULL
);
ALTER TABLE
    "Dishes" ADD CONSTRAINT "dishes_dishid_primary" PRIMARY KEY("DishID");
CREATE TABLE "Menus"(
    "IDMenu" INT NOT NULL,
    "dishes(idk if needed here)" NVARCHAR(255) NOT NULL,
    "RestaurantID" INT NOT NULL
);
ALTER TABLE
    "Menus" ADD CONSTRAINT "menus_idmenu_primary" PRIMARY KEY("IDMenu");
CREATE TABLE "restaurants"(
    "idRestaurant" INT NOT NULL,
    "Name" NVARCHAR(255) NOT NULL,
    "aboutRestaurant" NVARCHAR(255) NOT NULL,
    "Location" NVARCHAR(255) NOT NULL,
    "phoneNumber" NCHAR(255) NOT NULL,
    "Rating" FLOAT NOT NULL
);
ALTER TABLE
    "restaurants" ADD CONSTRAINT "restaurants_idrestaurant_primary" PRIMARY KEY("idRestaurant");
CREATE TABLE "Orders"(
    "OrderID" INT NOT NULL,
    "UserID" INT NOT NULL,
    "OrderDate" DATE NOT NULL
);
ALTER TABLE
    "Orders" ADD CONSTRAINT "orders_orderid_primary" PRIMARY KEY("OrderID");
CREATE TABLE "DishesOrders"(
    "IDOrderDish" INT NOT NULL,
    "DishID" INT NOT NULL,
    "OrderID" INT NOT NULL
);
ALTER TABLE
    "DishesOrders" ADD CONSTRAINT "dishesorders_idorderdish_primary" PRIMARY KEY("IDOrderDish");
CREATE TABLE "Users"(
    "UserID" INT NOT NULL,
    "Email" NVARCHAR(255) NOT NULL,
    "UserName" NVARCHAR(255) NOT NULL,
    "Password" NVARCHAR(255) NOT NULL,
    "TypeID" INT NOT NULL,
    "idRestaurant" INT NULL
);
ALTER TABLE
    "Users" ADD CONSTRAINT "users_userid_primary" PRIMARY KEY("UserID");
CREATE TABLE "UserType"(
    "TypeID" INT NOT NULL,
    "TypeName" NVARCHAR(255) NOT NULL
);
ALTER TABLE
    "UserType" ADD CONSTRAINT "usertype_typeid_primary" PRIMARY KEY("TypeID");
ALTER TABLE
    "DishesOrders" ADD CONSTRAINT "dishesorders_dishid_foreign" FOREIGN KEY("DishID") REFERENCES "Dishes"("DishID");
ALTER TABLE
    "Menus" ADD CONSTRAINT "menus_restaurantid_foreign" FOREIGN KEY("RestaurantID") REFERENCES "restaurants"("idRestaurant");
ALTER TABLE
    "Dishes" ADD CONSTRAINT "dishes_idmenu_foreign" FOREIGN KEY("IDMenu") REFERENCES "Menus"("IDMenu");
ALTER TABLE
    "DishesOrders" ADD CONSTRAINT "dishesorders_orderid_foreign" FOREIGN KEY("OrderID") REFERENCES "Orders"("OrderID");
ALTER TABLE
    "Orders" ADD CONSTRAINT "orders_userid_foreign" FOREIGN KEY("UserID") REFERENCES "Users"("UserID");
ALTER TABLE
    "Users" ADD CONSTRAINT "users_idrestaurant_foreign" FOREIGN KEY("idRestaurant") REFERENCES "restaurants"("idRestaurant");
ALTER TABLE
    "Users" ADD CONSTRAINT "users_typeid_foreign" FOREIGN KEY("TypeID") REFERENCES "UserType"("TypeID");
