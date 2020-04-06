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
-- Table `ase`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`User` ;

CREATE TABLE IF NOT EXISTS `ase`.`User` (
  `idUser` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `priviledge` INT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ase`.`Project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`Project` ;

CREATE TABLE IF NOT EXISTS `ase`.`Project` (
  `idProject` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `projectName` VARCHAR(45) NULL,
  `startDate` DATETIME NULL,
  `endDate` DATETIME NULL,
  PRIMARY KEY (`idProject`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ase`.`UserStory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`UserStory` ;

CREATE TABLE IF NOT EXISTS `ase`.`UserStory` (
  `idUserStory` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NULL,
  `estimation` VARCHAR(45) NULL,
  `Project_idProject` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idUserStory`),
  INDEX `fk_UserStory_Project1_idx` (`Project_idProject` ASC) VISIBLE,
  CONSTRAINT `fk_UserStory_Project1`
    FOREIGN KEY (`Project_idProject`)
    REFERENCES `ase`.`Project` (`idProject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ase`.`Sprint`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`Sprint` ;

CREATE TABLE IF NOT EXISTS `ase`.`Sprint` (
  `idSprint` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `startDate` DATETIME NULL,
  `endDate` DATETIME NULL,
  `Project_idProject` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idSprint`),
  INDEX `fk_Sprint_Project1_idx` (`Project_idProject` ASC) VISIBLE,
  CONSTRAINT `fk_Sprint_Project1`
    FOREIGN KEY (`Project_idProject`)
    REFERENCES `ase`.`Project` (`idProject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ase`.`Status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`Status` ;

CREATE TABLE IF NOT EXISTS `ase`.`Status` (
  `idStatus` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idStatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ase`.`Issue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ase`.`Issue` ;

CREATE TABLE IF NOT EXISTS `ase`.`Issue` (
  `idIssue` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  `important` VARCHAR(45) NULL,
  `dateCreation` DATETIME NULL,
  `estimation` VARCHAR(45) NULL,
  `resolution` VARCHAR(45) NULL,
  `comment` TINYTEXT NULL,
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
    REFERENCES `ase`.`Status` (`idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Issue_UserStory1`
    FOREIGN KEY (`UserStory_idUserStory`)
    REFERENCES `ase`.`UserStory` (`idUserStory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Issue_User1`
    FOREIGN KEY (`User_idAssignee`)
    REFERENCES `ase`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Issue_User2`
    FOREIGN KEY (`User_idReporter`)
    REFERENCES `ase`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
  CONSTRAINT `fk_User_has_Project_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `ase`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Project_Project1`
    FOREIGN KEY (`Project_idProject`)
    REFERENCES `ase`.`Project` (`idProject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
    REFERENCES `ase`.`Issue` (`idIssue`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Issue_has_Sprint_Sprint1`
    FOREIGN KEY (`Sprint_idSprint`)
    REFERENCES `ase`.`Sprint` (`idSprint`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
  CONSTRAINT `fk_User_has_Sprint_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `ase`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Sprint_Sprint1`
    FOREIGN KEY (`Sprint_idSprint`)
    REFERENCES `ase`.`Sprint` (`idSprint`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- insert table User

INSERT INTO ase.User(userName,password,priviledge)VALUES("hiep","pass",1);
INSERT INTO ase.User(userName,password,priviledge)VALUES("nicole","pass",1);
INSERT INTO ase.User(userName,password,priviledge)VALUES("anju","pass",1);
INSERT INTO ase.User(userName,password,priviledge)VALUES("shreya","pass",1);

-- insert table Project

INSERT INTO ase.Project( projectName, startDate) VALUES ( "ScrumManager", now());
INSERT INTO ase.Project( projectName, startDate) VALUES ( "project1", now());
INSERT INTO ase.Project( projectName, startDate) VALUES ( "project2", now());
INSERT INTO ase.Project( projectName, startDate) VALUES ( "project3", now());
INSERT INTO ase.Project( projectName, startDate) VALUES ( "project4", now());

-- insert table Status

INSERT INTO ase.Status () VALUES ();
INSERT INTO ase.Status () VALUES ();
INSERT INTO ase.Status () VALUES ();
INSERT INTO ase.Status () VALUES ();

-- insert table Sprint

INSERT INTO ase.Sprint(startDate,Project_idProject) VALUES( now(), 1);
INSERT INTO ase.Sprint(startDate,Project_idProject) VALUES( now(), 1);
INSERT INTO ase.Sprint(startDate,Project_idProject) VALUES( now(), 1);
INSERT INTO ase.Sprint(startDate,Project_idProject) VALUES( now(), 1);
INSERT INTO ase.Sprint(startDate,Project_idProject) VALUES( now(), 1);
INSERT INTO ase.Sprint(startDate,Project_idProject) VALUES( now(), 2);
INSERT INTO ase.Sprint(startDate,Project_idProject) VALUES( now(), 2);

-- insert table UserStory

INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("description1","estimation1",1);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("description2","estimation2",1);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("description3","estimation3",1);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("description4","estimation4",1);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("description5","estimation5",1);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("description6","estimation6",2);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("description7","estimation7",3);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("description8","estimation8",4);

-- insert table Issue

INSERT INTO ase.Issue(title,description,type,important,dateCreation,estimation,resolution,comment,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("issue1","description1","type1","important1",now(),"estimation1","resolution1","comment1",1,1,1,1);
INSERT INTO ase.Issue(title,description,type,important,dateCreation,estimation,resolution,comment,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("issue2","description2","type2","important2",now(),"estimation2","resolution2","comment2",2,2,1,2);
INSERT INTO ase.Issue(title,description,type,important,dateCreation,estimation,resolution,comment,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("issue3","description3","type3","important2",now(),"estimation3","resolution3","comment3",1,3,2,1);
INSERT INTO ase.Issue(title,description,type,important,dateCreation,estimation,resolution,comment,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("issue4","description4","type4","important3",now(),"estimation4","resolution4","comment4",3,4,2,3);
INSERT INTO ase.Issue(title,description,type,important,dateCreation,estimation,resolution,comment,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("issue5","description5","type5","important3",now(),"estimation5","resolution5","comment5",4,2,3,4);
INSERT INTO ase.Issue(title,description,type,important,dateCreation,estimation,resolution,comment,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("issue6","description6","type6","important2",now(),"estimation6","resolution6","comment6",2,5,4,2);

-- insert table Issue_has_Sprint

INSERT INTO ase.Issue_has_Sprint(Issue_idIssue,Sprint_idSprint)VALUES(1,2);
INSERT INTO ase.Issue_has_Sprint(Issue_idIssue,Sprint_idSprint)VALUES(2,1);
INSERT INTO ase.Issue_has_Sprint(Issue_idIssue,Sprint_idSprint)VALUES(3,2);
INSERT INTO ase.Issue_has_Sprint(Issue_idIssue,Sprint_idSprint)VALUES(4,1);
INSERT INTO ase.Issue_has_Sprint(Issue_idIssue,Sprint_idSprint)VALUES(5,3);

-- insert tbale User_has_Project

INSERT INTO ase.User_has_Project(User_idUser,Project_idProject)VALUES(1,1);
INSERT INTO ase.User_has_Project(User_idUser,Project_idProject)VALUES(2,1);
INSERT INTO ase.User_has_Project(User_idUser,Project_idProject)VALUES(3,1);
INSERT INTO ase.User_has_Project(User_idUser,Project_idProject)VALUES(4,1);
INSERT INTO ase.User_has_Project(User_idUser,Project_idProject)VALUES(1,2);
INSERT INTO ase.User_has_Project(User_idUser,Project_idProject)VALUES(2,3);

-- insert table User_has_Sprint

INSERT INTO ase.User_has_Sprint(User_idUser,Sprint_idSprint)VALUES(1,1);
INSERT INTO ase.User_has_Sprint(User_idUser,Sprint_idSprint)VALUES(2,1);
INSERT INTO ase.User_has_Sprint(User_idUser,Sprint_idSprint)VALUES(3,1);
INSERT INTO ase.User_has_Sprint(User_idUser,Sprint_idSprint)VALUES(4,1);
INSERT INTO ase.User_has_Sprint(User_idUser,Sprint_idSprint)VALUES(1,2);
INSERT INTO ase.User_has_Sprint(User_idUser,Sprint_idSprint)VALUES(1,3);
