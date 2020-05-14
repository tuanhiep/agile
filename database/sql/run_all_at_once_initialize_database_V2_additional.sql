
/* use with v2 script*/
/*Status table*/
ALTER TABLE ase.status ADD Name varchar(20);
INSERT INTO ase.status (idStatus, Name) VALUES (5, "Done");
UPDATE ase.status SET Name="New" WHERE idStatus=1; 
UPDATE ase.status SET Name="ToDo" WHERE idStatus=2; 
UPDATE ase.status SET Name="InProgress" WHERE idStatus=3; 
UPDATE ase.status SET Name="InReview" WHERE idStatus=4; 

/* user table */
UPDATE ase.user SET userName="Anju" WHERE idUser=1; 
UPDATE ase.user SET userName="Nicole" WHERE idUser=2; 
UPDATE ase.user SET userName="Hiep" WHERE idUser=3; 
UPDATE ase.user SET userName="Shreya" WHERE idUser=4; 

/* issue table */
ALTER TABLE ase.issue ADD Actual_estimate varchar(5);
ALTER TABLE ase.issue ADD Comment varchar(200);
ALTER TABLE ase.issue ADD sprint_id INT UNSIGNED;
ALTER TABLE ase.issue ADD CONSTRAINT FOREIGN KEY (sprint_id) REFERENCES ase.sprint(idSprint);


