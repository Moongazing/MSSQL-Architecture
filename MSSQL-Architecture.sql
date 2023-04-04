CREATE TABLE Pspec_Type_Enum(
 Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Name_TR VARCHAR(50)
)
INSERT INTO Pspec_Type_Enum(Name,Name_TR)
VALUES ('PSPEC', 'SÜREÇ'),
       ('COLLECTION', 'SÜREÇ GRUBU')
CREATE TABLE Role_Text_Enum(
Id INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(50),
Name_TR VARCHAR(50));
INSERT INTO Role_Text_Enum(Name,Name_TR)
VALUES('MAINTAINER','ÝÞLETMECÝ'),
('MANAGER','YÖNETÝCÝ'),
('OWNER','SAHÝP'),
('PERSONNEL','PERSONEL'),
('SUPPLIER','TEDARÝKÇÝ')
CREATE TABLE Abstract_Objects (
    Id INT IDENTITY(1,1)PRIMARY KEY,
    Name VARCHAR,
    Name_TR VARCHAR,
    Description VARCHAR
);
CREATE TABLE Category_Enum(
 Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Name_TR VARCHAR(50)
)
INSERT INTO Category_Enum(Name,Name_TR)
VALUES ('SUBSYSTEM', NULL),
       ('TERMINATOR', NULL)
CREATE TABLE Class_Enum(
	Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Name_TR VARCHAR(50)
)
INSERT INTO Class_Enum(Name,Name_TR)
VALUES ('CENTER', NULL),
       ('FIELD', NULL),
	   ('PERSONAL', NULL),
	   ('ITS', NULL),
	   ('VEHICLE', NULL),
	   ('SUPPORT', NULL)
CREATE TABLE Service_Packages (
    Short_Name VARCHAR(8) PRIMARY KEY,
    Name VARCHAR,
    Area VARCHAR,
    Description VARCHAR
);
 CREATE TABLE Terminator_Type_Enum (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Name_TR VARCHAR(50)
);
INSERT INTO Terminator_Type_Enum ( Name, Name_TR)
VALUES ( 'SYSTEM', NULL),
       ( 'OTHER SYSTEM', NULL),
       ( 'HUMAN', NULL),
       ( 'ENVIRONMENT', NULL);	
CREATE TABLE Needs (
    SP_Short_Name VARCHAR(8) PRIMARY KEY,
    SP_Need_Order INT,
    Description VARCHAR,
    Id INT IDENTITY(1,1)
    CONSTRAINT FK_Service_Packages
        FOREIGN KEY (SP_Short_Name)
        REFERENCES Service_Packages (Short_Name)
);
CREATE TABLE Physical_Objects (
    Id INT PRIMARY KEY,
    Category INT,
    Class INT,
    Terminator_Type INT,
	CONSTRAINT FK_Physical_Ojbects_Abstract_Objects
		FOREIGN KEY(Id)
		REFERENCES Abstract_Objects(Id),
    CONSTRAINT FK_Physical_Objects_Category_Enum
        FOREIGN KEY (Category)
        REFERENCES Category_Enum (Id),
    CONSTRAINT FK_Physical_Objects_Class_Enum
        FOREIGN KEY (Class)
        REFERENCES Class_Enum (ID),
    CONSTRAINT FK_Physical_Objects_Terminator_Type_Enum
        FOREIGN KEY (Terminator_Type)
        REFERENCES Terminator_Type_Enum (ID)
);
CREATE TABLE Role_Relation_Type_Enum(
Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Name_TR VARCHAR(50));
INSERT INTO Role_Relation_Type_Enum(Name,Name_TR)
VALUES('PSPEC', 'SÜREÇ'),
('Manages', 'Yönetir'),
('System Maintenance Agreement', 'Sistem Bakým Sözleþmesi'),
('Operations Agreement', 'Operasyon Sözleþmesi'),
('Information Exchange and Action Agreement', 'Bilgi Deðiþimi ve Eylem Sözleþmesi'),
('Information Exchange Agreement', 'Bilgi Deðiþimi Sözleþmesi'),
('Warranty', 'Garanti'),
('System Usage Agreement', 'Sistem Kullaným Sözleþmesi'),
('Operates', 'Ýþletir'),
('Expectation of Data Provision', 'Veri Saðlama Beklentisi'),
('Information Provision Agreement', 'Bilgi Saðlama Sözleþmesi'),
('Expectation of Information Provision', 'Bilgi Saðlama Beklentisi')
CREATE TABLE Pspecs (
    Pspec_Code VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(50),
    Name_TR VARCHAR(50),
    Type INT,
    Description VARCHAR(50),
    CONSTRAINT FK_Pspecs_Pspec_Type_Enum
        FOREIGN KEY (Type)
        REFERENCES Pspec_Type_Enum (ID)
);
CREATE TABLE Functional_Objects(

    Name VARCHAR(50) PRIMARY KEY,
    Name_TR VARCHAR(50),
    Physical_Object_Id INT,
    Description VARCHAR(50),
    CONSTRAINT FK_Functional_Objects_Physical_Objects
        FOREIGN KEY (Physical_Object_Id)
        REFERENCES Physical_Objects (Id)
);
CREATE TABLE Requirements (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Functional_Object_Id VARCHAR(50) NOT NULL,
    Fo_Req_Order INT,
    Description VARCHAR(255),
    CONSTRAINT FK_Functional_Objects_Requirements
        FOREIGN KEY (Functional_Object_Id)
        REFERENCES Functional_Objects (Name)
);
CREATE TABLE Information_Flows(
    Name INT PRIMARY KEY,
    Name_TR VARCHAR(50),
	Description VARCHAR(50)
);
CREATE TABLE Data_Flows (
    Name INT PRIMARY KEY,
    Name_TR VARCHAR,
    Information_Flow_Id INT,
    Description VARCHAR,
    FOREIGN KEY (Information_Flow_Id) REFERENCES Information_Flows(Name)
);
CREATE TABLE Enterprise_Objects (
    Id INT PRIMARY KEY,
    Physical_Object_Id INT,
    Role_Text INT,
    CONSTRAINT FK_Corporate_Objects_Abstract_Objects
        FOREIGN KEY (Id)
        REFERENCES Abstract_Objects (ID),
    CONSTRAINT FK_Corporate_Objects_Physical_Objects
        FOREIGN KEY (Id)
        REFERENCES Physical_Objects (ID),
    CONSTRAINT FK_Corporate_Objects_Role_Text_Enum
        FOREIGN KEY (Role_Text)
        REFERENCES Role_Text_Enum (ID)
)
CREATE TABLE Enterprise_Relations (
    Name INT PRIMARY KEY,
    Name_TR VARCHAR,
    Service_Package_Id VARCHAR(8),
    Source_Enterprise_Object_Id Int,
    Destination_Abstract_Object_Id INT,
    Role_Relation_Type INT
    CONSTRAINT FK_Enterprise_Relations_Service_Packages
        FOREIGN KEY (Service_Package_Id)
        REFERENCES Service_Packages (Short_Name),
    CONSTRAINT FK_Enterprise_Relations_ENTERPRISE_OBJECTS
        FOREIGN KEY (Source_Enterprise_Object_Id)
        REFERENCES Enterprise_Objects (Id),
    CONSTRAINT FK_Table_Name_ABSTRACT_OBJECTS
        FOREIGN KEY (Destination_Abstract_Object_Id)
        REFERENCES Abstract_Objects (Id),
    CONSTRAINT FK_Enterprise_Relations_ROLE_RELATION_TYPE_ENUM
        FOREIGN KEY (Role_Relation_Type)
        REFERENCES Role_Relation_Type_Enum (Id)
);
CREATE TABLE Triples (
  Id INT PRIMARY KEY,
  Physical_Object_Id_Src INT,
  Physical_Object_Id_Dst INT,
  Information_Flow_Id INT,
  Description VARCHAR,
 CONSTRAINT FK_Physical_Object_Id_Src FOREIGN KEY (Physical_Object_Id_Src) REFERENCES Physical_Objects(Id),
  CONSTRAINT FK_Physical_Object_Id_Dst FOREIGN KEY (Physical_Object_Id_Dst) REFERENCES Physical_Objects(Id),
  FOREIGN KEY (Information_Flow_Id) REFERENCES Information_Flows(Name)
);
CREATE TABLE Communication_Solutions (
    Name INT PRIMARY KEY,
    Name_TR VARCHAR,
    Triple_Id INT,
    DESCRIPTION VARCHAR,
    Notes VARCHAR,
    Its_Application_Entity VARCHAR,
    Mgmt VARCHAR,
    Facilities VARCHAR,
    Transnet VARCHAR,
    Access VARCHAR,
    Security VARCHAR,
    CONSTRAINT FK_Triple_Id FOREIGN KEY (Triple_Id) REFERENCES Triples(Id)
);


