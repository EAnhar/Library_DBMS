
---------------------vBookStatus--------------------------

Create view vBookStatus As
  SELECT  b.B_Name Book_Name ,A.Author_Name ,r.Availabilty
  FROM book b,Author A,resources r
  where  r.resourceID = b.ISBN  AND  b.AuthorID  = A.AuthorID ;

-- Since The book status view can not be tested(insert into it) in our database design,
-- because of the status of book and the author are come from another tables.

-- Instead of it we create another view named Library ADs which contain
-- all members ID , name, member type and Email, to be used in advertisements.

CREATE VIEW LibraryADs AS
  SELECT Member_ID,First_Name,Last_Name,Member_Type,Email 
  FROM database_projrct.members;


