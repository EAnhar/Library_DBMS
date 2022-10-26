------------------------------------Privilege TABLE-----------------------------------------------

CREATE TABLE Privilege (
    Privileges_ID INT(11) , 
    privilegesName VARCHAR(30) NOT NULL , 
    Loan_Period varchar(10),
    MaxNumItemToLoan INT(11) , 
    MaxNumRenewal INT(11),

    CONSTRAINT Privilege_PK
        PRIMARY KEY(Privileges_ID,privilegesName)

);
----------------- INSERT ------------------------
INSERT into Privilege(Privileges_ID,privilegesName,Loan_Period,MaxNumItemToLoan,MaxNumRenewal) 
values 
 ( 1,'Faculty','120 day ',5,6  ) 
, ( 2,'Postgraduate_Student',' 90 days ',3  , 4 ) 
, ( 3 ,'staff','30 days ',2, 3 )
, ( 4,'Undergraduate_Student','14 days ',  2,  3) 
, ( 5,'Community_Patrons','7 days ', 1 , 1 ) ;

------------------------------Members TABLE----------------------------------------------------------
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
----------------- INSERT ------------------------
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
 
------------------------------------Card TABLE----------------------------------------------------------

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
----------------- INSERT ------------------------
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


-------------------------------------Author TABLE---------------------------------------------------
CREATE TABLE Author (
    AuthorID INT  PRIMARY KEY, 
    Author_Name  VARCHAR(30) NOT NULL,
    Call_Number numeric(10),
    Year_Of_Birth numeric(4)
);
------------------ INSERT------------------------
INSERT INTO AUTHOR(AuthorID, Author_Name , Call_Number ,Year_Of_Birth ) values 
    (23,'Bill Bryson'       , 9663552346 ,1933), 
    (34, 'Herman Hesse'     , 9665436456, 1943), 
    (12,'Fyodor Dostoevsky' , 966348464,2001), 
    (17,'Oscar Wilde'       , 9662344566,1999), 
    (13,'Franz Kafka'       , 9662342523,1932), 
    (16,'J.k Rowling'       , 9663451333,1980), 
    (18,'Carl Jung'         , 9664565675,1977), 
    (05,'Ibn Qayyim al-Jawziyya' , 9664087632,1292),
    (07,'Ibn Battuta Al-Tanji' , 9664087632,1304),
    (10,'Dale Carnegie'     , 9665463457,1997);

------------------------------Book TABLE-----------------------------------------------------------

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
    Rsrc_ID varchar(10) Not Null,

    CONSTRAINT BOOK_FK1 
        FOREIGN KEY(AuthorID)REFERENCES Author(AuthorID)ON DELETE CASCADE ,
	CONSTRAINT BOOK_FK2 
        FOREIGN KEY(Rsrc_ID)REFERENCES Resources (resourceID )ON DELETE CASCADE 
	
);
-----------------  INSERT------------------------
INSERT INTO BOOK(ISBN , B_Name , B_Edition , B_Subject ,Book_Type , AuthorID , Publisher , B_Language,Rsrc_ID ) values 
    (0872204642, 'Nicomachean Ethics'                   ,'1st'  ,'Guide'        ,'eBook'     ,18 ,'Random house ','ENGLISH',1 ),
    (0552997048,'A Short History of Nearly Everything'  ,'4th'  ,'Short story'  ,'Paper_Book',10 ,'Haeper Colline','ARABIC',2 ),
    (0805012469, 'The Glass Bead Game'                  ,'7th'  ,'Thriller'     ,'Paper_Book', 10,'Simon & schuster','ENGLISH',3 ),
    (0140449132, 'Crime and Punishment'                 ,'3rd'  ,'History'      ,'eBook'     ,18 ,'william Tyndale','ENGLISH',4 ),
    (1686705026,'The Picture of Dorian Gray'            ,''     ,'Diary'        ,'Paper_Book',23 ,'Abrams books','ENGLISH',5 ),
    (1505297052, 'The Metamorphosis'                    ,'1st'  ,'Mystery'      ,'eBook'     , 34,'Piatkus','ARABIC',6 ),
    (1408845660,'Harry Potter and the Prisoner of Azkaban','9th','Fantasy'      ,'Paper_Book',16 ,'Abrams books','ENGLISH',7 ),
    (0613922670, 'Man and His Symbols'                  , ''    ,'Anthology'    ,'Paper_Book', 13,'Piatkus','ARABIC' ,8),
    (0091906350,'How to Win Friends and Influence People','5th' ,'Guide'        ,'Paper_Book',18 ,'Random house','ENGLISH',9 ),
    (0722532938, 'The Alchemist'                        ,'3rd'  ,'Science'      ,'Paper_Book', 10,'Piatkus','ENGLISH',10 ),
    (0261103571,'The Fellowship of the Ring '           ,'7th'  ,'Philosophy'   ,'eBook'     , 17,'Piatkus','ARABIC',11 ),
    (2745122061, 'Aljawab alkafi '                    ,''     ,'Religion'     ,'Paper_Book', 05,'Scientific Books House','ARABIC',12 ),
    (1208045660,'Harry Potter and the Half-Blood Prince','8th','Fantasy'      ,'Paper_Book',16 ,'Abrams books','ENGLISH',13 ),
    (8638845660,'Ibn Battuta Journey','','Literature and poetry'      ,'Paper_Book',07 ,'dar altaqwaa','ARABIC',14 );

-------------------------------Video_Sound_Record TABLE------------------------------------------------------

 
 CREATE TABLE Video_Sound_Record (
    Record_ID int PRIMARY KEY, 
    Record_Title VARCHAR(40) NOT NULL ,
    Record_Type  VARCHAR(40) NOT NULL 
        Check(Record_Type in ('Sound','Video')),
    R_DESCRIPTION VARCHAR(90),
    R_Location VARCHAR(30),
    Publisher VARCHAR(25),
    Rsrc_ID int ,
	CONSTRAINT Video_Sound_Record_FK
      FOREIGN KEY(Rsrc_ID) REFERENCES RESOURCES(resourceID)ON DELETE CASCADE
);
----------------- INSERT ------------------------
INSERT INTO Video_Sound_Record(Record_ID ,Record_Title,Record_Type,R_DESCRIPTION,R_Location,Publisher,Rsrc_ID) values(
(110, 'Vampire Horror!','Sound' ,'Four classic tales of the undead, read by Bill Wallis, John Telfer and Cornelius Garrett', 'Short stories' ,'Unabridged Audiobook',20 ),
(115, 'Lecture: Physics and Life','Video' ,'answer to "What type of knowledge is gained from physics?"', 'Sciences' ,'WaveSound',21 ),
(111, 'The Giver – Lois Lowry','Sound' ,'The Giver is a 1993 American young adult dystopian novel written by Lois Lowry', 'novel' ,'Ascent Audio',22 ),
(112, 'IT ENDS WITH US','Sound' ,'An honest, evocative, and tender novel, It Ends with Us is “a glorious and touching read', 'novel' ,'Tantor Media',23 ),
(113, 'Little Women','Sound' ,'An Audible Original Drama By: Louisa May Alcott', 'Coming-of-age' ,'HighBridge' ,24),
(114, 'The 4-Hour Workweek by Tim Ferriss','Sound' ,'for all those tired of postponing their life until retirement', 'Short stories' ,'W. F. Howes Ltd',25));

-----------------------------------Thesis TABLE-----------------------------------------------/

CREATE TABLE Thesis (
    T_ID int PRIMARY KEY, 
    T_Title VARCHAR(40) NOT NULL ,
    T_DESCRIPTION VARCHAR(90),
    AuthorID  INT NOT NULL ,
    T_Location VARCHAR(30),
	Rsrc_ID int ,
      
    CONSTRAINT Thesis_FK 
        FOREIGN KEY(AuthorID)REFERENCES Author(AuthorID)ON DELETE CASCADE,
	CONSTRAINT Thesis_FK2
      FOREIGN KEY(Rsrc_ID) REFERENCES RESOURCES(resourceID)ON DELETE CASCADE
);
----------------- INSERT ------------------------

insert into Thesis ( T_ID , T_Title , T_DESCRIPTION, AuthorID , T_Location,Rsrc_ID)values
((101,'pandemic COVID-19','The effects of the COVID-19 pandemic',23 ,'HEALTH' ,26),
 (102,'DNA evidence in criminal justice','Analysis and research on DNA evidence in criminal justice.',18 ,'Criminal Law' ,27),
 (103,'Racism in schools and colleges','The extent of racism in schools and colleges and the factors affecting',34 ,'social',28 ),
 (104,'Economic development and happiness', 'The effect of economic development on happiness',13 ,'Economic' ,29),
 (105,'The consequences of obesity','The long-term health and psychological impact of obesity',12 ,'HEALTH' ,30),
 (106,'The influence of social media.','The consequences of social media and how it can be used to serve the human being',16 ,'social' ,31));
 

-------------------------------------Journal TABLE-----------------------------------------------/

CREATE TABLE Journal (
    J_ID INT PRIMARY KEY , 
    J_Title VARCHAR(90) NOT NULL ,
    Journal_type VARCHAR(40) NOT NULL
        Check(Journal_type in ('Newspaper','Article')),
    Release_Date date,
    Rsrc_ID int ,
        CONSTRAINT Journal_FK
      FOREIGN KEY(Rsrc_ID) REFERENCES RESOURCES(resourceID)ON DELETE CASCADE
);
----------------- INSERT ------------------------
INSERT INTO Journal (J_ID , J_Title , Journal_type , Release_Date,Rsrc_ID ) values(
( 948,'A Closer Look at Appearance and Social Media' ,'Article'     ,'2022-05-28' ,15 ),
( 496,'Me, My Selfie, and I'                         ,'Article'     ,'2020-03-05' ,16  ),
( 478 ,'The Novel Coronavirus (COVID-2019) Outbreak' ,'Newspaper'   ,'2019-06-09' ,17 ),
( 695,'The Construction of “Critical Thinking”'      ,'Newspaper'   ,'2021-04-28' ,18 ),
( 375,'Treatment of Alcohol Use Disorder'            ,'Article'     , '2016-12-25',19 ));

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
----------------- INSERT ------------------------
 INSERT INTO Fine(Loan_ID ,Fine_DESCRIPTION,Amount,Fine_Status) values
 (( 125, 'delay in rewinding "Harry Potter" book',25,'Paid' ),
( 110,'Delay in returning the book "Crime and Punishment"',25 ,'Unpaid'),
( 116, 'took Lab 302 more than two hours',35,'Paid' ),
( 121,'Destruction of the book "Crime and Punishment"',50 ,'Unpaid'),
( 123,'Delay in returning the book "The Glass Bead Game"',25 ,'Unpaid'));
------------------------------------Room TABLE-----------------------------------------------/

CREATE TABLE Room (
    Room_number int PRIMARY KEY , 
    Room_Type VARCHAR(50) NOT NULL
        Check(Room_Type in('Lab','Reading_Room','Working_Room')) , 
    R_Location VARCHAR(50) , 
    MaxDuration varchar(10),
    Rsrc_ID int ,
        CONSTRAINT Room_FK
        FOREIGN KEY(Rsrc_ID) REFERENCES RESOURCES(resourceID)ON DELETE CASCADE
);
----------------- INSERT ------------------------
INSERT INTO Room(Room_number,Room_Type,R_Location,MaxDuration,Rsrc_ID) values
( 302, 'Lab'         , 'Computer_Collage','2 hour',32),
( 305, 'Reading_Room', 'Scientific_Collage','1 hour',33),
( 204, 'Lab'         , 'Scientific_Collage','2 hour',34),
( 211, 'Reading_Room', 'Computer_Collage','1 hour',35),
( 309, 'Working_Room', 'Computer_Collage','5 hour',36),
( 214, 'Reading_Room', 'Scientific_Collage','1 hour',37);


---------------------------RESOURCES TABLE -----------------------------------------------------------------------
CREATE TABLE RESOURCES (
    resourceID INT,
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
------------------ INSERT------------------------/
INSERT INTO RESOURCES(resourceID,ResourceType,Availabilty,Privileges_LEVEL) values
((1, 'Book'  , 'Available',1),
(2, 'Book'  , 'Available',2),
(3, 'Book'  , 'Unavailable',3),
(4, 'Book'  , 'Available',4),
(5, 'Book'  , 'Available',3),
(6, 'Book'  , 'Available',4),
(7, 'Book'  , 'Unavailable',5),
(8, 'Book'  , 'Available',4),
(9, 'Book'  , 'Available',4),
(10, 'Book'  , 'Available',3),
(11, 'Book'  , 'Available',4),
(12, 'Book'  , 'Available',1),
(13, 'Book'  , 'Unavailable',4),
(14, 'Book'  , 'Available',5),
(15, 'Journal-Article'  , 'Available',3),
(16, 'Journal-Article'  , 'Available',4),
(17, 'Journal-Newspaper'  , 'Available',5),
(18, 'Journal-Newspaper'  , 'Available',4),
(19, 'Journal-Article'  , 'Unavailable',4),
(20, 'Sound-Record'  , 'Available',3),
(21, 'Sound-Record'  , 'Unavailable',4),
(22, 'Video-Record'  , 'Available',4),
(23, 'Sound-Record'  , 'Available',2),
(24, 'Sound-Record'  , 'Unavailable',4),
(25, 'Sound-Record'  , 'Available',3),
(26, 'Thesis'  , 'Unavailable',4),
(27, 'Thesis'  , 'Available',3),
(28, 'Thesis'  , 'Available',5),
(29, 'Thesis'  , 'Available',1),
(30, 'Thesis'  , 'Unavailable',4),
(31, 'Thesis'  , 'Available',4),
(32, 'Room'  , 'Unavailable',1),
(33, 'Room'  , 'Available',3),
(34, 'Room'  , 'Available',1),
(35, 'Room'  , 'Unavailable',4),
(36, 'Room'  , 'Available',2),
(37, 'Room'  , 'Unavailable',4));
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
------------------  INSERT------------------------/
insert into Loan  ( Loan_ID , MemberID , resourceID, Date_Taken_Out , Date_Returned)values
((110,002,0140449132,'2022-10-05', '2022-10-28')
, (111, 011 , 2745122061 ,'2022-08-20', '2022-11-20')
, (113,002, 101 , '2022-10-20', '2022-11-04')
, (115,009 , 305,'2022-10-15	13:10:11', '2022-10-15	13:11:11')
,  (116,011,302,'2022-10-07	08:05:00', '2022-10-07	10:05:00')
, (119,003,106,'2022-10-15', '2022-10-30'),
(121,003,106,'2022-10-15', '2022-10-30'),
(123,004,0805012469,'2022-09-20', '2022-10-30'),
(125,008,1408845660,'2022-09-10', '2022-09-25'));

-------------------------------------Collection TABLE-----------------------------------------------/
CREATE TABLE Collection (
    Collection_Name VARCHAR(40) , 
    Collection_Type  VARCHAR(30) ,
    C_Subject VARCHAR(20),
    ID_of_Items VARCHAR(20) NOT NULL,

    CONSTRAINT Coll_PK 
        PRIMARY KEY(Collection_Name,ID_of_Items)
);
----------------- INSERT ------------------------
INSERT INTO Collection(Collection_Name , Collection_Type,C_Subject,ID_of_Items) values
('Harry Potter','Book','Fantasy',1408845660 ),
('Harry Potter','Book','Fantasy', 1208045660),
('Harry Potter','Book','Fantasy',8638845660 );


