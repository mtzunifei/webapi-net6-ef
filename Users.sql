CREATE DATABASE WebApiDB;

CREATE TABLE Users (
    id int NOT NULL IDENTITY(1,1),
    Title varchar(255),
    FirstName varchar(255),
	LastName varchar(255),
	Email varchar(255),
	Role int,
	PasswordHash varchar(255)
    PRIMARY KEY (id)
);

