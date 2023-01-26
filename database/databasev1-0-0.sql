CREATE DATABASE nft_lujan;
USE nft_lujan;

DROP TABLE IF EXISTS `References`;
CREATE TABLE `References` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `ReferenceTypes`;
CREATE TABLE `ReferenceTypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `referenceId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `secure` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ReferenceTypes_References` (`referenceId`),
  CONSTRAINT `FK_ReferenceTypes_References` FOREIGN KEY (`referenceId`) REFERENCES `References` (`id`)
);

DROP TABLE IF EXISTS `Roles`;
CREATE TABLE `Roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `People`;
CREATE TABLE `People` (
  `id` int NOT NULL AUTO_INCREMENT,
  `documentTypeId` int NOT NULL,
  `documentNumber` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `lastName` varchar(200) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `cellPhone` varchar(50) DEFAULT NULL,
  `address` varchar(300) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT (utc_timestamp()),
  `allowReceiveCommunications` tinyint DEFAULT NULL,
  `allowPersonalDataStore` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`)
);


DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personId` int NOT NULL,
  `roleId` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT (utc_timestamp()),
  `emailConfirmed` int DEFAULT '0',
  `active` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_Person_users` (`personId`),
  KEY `FK_Roles_users` (`roleId`),
  CONSTRAINT `FK_Person_users` FOREIGN KEY (`personId`) REFERENCES `People` (`id`),
  CONSTRAINT `FK_Roles_users` FOREIGN KEY (`roleId`) REFERENCES `Roles` (`id`)
);

DROP TABLE IF EXISTS `BussinesPartners`;
CREATE TABLE `BussinesPartners` (
    `id` int NOT NULL AUTO_INCREMENT,
    `managerId` int NOT NULL,
    `name` varchar(200) NOT NULL,
    `description` varchar(255) DEFAULT NULL,
    `lat` varchar(100),
    `lng` varchar(100),
    `locationAddress` varchar(255),
    `created_at` datetime NOT NULL DEFAULT (utc_timestamp()),
    `active` tinyint DEFAULT '1',
    PRIMARY KEY(`id`),
    KEY `FK_BussinesPartners_User` (`managerId`),
    CONSTRAINT `FK_BussinesPartners_User` FOREIGN KEY (`managerId`) REFERENCES `Users` (`id`)
);


DROP TABLE IF EXISTS `UserServiceTransactions`;
CREATE TABLE `UserServiceTransactions` (
    `id` int NOT NULL AUTO_INCREMENT,
    `partnerId` int NOT NULL,
    `userId` int NOT NULL,
    `status` varchar(255) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT (utc_timestamp()),
    PRIMARY KEY(`id`),
    KEY `FK_UserServiceTransactions_BussinesPartner` (`partnerId`),
    KEY `FK_UserServiceTransactions_User` (`userId`),
    CONSTRAINT `FK_UserServiceTransactions_BussinesPartner` FOREIGN KEY (`partnerId`) REFERENCES `BussinesPartners` (`id`),
    CONSTRAINT `FK_UserServiceTransactions_User` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`)
);





