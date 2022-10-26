Create view vBookStatus As
SELECT  b.B_Name Book_Name ,A.Author_Name ,r.Availabilty
FROM book b,Author A,resources r
where  r.resourceID = b.ISBN  AND  b.AuthorID  = A.AuthorID ;

