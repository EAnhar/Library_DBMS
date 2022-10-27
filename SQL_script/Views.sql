Create view vBookStatus As
SELECT  b.B_Name Book_Name ,A.Author_Name ,r.Availabilty
FROM book b,Author A,resources r
where  r.resourceID = b.ISBN  AND  b.AuthorID  = A.AuthorID ;




CREATE VIEW Available_resources AS
SELECT resourceID ,ResourceType,Availabilty,Privileges_LEVEL
FROM resources1 r
where  Availabilty = 'Available' ;



CREATE ROLE  ResourcesRole;
GRANT select ON Available_resources TO ResourcesRole;
GRANT ResourcesRole TO Monerah;

INSERT INTO vbookstatus4( resourceID,ResourceType,Availabilty,Privileges_LEVEL )  value(38,'BOOK',74,'Availabilty',3);
