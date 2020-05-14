-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ase
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ase` ;

-- -----------------------------------------------------
-- Schema ase
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ase` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `ase` ;

-- -----------------------------------------------------
-- Table `ase`.`Status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`Status` ;

CREATE TABLE IF NOT EXISTS `ase`.`Status` (
  `idStatus` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idStatus`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ase`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`User` ;

CREATE TABLE IF NOT EXISTS `ase`.`User` (
  `idUser` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `priviledge` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ase`.`Project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`Project` ;

CREATE TABLE IF NOT EXISTS `ase`.`Project` (
  `idProject` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `projectName` VARCHAR(45) NULL DEFAULT NULL,
  `startDate` DATETIME NULL DEFAULT NULL,
  `endDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idProject`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ase`.`UserStory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`UserStory` ;

CREATE TABLE IF NOT EXISTS `ase`.`UserStory` (
  `idUserStory` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  `estimation` VARCHAR(45) NULL DEFAULT NULL,
  `Project_idProject` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idUserStory`),
  INDEX `fk_UserStory_Project1_idx` (`Project_idProject` ASC) VISIBLE,
  CONSTRAINT `fk_UserStory_Project1`
    FOREIGN KEY (`Project_idProject`)
    REFERENCES `ase`.`Project` (`idProject`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ase`.`Issue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`Issue` ;

CREATE TABLE IF NOT EXISTS `ase`.`Issue` (
  `idIssue` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `important` VARCHAR(45) NULL DEFAULT NULL,
  `dateCreation` DATETIME NULL DEFAULT NULL,
  `estimation` VARCHAR(45) NULL DEFAULT NULL,
  `resolution` VARCHAR(500) NULL DEFAULT NULL,
  `Status_idStatus` INT UNSIGNED NOT NULL,
  `UserStory_idUserStory` INT UNSIGNED NOT NULL,
  `User_idAssignee` INT UNSIGNED NOT NULL,
  `User_idReporter` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idIssue`),
  INDEX `fk_Issue_Status1_idx` (`Status_idStatus` ASC) VISIBLE,
  INDEX `fk_Issue_UserStory1_idx` (`UserStory_idUserStory` ASC) VISIBLE,
  INDEX `fk_Issue_User1_idx` (`User_idAssignee` ASC) VISIBLE,
  INDEX `fk_Issue_User2_idx` (`User_idReporter` ASC) VISIBLE,
  CONSTRAINT `fk_Issue_Status1`
    FOREIGN KEY (`Status_idStatus`)
    REFERENCES `ase`.`Status` (`idStatus`),
  CONSTRAINT `fk_Issue_User1`
    FOREIGN KEY (`User_idAssignee`)
    REFERENCES `ase`.`User` (`idUser`),
  CONSTRAINT `fk_Issue_User2`
    FOREIGN KEY (`User_idReporter`)
    REFERENCES `ase`.`User` (`idUser`),
  CONSTRAINT `fk_Issue_UserStory1`
    FOREIGN KEY (`UserStory_idUserStory`)
    REFERENCES `ase`.`UserStory` (`idUserStory`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ase`.`Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`Comment` ;

CREATE TABLE IF NOT EXISTS `ase`.`Comment` (
  `idComment` INT NOT NULL,
  `content` TINYTEXT NULL DEFAULT NULL,
  `Issue_idIssue` INT UNSIGNED NOT NULL,
  `User_idUser` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idComment`, `Issue_idIssue`),
  INDEX `fk_Comment_Issue1_idx` (`Issue_idIssue` ASC) VISIBLE,
  INDEX `fk_Comment_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Comment_Issue1`
    FOREIGN KEY (`Issue_idIssue`)
    REFERENCES `ase`.`Issue` (`idIssue`),
  CONSTRAINT `fk_Comment_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `ase`.`User` (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ase`.`Issue_has_Project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`Issue_has_Project` ;

CREATE TABLE IF NOT EXISTS `ase`.`Issue_has_Project` (
  `Issue_idIssue` INT UNSIGNED NOT NULL,
  `Project_idProject` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Issue_idIssue`, `Project_idProject`),
  INDEX `fk_Issue_has_Project_Project1_idx` (`Project_idProject` ASC) VISIBLE,
  INDEX `fk_Issue_has_Project_Issue1_idx` (`Issue_idIssue` ASC) VISIBLE,
  CONSTRAINT `fk_Issue_has_Project_Issue1`
    FOREIGN KEY (`Issue_idIssue`)
    REFERENCES `ase`.`Issue` (`idIssue`),
  CONSTRAINT `fk_Issue_has_Project_Project1`
    FOREIGN KEY (`Project_idProject`)
    REFERENCES `ase`.`Project` (`idProject`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ase`.`Sprint`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`Sprint` ;

CREATE TABLE IF NOT EXISTS `ase`.`Sprint` (
  `idSprint` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `startDate` DATETIME NULL DEFAULT NULL,
  `endDate` DATETIME NULL DEFAULT NULL,
  `Project_idProject` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idSprint`),
  INDEX `fk_Sprint_Project1_idx` (`Project_idProject` ASC) VISIBLE,
  CONSTRAINT `fk_Sprint_Project1`
    FOREIGN KEY (`Project_idProject`)
    REFERENCES `ase`.`Project` (`idProject`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ase`.`Issue_has_Sprint`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`Issue_has_Sprint` ;

CREATE TABLE IF NOT EXISTS `ase`.`Issue_has_Sprint` (
  `Issue_idIssue` INT UNSIGNED NOT NULL,
  `Sprint_idSprint` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Issue_idIssue`, `Sprint_idSprint`),
  INDEX `fk_Issue_has_Sprint_Sprint1_idx` (`Sprint_idSprint` ASC) VISIBLE,
  INDEX `fk_Issue_has_Sprint_Issue1_idx` (`Issue_idIssue` ASC) VISIBLE,
  CONSTRAINT `fk_Issue_has_Sprint_Issue1`
    FOREIGN KEY (`Issue_idIssue`)
    REFERENCES `ase`.`Issue` (`idIssue`),
  CONSTRAINT `fk_Issue_has_Sprint_Sprint1`
    FOREIGN KEY (`Sprint_idSprint`)
    REFERENCES `ase`.`Sprint` (`idSprint`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ase`.`User_has_Project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`User_has_Project` ;

CREATE TABLE IF NOT EXISTS `ase`.`User_has_Project` (
  `User_idUser` INT UNSIGNED NOT NULL,
  `Project_idProject` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`User_idUser`, `Project_idProject`),
  INDEX `fk_User_has_Project_Project1_idx` (`Project_idProject` ASC) VISIBLE,
  INDEX `fk_User_has_Project_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Project_Project1`
    FOREIGN KEY (`Project_idProject`)
    REFERENCES `ase`.`Project` (`idProject`),
  CONSTRAINT `fk_User_has_Project_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `ase`.`User` (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ase`.`User_has_Sprint`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`User_has_Sprint` ;

CREATE TABLE IF NOT EXISTS `ase`.`User_has_Sprint` (
  `User_idUser` INT UNSIGNED NOT NULL,
  `Sprint_idSprint` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`User_idUser`, `Sprint_idSprint`),
  INDEX `fk_User_has_Sprint_Sprint1_idx` (`Sprint_idSprint` ASC) VISIBLE,
  INDEX `fk_User_has_Sprint_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Sprint_Sprint1`
    FOREIGN KEY (`Sprint_idSprint`)
    REFERENCES `ase`.`Sprint` (`idSprint`),
  CONSTRAINT `fk_User_has_Sprint_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `ase`.`User` (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
