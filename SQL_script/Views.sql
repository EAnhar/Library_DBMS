Create view vBookStatus As
SELECT  b.B_Name Book_Name ,A.Author_Name ,r.Availabilty
FROM book b,Author A,resources r
where  r.resourceID = b.ISBN  AND  b.AuthorID  = A.AuthorID ;



CREATE VIEW LibraryADs AS
SELECT Member_ID,First_Name,Last_Name,Member_Type,Email 
FROM database_projrct.members;

INSERT INTO LibraryADs( First_Name,Last_Name,Member_Type, Email )  value('LOLO','Al-fize','Undergraduate_Student','LOLO@qu.edu.sa');
