-- insert table comment

INSERT INTO ase.Comment(idComment,content,Issue_idIssue,User_idUser)VALUES(1,"I think that this table should be better if the comments can be stored in a seperated table because an issue can have multiple comments. Also for each comment we want to know the author of it to track and ask question if necessary.",1,1);
INSERT INTO ase.Comment(idComment,content,Issue_idIssue,User_idUser)VALUES(2,"I think our direction on this project is fine but how can we retrieve data for project backlog if we don't have table project backlog ?",1,1);
INSERT INTO ase.Comment(idComment,content,Issue_idIssue,User_idUser)VALUES(3,"We can present the project backlog only in business layer and presentation layer by PHP code. It's not necessary to have a sepearted table Project_Backlog because it's wasteful in term of resources.",2,2);
INSERT INTO ase.Comment(idComment,content,Issue_idIssue,User_idUser)VALUES(4,"We need to update an issue, so for actual Issue page, we should have an edit button for that ?",1,2);
INSERT INTO ase.Comment(idComment,content,Issue_idIssue,User_idUser)VALUES(5,"This userstory should be clarified more because it should follow the pattern: As a < type of user >, I want < some goal > so that < some reason >. If this userstory is too big, we should consider it an epic ! ",1,3);
