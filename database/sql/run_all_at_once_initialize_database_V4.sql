
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
AUTO_INCREMENT = 1
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
AUTO_INCREMENT = 1
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
AUTO_INCREMENT = 1
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
AUTO_INCREMENT = 1
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
  `original_estimation` VARCHAR(45) NULL DEFAULT NULL,
  `new_estimation` VARCHAR(45) NULL DEFAULT NULL,
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
AUTO_INCREMENT = 1
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
AUTO_INCREMENT = 1
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

-- insert table User

INSERT INTO ase.User(userName,password,priviledge)VALUES("hiep","passhiep",1);
INSERT INTO ase.User(userName,password,priviledge)VALUES("nicole","passnicole",2);
INSERT INTO ase.User(userName,password,priviledge)VALUES("anju","passanju",1);
INSERT INTO ase.User(userName,password,priviledge)VALUES("shreya","passshreya",2);

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

INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("As an Acquisition Gateway User, I need to select an Auction product in the Acquisition ordering platform so that I can bid on it.","3 story points",1);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("As an Acquisition Gateway User, I need to review my previous bids in the Acquisition ordering platform so that I can remove expired bids.","5 story points",1);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("As a Content Owner, I want to be able to create product content so that I can provide information and market to customers.","1 story points",1);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("As an Editor, I want to review content before it is published so that I can assure it is optimized with correct grammar and tone.","2 story points",1);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("As an EBC Requester, I want to know what catalog of services GSA IT offers so that I can determine if an existing platform can support my proposed project.","8 story points",1);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("As an EBC Requester, I want to have a checklist of outputs so that I can submit a complete EBC request.","13 story points",2);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("As a HR Manager, I need to view a candidate’s status so that I can manage their application process throughout the recruiting phases.","21 story points",3);
INSERT INTO ase.UserStory(description,estimation,Project_idProject)VALUES("As a Marketing Data Analyst, I need to run the Salesforce & Google analytics reports the so that I can build the monthly media campaign plans.","3 story points",4);


-- insert table Issue

INSERT INTO ase.Issue(title,description,type,important,dateCreation,original_estimation,new_estimation,resolution,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("Create table UserStory","We need to create a new table to storage user stories in project Agile. The new table should contains information about date created, assignee, reporter, original_estimation point..","task","1",now(),"3 points","5 points","Use MySQL workbench to create new table and generate corresponding Sql script",1,1,1,1);
INSERT INTO ase.Issue(title,description,type,important,dateCreation,original_estimation,new_estimation,resolution,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("Make initial insert query for table UserStory","We need to insert mock data to new created table UserStory. The mock data should be simple and alike real user story","task","1",now(),"3 points","2 points","User MySQL workbench or PHP MyAdmin to create insert query and test it by executing and commit the query on local machine",2,2,1,2);
INSERT INTO ase.Issue(title,description,type,important,dateCreation,original_estimation,new_estimation,resolution,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("Fix relationship between table UserStory and Project in database Schema","The current relationship between table UserStory and Project is one-to-one relationship. We should update it by many-to-many relationship","task","1",now(),"3 points","8 points","Use MySQL Workbench, delete the current relationship and select the third symbol in  relationship section to create new many-to-many relationship ",1,3,2,1);
INSERT INTO ase.Issue(title,description,type,important,dateCreation,original_estimation,new_estimation,resolution,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("Create new table Comment in database ","The actual comment field in Issue table is not good because an issue can have multiple comments from various users. So create a new table Comment so that an issue can have many comments, for each comment we need to know the content, the author and date created .","taks","2",now(),"4 points","3 points","Use MySQL Workbench to crate a new table named Comment, create one-to-many relationshiep between Issue table and Comment table. Create one-to-one relationship between table User and table Comment.",3,4,2,3);
INSERT INTO ase.Issue(title,description,type,important,dateCreation,original_estimation,new_estimation,resolution,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("Make initial insert query for new table Comment","We need to insert mock data to new created table Comment.One row of that table should contain the content of comment, author, date created and related issue Id.","task","3",now(),"3 points","13 points","User MySQL workbech or PHP MyAdmin to create insert queries for the table, execute it, test it and commit the transaction.",4,2,3,4);
INSERT INTO ase.Issue(title,description,type,important,dateCreation,original_estimation,new_estimation,resolution,Status_idStatus,UserStory_idUserStory,User_idAssignee,User_idReporter)VALUES("Remove old field Comment TinyText in table Issue","Because we create new table Comment to handle all the comments of an issue. In the table Issue we need to delete the field comment of type TINYTEXT.","fixbug","2",now(),"2 points","1 points","Use MySQL workbech to remove the field in the table Issue then regereneate the script to create database, also update the initializing database script queries.",2,5,4,2);

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

-- insert table Issue_has_Project

INSERT INTO ase.Issue_has_Project(Issue_idIssue,Project_idProject)VALUES(1,1);
INSERT INTO ase.Issue_has_Project(Issue_idIssue,Project_idProject)VALUES(2,2);
INSERT INTO ase.Issue_has_Project(Issue_idIssue,Project_idProject)VALUES(3,1);
INSERT INTO ase.Issue_has_Project(Issue_idIssue,Project_idProject)VALUES(4,1);
INSERT INTO ase.Issue_has_Project(Issue_idIssue,Project_idProject)VALUES(5,2);

-- insert table comment

INSERT INTO ase.Comment(idComment,content,Issue_idIssue,User_idUser)VALUES(1,"I think that this table should be better if the comments can be stored in a seperated table because an issue can have multiple comments. Also for each comment we want to know the author of it to track and ask question if necessary.",1,1);
INSERT INTO ase.Comment(idComment,content,Issue_idIssue,User_idUser)VALUES(2,"I think our direction on this project is fine but how can we retrieve data for project backlog if we don't have table project backlog ?",1,1);
INSERT INTO ase.Comment(idComment,content,Issue_idIssue,User_idUser)VALUES(3,"We can present the project backlog only in business layer and presentation layer by PHP code. It's not necessary to have a sepearted table Project_Backlog because it's wasteful in term of resources.",2,2);
INSERT INTO ase.Comment(idComment,content,Issue_idIssue,User_idUser)VALUES(4,"We need to update an issue, so for actual Issue page, we should have an edit button for that ?",1,2);
INSERT INTO ase.Comment(idComment,content,Issue_idIssue,User_idUser)VALUES(5,"This userstory should be clarified more because it should follow the pattern: As a < type of user >, I want < some goal > so that < some reason >. If this userstory is too big, we should consider it an epic ! ",1,3);
