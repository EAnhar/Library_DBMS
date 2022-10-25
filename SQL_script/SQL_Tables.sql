------------------------------------Privilege TABLE-----------------------------------------------/

CREATE TABLE Privilege (
    Privileges_ID INT(11) , 
    privilegesName VARCHAR(30) NOT NULL , 
    Loan_Period varchar(10),
    MaxNumItemToLoan INT(11) , 
    MaxNumRenewal INT(11),

    CONSTRAINT Privilege_PK
        PRIMARY KEY(Privileges_ID,privilegesName)

);
INSERT into Privilege(Privileges_ID,privilegesName,Loan_Period,MaxNumItemToLoan,MaxNumRenewal) 
values 
 ( 1,'Faculty','120 day ',5,6  ) 
, ( 2,'Postgraduate_Student',' 90 days ',3  , 4 ) 
, ( 3 ,'staff','30 days ',2, 3 )
, ( 4,'Undergraduate_Student','14 days ',  2,  3) 
, ( 5,'Community_Patrons','7 days ', 1 , 1 ) ;

------------------------------Members TABLE-----------------------------------/
CREATE TABLE Members (
    Member_ID INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    PIN VARCHAR(15) NOT NULL ,
    First_Name VARCHAR(20) NOT NULL ,
    Last_Name VARCHAR(20),
    Member_Type VARCHAR(30) NOT NULL 
        Check(Member_Type in('Faculty','Postgraduate_Student','Undergraduate_Student','Staff','Community_Patrons')),
    Email VARCHAR(40) 
        Check(Email LIKE '%@qu.edu.sa'),
    Address VARCHAR(40),
    Call_Number numeric(10) NOT NULL,

    CONSTRAINT Member_FK 
        FOREIGN KEY(Member_Type) REFERENCES Privilege(privilegesName)

);
 INSERT INTO Members (Member_ID, PIN , First_Name ,Last_Name, Member_Type,Email,Address,Call_Number)  VALUES 
(001,'12345', 'Shatha','Al-bahouth', 'Undergraduate_Student','shatha@qu.edu.sa','Buraydah-Albsateen',9663341556)
, (002,'13344', 'Anhar','Al-dosary', 'Undergraduate_Student','Anhar@qu.edu.sa','Buraydah-Alrafeah',9663224557)
, (003,'45566', 'Sara','Al-ghofaily', 'Undergraduate_Student','Sara@qu.edu.sa','Ar-Rass-Alqadisiah',9663184553)
, (004,'98765', 'Monerah','Al-harbi', 'Staff','Monerah@qu.edu.sa','Unaizah',9663584590)
, (005,'76544', 'banan','Al-hassn', 'Postgraduate_Student','banan@qu.edu.sa','Buraydah-Alnqa',9663525541)
, (006,'83230', 'alaa','Al-motoa', 'Community_Patrons','alaa@qu.edu.sa','Buraydah-Alkhbib',9663025523)
, (007,'02488', 'asma','Al-shargabi', 'Faculty','as.alshargabi@qu.edu.sa',NULL,9663525532)
,(008,'23444', 'maha','Al-fozan', 'Community_Patrons','maha@qu.edu.sa','Ar-Rass',9663525566)
, (009,'35908', 'noof','Al-harbi', 'Postgraduate_Student','noof@qu.edu.sa','Unaizah',9660525181)
 ,(010,'02488', 'raqinah','Al-rabia', 'Faculty','raqinah@qu.edu.sa',NULL,9663525119) 
 ,(011, 'A1234', 'Abeer', 'Alhujaylan', 'Faculty', 'a.alhujaylan@qu.edu.sa', NULL, '05355768765');
------------------------------------Card TABLE-----------------------------------------------/

CREATE TABLE Cards (
    Member_ID INT NOT NULL,
    Register_DATE date,
    Register_expired date
        Check(Register_DATE < Register_expired ),
    Member_Status VARCHAR(10)  NOT NULL
        Check (Member_Status in ('Active','Inactive')),
        
    CONSTRAINT Card_FK 
        FOREIGN KEY(Member_ID)REFERENCES Members(Member_ID)ON DELETE CASCADE
);
INSERT INTO Cards (Member_ID, Register_DATE , Register_expired ,Member_Status )  VALUES 
 (001,'2021-01-09', '2022-01-09','Inactive')
,(002,'2022-03-12', '2023-03-12','Active')
,(003,'2022-04-22', '2023-04-22','Active')
,(004,'2021-11-25', '2022-11-25','Active')
,(005,'2020-12-28', '2021-12-28','Inactive')
,(006,'2021-6-14', '2022-6-14','Inactive')
,(007,'2022-10-10', '2023-10-10','Active')
,(008,'2022-8-03', '2023-8-03','Active' )
,(009,'2021-12-09', '2022-12-09','Active')
,(010,'2022-02-21', '2023-02-21','Active')
,(011,'2022-01-21', '2023-01-21','Active');


-------------------------------------Author TABLE-----------------------------------------------/
CREATE TABLE Author (
    AuthorID INT  PRIMARY KEY, 
    Author_Name  VARCHAR(30) NOT NULL,
    Call_Number numeric(10),
    Year_Of_Birth numeric(4)
);

INSERT INTO AUTHOR (AuthorID, Author_Name , Call_Number ,Year_Of_Birth ) values 
    (23,'Bill Bryson'       , 9663552346 ,1933), 
    (34, 'Herman Hesse'     , 9665436456, 1943), 
    (12,'Fyodor Dostoevsky' , 966348464,2001), 
    (17,'Oscar Wilde'       , 9662344566,1999), 
    (13,'Franz Kafka'       , 9662342523,1932), 
    (16,'J.k Rowling'       , 9663451333,1980), 
    (18,'Carl Jung'         , 9664565675,1977), 
    (10,'Dale Carnegie'     , 9665463457,1997);
------------------------------Book TABLE-----------------------------------/

CREATE TABLE Book (
    ISBN  numeric(13) PRIMARY KEY, 
    B_Name VARCHAR(40) NOT NULL,
    B_Edition VARCHAR(20),
    B_Subject VARCHAR(15) ,
    Book_Type VARCHAR(50) NOT NULL
        Check(Book_Type in ('eBook','Paper_Book')),
    AuthorID  INT NOT NULL ,
    Publisher  VARCHAR(25),
    B_Language VARCHAR(15),

    CONSTRAINT BOOK_FK1 
        FOREIGN KEY(AuthorID)REFERENCES Author(AuthorID)ON DELETE CASCADE
);
INSERT INTO BOOK(ISBN , B_Name , B_Edition , B_Subject ,Book_Type , AuthorID , Publisher , B_Language) values 
    (0872204642, 'Nicomachean Ethics'                   ,'1st'  ,'Guide'        ,'eBook'     ,18 ,'Random house ','ENGLISH' ),
    (0552997048,'A Short History of Nearly Everything'  ,'4th'  ,'Short story'  ,'Paper_Book',10 ,'Haeper Colline','ARABIC' ),
    (0805012469, 'The Glass Bead Game'                  ,'7th'  ,'Thriller'     ,'Paper_Book', 10,'Simon & schuster','ENGLISH' ),
    (0140449132, 'Crime and Punishment'                 ,'3rd'  ,'History'      ,'eBook'     ,18 ,'william Tyndale','ENGLISH' ),
    (1686705026,'The Picture of Dorian Gray'            ,''     ,'Diary'        ,'Paper_Book',23 ,'Abrams books','ENGLISH' ),
    (1505297052, 'The Metamorphosis'                    ,'1st'  ,'Mystery'      ,'eBook'     , 34,'Piatkus','ARABIC' ),
    (1408845660,'Harry Potter and the Prisoner of Azkaban','9th','Fantasy'      ,'Paper_Book',16 ,'Abrams books','ENGLISH' ),
    (0613922670, 'Man and His Symbols'                  , ''    ,'Anthology'    ,'Paper_Book', 13,'Piatkus','ARABIC' ),
    (0091906350,'How to Win Friends and Influence People','5th' ,'Guide'        ,'Paper_Book',18 ,'Random house','ENGLISH' ),
    (0722532938, 'The Alchemist'                        ,'3rd'  ,'Science'      ,'Paper_Book', 10,'Piatkus','ENGLISH' ),
    (0261103571,'The Fellowship of the Ring '           ,'7th'  ,'Philosophy'   ,'eBook'     , 17,'Piatkus','ARABIC' ),
    (0007461216, 'Mere Christianity'                    ,''     ,'Religion'     ,'Paper_Book', 13,'Abrams books','ARABIC' ),
    (1208045660,'Harry Potter and the Half-Blood Prince','8th','Fantasy'      ,'Paper_Book',16 ,'Abrams books','ENGLISH' ),
    (8638845660,'Harry Potter and the Deathly Hallows','5th','Fantasy'      ,'Paper_Book',16 ,'Abrams books','ENGLISH' );

-------------------------------Video_Sound_Record TABLE-----------------------------------/

CREATE TABLE Video_Sound_Record (
    Record_ID int PRIMARY KEY, 
    Record_Title VARCHAR(40) NOT NULL ,
    Record_Type  VARCHAR(40) NOT NULL 
        Check(Record_Type in ('Sound','Video')),
    R_DESCRIPTION VARCHAR(90),
    R_Location VARCHAR(30),
    Publisher VARCHAR(25)

);
INSERT INTO Video_Sound_Record (Record_ID,Record_Title,Record_Type,R_DESCRIPTION,R_Location,Publisher)
-----------------------------------Thesis TABLE-----------------------------------------------/

CREATE TABLE Thesis (
    T_ID int PRIMARY KEY, 
    T_Title VARCHAR(40) NOT NULL ,
    T_DESCRIPTION VARCHAR(90),
    AuthorID  INT NOT NULL ,
    T_Location VARCHAR(30),

    CONSTRAINT Thesis_FK 
        FOREIGN KEY(AuthorID)REFERENCES Author(AuthorID)ON DELETE CASCADE
);
Insert into Thesis (T_ID,T_Title,T_DESCRIPTION,AuthorID,T_Location)

-------------------------------------Journal TABLE-----------------------------------------------/

CREATE TABLE Journal (
    J_ID INT PRIMARY KEY , 
    J_Title VARCHAR(90) NOT NULL ,
    Journal_type VARCHAR(40) NOT NULL
        Check(Journal_type in ('Newspaper','Article')),
    Release_Date date
);
INSERT INTO Journal (J_ID , J_Title , Journal_type , Release_Date ) values
( 948,'A Closer Look at Appearance and Social Media' ,'Article'     ,'2022-05-28'  ),
( 496,'Me, My Selfie, and I'                         ,'Article'     ,'2020-03-05'   ),
( 478 ,'The Novel Coronavirus (COVID-2019) Outbreak' ,'Newspaper'   ,'2019-06-09' ),
( 695,'The Construction of “Critical Thinking”'      ,'Newspaper'   ,'2021-04-28'  ),
( 375,'Treatment of Alcohol Use Disorder'            ,'Article'     , '2016-12-25' );

------------------------------------Fine TABLE-----------------------------------------------/
CREATE TABLE Fine (
    Loan_ID INT , 
    Fine_DESCRIPTION VARCHAR(90),
    Amount INT NOT NULL, 
    Fine_Status VARCHAR(10) NOT NULL
        Check (Fine_Status in ('Paid','Unpaid')),

    CONSTRAINT Fine_FK 
        FOREIGN KEY(Loan_ID)REFERENCES Loan(Loan_ID)ON DELETE CASCADE
);

------------------------------------Room TABLE-----------------------------------------------/

CREATE TABLE Room (
    Room_number int PRIMARY KEY , 
    Room_Type VARCHAR(50) NOT NULL
        Check(Room_Type in('Lab','Reading_Room','Working_Room')) , 
    R_Location VARCHAR(50) , 
    MaxDuration varchar(10)
);
INSERT INTO Room(Room_number,Room_Type,R_Location,MaxDuration) values
( 302, 'Lab'         , 'Computer_Collage','2 hour'),
( 305, 'Reading_Room', 'Scientific_Collage','1 hour'),
( 204, 'Lab'         , 'Scientific_Collage','2 hour'),
( 211, 'Reading_Room', 'Computer_Collage','1 hour'),
( 309, 'Working_Room', 'Computer_Collage','5 hour'),
( 214, 'Reading_Room', 'Scientific_Collage','1 hour');


--------------------------------------------------------
CREATE TABLE RESOURCES (
    resourceID VARCHAR(20),
    ResourceType  VARCHAR(30) NOT NULL
        CHECK(ResourceType IN('Book','Room','Thesis','Journal','Video_Sound_Record')),
    Availabilty VARCHAR(20) NOT NULL 
        Check(Availabilty in ('Available','Unavailable')),
    Privileges_LEVEL INT NOT NULL 
        Check (Privileges_LEVEL in (1 ,2 , 3 , 4 , 5)),

    CONSTRAINT RESOURCES_PK
        PRIMARY KEY(resourceID , ResourceType),
    CONSTRAINT RESOURCES_FK
        FOREIGN KEY(Privileges_LEVEL) REFERENCES Privilege(Privileges_ID)ON DELETE CASCADE
);

-------------------------------------Loan TABLE-----------------------------------------------/
CREATE TABLE Loan (
    Loan_ID INT PRIMARY KEY, 
    MemberID INT NOT NULL , 
    resourceID VARCHAR(20)  NOT NULL , 
    Date_Taken_Out timestamp NOT NULL , 
    Date_Returned  timestamp , 

    CONSTRAINT LOAN_FK 
        FOREIGN KEY(MemberID)REFERENCES Members(Member_ID)ON DELETE CASCADE,
       
    CONSTRAINT LOAN_FK2 
        FOREIGN KEY(resourceID)REFERENCES RESOURCES(resourceID)ON DELETE CASCADE
);

-------------------------------------Collection TABLE-----------------------------------------------/
CREATE TABLE Collection (
    Collection_Name VARCHAR(40) , 
    Collection_Type  VARCHAR(30) ,
    C_Subject VARCHAR(20),
    ID_of_Items VARCHAR(20) NOT NULL,

    CONSTRAINT Coll_PK 
        PRIMARY KEY(Collection_Name,ID_of_Items)
);

INSERT INTO Collection(Collection_Name , Collection_Type,C_Subject,ID_of_Items) values
('Harry Potter','Book','Fantasy',1408845660 ),
('Harry Potter','Book','Fantasy', 1208045660),
('Harry Potter','Book','Fantasy',8638845660 );


