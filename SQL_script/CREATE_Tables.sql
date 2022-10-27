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

------------------------------Members TABLE----------------------------------------------------------
CREATE TABLE Members (
    Member_ID INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    PIN VARCHAR(15)  ,
    First_Name VARCHAR(20) NOT NULL ,
    Last_Name VARCHAR(20),
    Member_Type VARCHAR(30) NOT NULL 
        Check(Member_Type in('Faculty','Postgraduate_Student','Undergraduate_Student','Staff','Community_Patrons')),
    Email VARCHAR(40) 
        Check(Email LIKE '%@qu.edu.sa'),

    CONSTRAINT Member_FK 
        FOREIGN KEY(Member_Type) REFERENCES Privilege(privilegesName)

);

-----------------------MEMBER_CALL_NUMBER TABLE ----------------------------------------------------------
CREATE TABLE MEMBER_CALL_NUMBER(
	Call_Number numeric(10) PRIMARY KEY,
	Member_ID INT(10) REFERENCES Members(Member_ID)
);

------------------------------Member_addres TABLE ----------------------------------------------------------
create table member_addres(
member_Id varchar(10), 
zip_code varchar(5) primary key,
city varchar(10),
Region varchar(10),

CONSTRAINT addres_FK 
        FOREIGN KEY(member_Id) REFERENCES members(member_Id)
);

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

-------------------------------------Author TABLE---------------------------------------------------
CREATE TABLE Author (
    AuthorID INT  PRIMARY KEY, 
    Author_Name  VARCHAR(30) NOT NULL,
    Year_Of_Birth numeric(4)
);

-----------------------------Author Call Number TABLE---------------------------------------------------
CREATE TABLE Author_Call_Number (
    Call_Number numeric(10) PRIMARY KEY ,
    AuthorID INT REFERENCES Author(AuthorID)
);

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
   
    Rsrc_ID varchar(10) Not Null,

    CONSTRAINT BOOK_FK1 
        FOREIGN KEY(AuthorID)REFERENCES Author(AuthorID)ON DELETE CASCADE ,
    CONSTRAINT BOOK_FK2 
        FOREIGN KEY(Rsrc_ID)REFERENCES Resources (resourceID )ON DELETE CASCADE 
	
);
------------------------------------TABLE Book_language ------------------------------------------
CREATE TABLE Book_language(
	B_Language VARCHAR(15) ,
 	ISBN  numeric(13) REFERENCES Book(ISBN) 
 );

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
    MaxDuration varchar(10),
    Rsrc_ID int ,
        CONSTRAINT Room_FK
        FOREIGN KEY(Rsrc_ID) REFERENCES RESOURCES(resourceID)ON DELETE CASCADE
);

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
    Collection_Name VARCHAR(40) PRIMARY KEY , 
    Collection_Type  VARCHAR(30) ,
    C_Subject VARCHAR(20)

);

-------------------------------------Collection_ID TABLE-----------------------------------------------/
CREATE TABLE Collection_ID (
  Collection_Name VARCHAR(40) , 
  ID_of_Items VARCHAR(20) NOT NULL,
  
    CONSTRAINT CName_FK 
        FOREIGN KEY(Collection_Name)REFERENCES Collection(Collection_Name)ON DELETE CASCADE,
    	
    CONSTRAINT Coll_FK 
        FOREIGN KEY(ID_of_Items)REFERENCES RESOURCES(resourceID)ON DELETE CASCADE     
  );      

