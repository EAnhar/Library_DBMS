
\---------------------vBookStatus--------------------------\

Create view vBookStatus As
SELECT  b.B_Name Book_Name ,A.Author_Name ,r.Availabilty
FROM book b,Author A,resources r
where  r.resourceID = b.ISBN  AND  b.AuthorID  = A.AuthorID ;




\---------------------Available_resources view--------------------------\
CREATE VIEW Available_resources AS
SELECT resourceID ,ResourceType,Availabilty,Privileges_LEVEL
FROM resources1 r
where  Availabilty = 'Available' ;


\---------------------ResourcesRole--------------------------\
CREATE ROLE  ResourcesRole;
GRANT select ON Available_resources TO ResourcesRole;
GRANT ResourcesRole TO Monerah;

\---------------------Available_resources INSERT--------------------------\
INSERT INTO vbookstatus4( resourceID,ResourceType,Availabilty,Privileges_LEVEL )  value(38,'BOOK',74,'Availabilty',3);






\---------------------LibraryADs VIEW--------------------------\
CREATE VIEW LibraryADs AS
SELECT Member_ID,First_Name,Last_Name,Member_Type,Email 
FROM database_projrct.members;
\---------------------LibraryADs INSERT--------------------------\
INSERT INTO LibraryADs( First_Name,Last_Name,Member_Type, Email )  value('Lolo','Al-fize','Undergraduate_Student','LOLO@qu.edu.sa');




