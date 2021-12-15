-- MySQL Script generated by MySQL Workbench
-- Tue Dec  7 17:20:33 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fastsociety
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `fastsociety` ;

-- -----------------------------------------------------
-- Schema fastsociety
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fastsociety` DEFAULT CHARACTER SET utf8 ;
USE `fastsociety` ;

-- -----------------------------------------------------
-- Table `fastsociety`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastsociety`.`User` ;

CREATE TABLE IF NOT EXISTS `fastsociety`.`User` (
  `id` VARCHAR(50) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `image` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fastsociety`.`Society`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastsociety`.`Society` ;

CREATE TABLE IF NOT EXISTS `fastsociety`.`Society` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(250) NULL,
  `email` VARCHAR(45) NULL,
  `totalFollows` VARCHAR(45) NOT NULL DEFAULT 0,
  `image` VARCHAR(255) NULL,
  `head_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Society_User_idx` (`head_id` ASC) VISIBLE,
  CONSTRAINT `fk_Society_User`
    FOREIGN KEY (`head_id`)
    REFERENCES `fastsociety`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fastsociety`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastsociety`.`Role` ;

CREATE TABLE IF NOT EXISTS `fastsociety`.`Role` (
  `name` VARCHAR(45) NOT NULL,
  `createPost` TINYINT NULL DEFAULT 0,
  `createEvent` TINYINT NULL DEFAULT 0,
  `deletePost` TINYINT NULL DEFAULT 0,
  `deleteEvent` TINYINT NULL DEFAULT 0,
  `manageMembers` TINYINT NULL DEFAULT 0,
  `manageChat` TINYINT NULL DEFAULT 0,
  `Society_id` INT NOT NULL,
  PRIMARY KEY (`name`, `Society_id`),
  INDEX `fk_Role_Society1_idx` (`Society_id` ASC) VISIBLE,
  CONSTRAINT `fk_Role_Society1`
    FOREIGN KEY (`Society_id`)
    REFERENCES `fastsociety`.`Society` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fastsociety`.`Registration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastsociety`.`Registration` ;

CREATE TABLE IF NOT EXISTS `fastsociety`.`Registration` (
  `User_id` VARCHAR(50) NOT NULL,
  `Society_id` INT NOT NULL,
  `Role_name` VARCHAR(45) NULL,
  `joinDate` DATE NULL DEFAULT (CURRENT_DATE),
  PRIMARY KEY (`User_id`, `Society_id`),
  INDEX `fk_Registration_Role1_idx` (`Role_name` ASC) VISIBLE,
  INDEX `fk_Registration_User1_idx` (`User_id` ASC) VISIBLE,
  INDEX `fk_Registration_Society1_idx` (`Society_id` ASC) VISIBLE,
  CONSTRAINT `fk_Registration_Role1`
    FOREIGN KEY (`Role_name`)
    REFERENCES `fastsociety`.`Role` (`name`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registration_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `fastsociety`.`User` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registration_Society1`
    FOREIGN KEY (`Society_id`)
    REFERENCES `fastsociety`.`Society` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fastsociety`.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastsociety`.`Event` ;

CREATE TABLE IF NOT EXISTS `fastsociety`.`Event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `venue` VARCHAR(45) NULL,
  `textContent` VARCHAR(1000) NOT NULL,
  `createdOn` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `startTime` DATETIME NULL,
  `endTime` DATETIME NULL,
  `image` VARCHAR(255) NULL,
  `User_id` VARCHAR(50) NULL,
  `Society_id` INT NULL,
  INDEX `fk_Event_User1_idx` (`User_id` ASC) VISIBLE,
  INDEX `fk_Event_Society1_idx` (`Society_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Event_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `fastsociety`.`User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Society1`
    FOREIGN KEY (`Society_id`)
    REFERENCES `fastsociety`.`Society` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fastsociety`.`Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastsociety`.`Post` ;

CREATE TABLE IF NOT EXISTS `fastsociety`.`Post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `textContent` VARCHAR(300) NULL,
  `createdOn` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `image` VARCHAR(255) NULL,
  `User_id` VARCHAR(50) NOT NULL,
  `Event_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Post_User1_idx` (`User_id` ASC) VISIBLE,
  INDEX `fk_Post_Event1_idx` (`Event_id` ASC) VISIBLE,
  CONSTRAINT `fk_Post_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `fastsociety`.`User` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_Event1`
    FOREIGN KEY (`Event_id`)
    REFERENCES `fastsociety`.`Event` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fastsociety`.`Message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastsociety`.`Message` ;

CREATE TABLE IF NOT EXISTS `fastsociety`.`Message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `textContent` VARCHAR(45) NOT NULL,
  `createdOn` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `User_id` VARCHAR(50) NOT NULL,
  `Society_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Message_User1_idx` (`User_id` ASC) VISIBLE,
  INDEX `fk_Message_Society1_idx` (`Society_id` ASC) VISIBLE,
  CONSTRAINT `fk_Message_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `fastsociety`.`User` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Message_Society1`
    FOREIGN KEY (`Society_id`)
    REFERENCES `fastsociety`.`Society` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fastsociety`.`Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastsociety`.`Comment` ;

CREATE TABLE IF NOT EXISTS `fastsociety`.`Comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `textContent` VARCHAR(45) NOT NULL,
  `createdOn` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `User_id` VARCHAR(50) NOT NULL,
  `Event_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Comment_User1_idx` (`User_id` ASC) VISIBLE,
  INDEX `fk_Comment_Event1_idx` (`Event_id` ASC) VISIBLE,
  CONSTRAINT `fk_Comment_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `fastsociety`.`User` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comment_Event1`
    FOREIGN KEY (`Event_id`)
    REFERENCES `fastsociety`.`Event` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fastsociety`.`Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastsociety`.`Review` ;

CREATE TABLE IF NOT EXISTS `fastsociety`.`Review` (
  `User_id` VARCHAR(50) NOT NULL,
  `Event_id` INT NOT NULL,
  `stars` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`User_id`, `Event_id`),
  INDEX `fk_Post_User1_idx` (`User_id` ASC) VISIBLE,
  INDEX `fk_Post_Event1_idx` (`Event_id` ASC) VISIBLE,
  CONSTRAINT `fk_Post_User10`
    FOREIGN KEY (`User_id`)
    REFERENCES `fastsociety`.`User` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_Event10`
    FOREIGN KEY (`Event_id`)
    REFERENCES `fastsociety`.`Event` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `fastsociety`.`User` (`id`, `name`, `email`, `image`)
VALUES ('103296335140967313495', 'Mohsin Shaikh', 'k191308@nu.edu.pk', 'https://lh3.googleusercontent.com/a/AATXAJxhrAZgsRKmqei3QmfYReaEKoTzvVGCqRWLhNO5=s96-c');

INSERT INTO `fastsociety`.`User` (`id`, `name`, `email`, `image`)
VALUES ('108417720736449487580', 'k19 0274', 'k190274@nu.edu.pk', 'https://lh3.googleusercontent.com/a-/AOh14GjkUH94ACxo9bR9bPEljz1FrfFFA97xqrWL-OQnYQ=s96-c');

INSERT INTO `fastsociety`.`User` (`id`, `name`, `email`, `image`)
VALUES ('118074802032372663340', 'Mukesh Kumar', 'k190251@nu.edu.pk', 'https://lh3.googleusercontent.com/a-/AOh14Gi3acSXWVeVafz5Lh-J2XAk0CfFctXTTOUbhF5Y=s96-c');


INSERT INTO `fastsociety`.`Society` (`id`, `title`, `description`, `image`, `head_id`)
VALUES (1, 'app', 'fastsociety', 'https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554__340.jpg', '103296335140967313495');

INSERT INTO `fastsociety`.`Society` (`id`, `title`, `description`, `image`, `head_id`)
VALUES (2, 'app2', 'fastsociety2', 'https://cdn.pixabay.com/photo/2017/11/13/07/14/cats-eyes-2944820__340.jpg', '103296335140967313495');

INSERT INTO `fastsociety`.`Role` (name, createEvent, deleteEvent, createPost, deletePost, manageMembers, manageChat, Society_id)
VALUES ('Head', 1, 1, 1, 1, 1, 1, 1);

INSERT INTO `fastsociety`.`Role` (name, Society_id)
VALUES ('Member', 1);

INSERT INTO `fastsociety`.`Role` (name, createEvent, deleteEvent, createPost, deletePost, manageMembers, manageChat, Society_id)
VALUES ('Head', 1, 1, 1, 1, 1, 1, 2);

INSERT INTO `fastsociety`.`Role` (name, Society_id)
VALUES ('Member', 2);

INSERT INTO `fastsociety`.`Registration` (User_id, Society_id, Role_name)
VALUES ('103296335140967313495', 1, 'Head');

INSERT INTO `fastsociety`.`Registration` (User_id, Society_id, Role_name)
VALUES ('103296335140967313495', 2, 'Member');

INSERT INTO `fastsociety`.`Registration` (User_id, Society_id, Role_name)
VALUES ('118074802032372663340', 1, 'Head');



INSERT INTO `fastsociety`.`Registration` (User_id, Society_id, Role_name)
VALUES ('108417720736449487580', 2, 'Head');

INSERT INTO `fastsociety`.`Event` (`id`, `textContent`, `startTime`, `endTime`, `image`, `User_id`, `Society_id`)
VALUES (1, 'app creation', '2021-12-01 00:00:00', '2021-12-15 10:00:00', '/images/kitty1.jpg', '103296335140967313495', 1);

INSERT INTO `fastsociety`.`Event` (`id`, `textContent`, `startTime`, `endTime`, `image`, `User_id`, `Society_id`)
VALUES (2, 'app2 creation', '2021-12-10 00:00:00', '2021-12-15 08:00:00', '/images/kitty2.jpg', '103296335140967313495', 2);

INSERT INTO `fastsociety`.`Event` (`id`, `textContent`, `image`, `User_id`, `Society_id`)
VALUES (3, 'GOT KHARAB', '/images/got.mp4', '108417720736449487580', 2);

INSERT INTO `fastsociety`.`Post` (`textContent`, `image`, `User_id`, `Event_id`)
VALUES ('zero2', '/images/zero2.jpeg', '103296335140967313495', 1);

INSERT INTO `fastsociety`.`Post` (`textContent`, `image`, `User_id`, `Event_id`)
VALUES ('GOT KHARAB KITTY GUD', '/images/kittyvid.mp4', '108417720736449487580', 3);

INSERT INTO `fastsociety`.`Comment` (`id`, `textContent`, `User_id`, `Event_id`)
VALUES (1, 'cool cat dud', '103296335140967313495', 1);