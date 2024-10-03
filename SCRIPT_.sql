
USE master
DROP DATABASE IF  EXISTS FineFlierDB

---------- creare baza de date --------

create database FineFlierDB
on primary
(
name = FineFlierDBData1,
filename = 'D:\SabinDB\FineFlierDB_data1.mdf',
size = 10 MB,
maxsize = unlimited,
filegrowth = 1GB
),
(
name = FineFlierDBData2,
filename = 'D:\SabinDB\FineFlierDB_data2.ndf',
size = 10 MB,
maxsize = unlimited,
filegrowth = 1GB
),
( 
name = FineFlierDBData3,
filename = 'D:\SabinDB\FineFlierDB_data3.ndf',
size = 10 MB,
maxsize = unlimited,
filegrowth = 1GB
)

LOG on
(
name = FineFlierDBLog1,
filename = 'D:\SbinDB\FineFlierDB_log1.ldf',
size = 10 MB,
maxsize = unlimited,
filegrowth = 1GB
),
(
name = FineFlierDBLog2,
filename = 'D:\SabinDB\FineFlierDB_log2.ldf',
size = 10 MB,
maxsize = unlimited,
filegrowth = 1GB
)
GO

 
 use FineFlierDB




-------------creare tabele-------------------


if OBJECT_ID('CompaniiAeriene', 'U') is not null
	drop table CompaniiAeriene
-- Tabela pentru informații despre companii aeriene
CREATE TABLE CompaniiAeriene (
    ID_Companie INT PRIMARY KEY,
    NumeCompanie NVARCHAR(100),
    CodIATA NVARCHAR(3) UNIQUE,
    CodICAO NVARCHAR(4) UNIQUE
);


if OBJECT_ID('Destinatii', 'U') is not null
	drop table Destinatii
-- Tabela pentru informații despre destinații
CREATE TABLE Destinatii (
    ID_Destinatie INT PRIMARY KEY,
    OrasDestinatie NVARCHAR(100),
    TaraDestinatie NVARCHAR(100),
    AeroportDestinatie NVARCHAR(100) UNIQUE
);


if OBJECT_ID('Zboruri', 'U') is not null
	drop table Zboruri
-- Tabela pentru informații despre zboruri
CREATE TABLE Zboruri (
    ID_Zbor INT PRIMARY KEY,
    CompanieID INT,
    DestinatieID INT,
    DataPlecare DATE,
    OraPlecare TIME,
    FOREIGN KEY (CompanieID) REFERENCES CompaniiAeriene(ID_Companie),
    FOREIGN KEY (DestinatieID) REFERENCES Destinatii(ID_Destinatie)
);

if OBJECT_ID('ProgramZboruri', 'U') is not null
	drop table ProgramZboruri
-- Tabela pentru programul fiecarui zbor
CREATE TABLE ProgramZboruri (
    ID_ProgramZbor INT PRIMARY KEY,
    ZborID INT,
    OraPlecareProgram TIME,
    OraSosireProgram TIME,
    PoartaImbarcare NVARCHAR(10),
    FOREIGN KEY (ZborID) REFERENCES Zboruri(ID_Zbor)
);

if OBJECT_ID('Pasageri', 'U') is not null
	drop table Pasageri
-- Tabela pentru informații despre pasageri
CREATE TABLE Pasageri (
    ID_Pasager INT PRIMARY KEY,
    Nume NVARCHAR(50) NOT NULL,
    Prenume NVARCHAR(50) NOT NULL,
    DataNasterii DATE NOT NULL,
    Gen NVARCHAR(10)
);


if OBJECT_ID('Bilete', 'U') is not null
	drop table Bilete
-- Tabela pentru informații despre bilete
CREATE TABLE Bilete (
    ID_Bilet INT PRIMARY KEY,
    ZborID INT,
    PasagerID INT,
    Clasa NVARCHAR(20),
    Pret MONEY,
    FOREIGN KEY (ZborID) REFERENCES Zboruri(ID_Zbor),
    FOREIGN KEY (PasagerID) REFERENCES Pasageri(ID_Pasager)
);



if OBJECT_ID('Plecari', 'U') is not null
	drop table Plecari
-- Tabela pentru informații despre plecări
CREATE TABLE Plecari (
    ID_Plecare INT PRIMARY KEY,
    ZborID INT,
    DataPlecare DATETIME,
    PoartaPlecare NVARCHAR(10),
    FOREIGN KEY (ZborID) REFERENCES Zboruri(ID_Zbor)
);


if OBJECT_ID('Sosiri', 'U') is not null
	drop table Sosiri
-- Tabela pentru informații despre sosiri
CREATE TABLE Sosiri (
    ID_Sosire INT PRIMARY KEY,
    ZborID INT,
    DataSosire DATETIME,
    PoartaSosire NVARCHAR(10),
    FOREIGN KEY (ZborID) REFERENCES Zboruri(ID_Zbor)
);


if OBJECT_ID('Bagaje', 'U') is not null
	drop table Bagaje
-- Tabela pentru informații despre bagaje
CREATE TABLE Bagaje (
    ID_Bagaj INT PRIMARY KEY,
    PasagerID INT,
    Greutate INT,
    Dimensiuni NVARCHAR(50),
    Pierdut BIT,
    FOREIGN KEY (PasagerID) REFERENCES Pasageri(ID_Pasager)
);


if OBJECT_ID('PersonalAeroport', 'U') is not null
	drop table PersonalAeroport
-- Tabela pentru informații despre personalul aeroportului
CREATE TABLE PersonalAeroport (
    ID_Angajat INT PRIMARY KEY,
    Nume NVARCHAR(50),
    Prenume NVARCHAR(50),
    Functie NVARCHAR(50)
);


if OBJECT_ID('PozitiiParcare', 'U') is not null
	drop table PozitiiParcare
-- Tabela pentru informații despre pozițiile de parcare ale aeronavelor
CREATE TABLE PozitiiParcare (
    ID_Pozitie INT PRIMARY KEY,
    NumarPozitie INT,
    Terminal NVARCHAR(20),
    Disponibil BIT
);


if OBJECT_ID('EchipajeZbor', 'U') is not null
	drop table EchipajeZbor
-- Tabela pentru informații despre echipajele de zbor
CREATE TABLE EchipajeZbor (
    ID_Echipaj INT PRIMARY KEY,
    PilotID INT,
    CopilotID INT,
    InsotitorID INT,
    FOREIGN KEY (PilotID) REFERENCES PersonalAeroport(ID_Angajat),
    FOREIGN KEY (CopilotID) REFERENCES PersonalAeroport(ID_Angajat),
    FOREIGN KEY (InsotitorID) REFERENCES PersonalAeroport(ID_Angajat)
);


if OBJECT_ID('InchirieriAuto', 'U') is not null
	drop table InchirieriAuto
-- Tabela pentru informații despre închirieri auto
CREATE TABLE InchirieriAuto (
    ID_Inchiriere INT PRIMARY KEY,
    Companie NVARCHAR(100),
    DataInchiriere DATETIME,
    DataReturnare DATETIME,
    Cost DECIMAL(10, 2)
);


if OBJECT_ID('AgentiVanzari', 'U') is not null
	drop table AgentiVanzari
-- Tabela pentru informații despre agenții de vânzări la bilete
CREATE TABLE AgentiVanzari (
    ID_Agent INT PRIMARY KEY,
    Nume NVARCHAR(50),
    Prenume NVARCHAR(50),
    CompanieID INT,
    FOREIGN KEY (CompanieID) REFERENCES CompaniiAeriene(ID_Companie)
);


if OBJECT_ID('ReclamatiiPasageri', 'U') is not null
	drop table ReclamatiiPasageri
-- Tabela pentru informații despre reclamații pasageri
CREATE TABLE ReclamatiiPasageri (
    ID_Reclamatie INT PRIMARY KEY,
    PasagerID INT,
    Descriere TEXT DEFAULT 'Zbor Anulat',
    FOREIGN KEY (PasagerID) REFERENCES Pasageri(ID_Pasager)
);


if OBJECT_ID('MagazineAeroport', 'U') is not null
	drop table MagazineAeroport
-- Tabela pentru informații despre magazinele din aeroport
CREATE TABLE MagazineAeroport (
    ID_Magazin INT PRIMARY KEY,
    NumeMagazin NVARCHAR(100),
    Locatie NVARCHAR(100),
    Program NVARCHAR(100)
);


if OBJECT_ID('RestauranteAeroport', 'U') is not null
	drop table RestauranteAeroport
-- Tabela pentru informații despre restaurantele din aeroport
CREATE TABLE RestauranteAeroport (
    ID_Restaurant INT PRIMARY KEY,
    NumeRestaurant NVARCHAR(100),
    TipBucatarie NVARCHAR(100),
    Locatie NVARCHAR(100),
    Program DATE
);

if OBJECT_ID('FeedbackEvaluariZboruri', 'U') is not null
	drop table FeedbackEvaluariZboruri
-- Tabela pentru gestionartea feedback-urilor fiecarui zbor
CREATE TABLE FeedbackEvaluariZboruri (
    ID_Feedback INT PRIMARY KEY,
    PasagerID INT,
    ZborID INT,
    DataFeedback DATE,
    Comentariu TEXT,
    Nota INT,
    FOREIGN KEY (PasagerID) REFERENCES Pasageri(ID_Pasager),
    FOREIGN KEY (ZborID) REFERENCES Zboruri(ID_Zbor)
);


if OBJECT_ID('ServiciiAeroport', 'U') is not null
	drop table ServiciiAeroport
-- Tabela pentru informații despre serviciile din aeroport
CREATE TABLE ServiciiAeroport (
    ID_Serviciu INT PRIMARY KEY,
    NumeServiciu NVARCHAR(100),
    Descriere TEXT,
    Pret DECIMAL(10, 2)
);

if OBJECT_ID('SistemSecuritateAeroport', 'U') is not null
	drop table SistemSecuritateAeroport
-- Tabela pentru informații despre sistemul de securitate al aeroportului
CREATE TABLE SistemSecuritateAeroport (
    ID_SistemSecuritate INT PRIMARY KEY,
    TipSistem NVARCHAR(100),
    NivelSecuritate INT,
    Activ BIT
);

if OBJECT_ID('PersonalContact', 'U') is not null
    drop table PersonalContact
	-- Tabela pentru perosnale de contact a aeroportului
CREATE TABLE PersonalContact (
    ID_Contact INT PRIMARY KEY,
    AngajatID INT,
    TipContact NVARCHAR(50),
    DetaliiContact NVARCHAR(100),
    FOREIGN KEY (AngajatID) REFERENCES PersonalAeroport(ID_Angajat)
);

if OBJECT_ID('AsignariEchipajeZbor', 'U') is not null
    drop table AsignariEchipajeZbor
	--Tabela care gestionează asignările echipajelor de zbor pentru fiecare zbor,
CREATE TABLE AsignariEchipajeZbor (
    ID_Asignare INT PRIMARY KEY,
    EchipajID INT,
    ZborID INT,
    DataAsignare DATE,
    FOREIGN KEY (EchipajID) REFERENCES EchipajeZbor(ID_Echipaj),
    FOREIGN KEY (ZborID) REFERENCES Zboruri(ID_Zbor)
);

if OBJECT_ID('UrmarireBagaje', 'U') is not null
    drop table UrmarireBagaje
	--Tabela pentru gestionarea urmaririi bagajelor
CREATE TABLE UrmarireBagaje (
    ID_Urmarire INT PRIMARY KEY,
    BagajID INT,
    Status NVARCHAR(50),
    DataActualizare DATETIME,
    Locatie NVARCHAR(100),
    FOREIGN KEY (BagajID) REFERENCES Bagaje(ID_Bagaj)
);

if OBJECT_ID('TranzactiiInchirieriAuto', 'U') is not null
    drop table TranzactiiInchirieriAuto
	--Tabela pentru gestionarea tranzactiilor de inchiriere auto
CREATE TABLE TranzactiiInchirieriAuto (
    ID_Tranzactie INT PRIMARY KEY,
    InchiriereID INT,
    PasagerID INT,
    DataTranzactie DATETIME,
    FOREIGN KEY (InchiriereID) REFERENCES InchirieriAuto(ID_Inchiriere),
    FOREIGN KEY (PasagerID) REFERENCES Pasageri(ID_Pasager)
);






 use FineFlierDB
 --118
 ALTER TABLE CompaniiAeriene
ADD AdresaSediuCentral NVARCHAR(100);

--119
ALTER TABLE Destinatii
ADD CodTelefon NVARCHAR(20);
--120
ALTER TABLE PersonalAeroport
ADD DataAngajare DATETIME;
--121
ALTER TABLE PersonalAeroport
ADD CONSTRAINT CNS_Functii CHECK (Functie IN ('Pilot', 'Mecanic', 'Inginer', 'Stuard', 'Sanitar', 'Controlor', 'Casier', 'Ofiter Vamal', 'Politist Frontiera'));

--122
ALTER TABLE Pasageri
ADD CNP NVARCHAR(13) UNIQUE NOT NULL,
    Email NVARCHAR(100),
    NumarTelefon NVARCHAR(15),
    Adresa NVARCHAR(100);
	--123
ALTER TABLE Pasageri
ADD CONSTRAINT CHK_CNP CHECK (ISNUMERIC(CNP) = 1 AND LEN(CNP) = 13);

--124
ALTER TABLE Pasageri
ADD Adresa NVARCHAR(100),
    NumarTelefon NVARCHAR(20),
    Email NVARCHAR(100);

--125
ALTER TABLE CompaniiAeriene
ADD AdresaSediuCentral NVARCHAR(100);

--126
ALTER TABLE Destinatii
ADD CodTelefon NVARCHAR(20);
--127
ALTER TABLE PersonalAeroport
ADD DataAngajare DATETIME;
--128
ALTER TABLE EchipajeZbor
ADD TipAeronava NVARCHAR(50);
--129
ALTER TABLE MagazineAeroport
ADD NumarTelefon NVARCHAR(20);
--130
ALTER TABLE CompaniiAeriene
  ADD CONSTRAINT CHK_CodIATA_Length CHECK (LEN(CodIATA) = 3);
  --131
ALTER TABLE Zboruri
 ADD DurataZbor INT;
 --132
ALTER TABLE Zboruri
 ADD CONSTRAINT CHK_DurataZbor_Positive CHECK (DurataZbor > 0);
 --133
ALTER TABLE Plecari
ADD CONSTRAINT CHK_PoartaPlecare_Length CHECK (LEN(PoartaPlecare) <= 10);
--134
ALTER TABLE Sosiri
ADD CONSTRAINT CHK_PoartaSosire_Length CHECK (LEN(PoartaSosire) <= 10);
--135
ALTER TABLE CompaniiAeriene
  DROP CONSTRAINT CHK_CodICAO_Lenght
  --136
ALTER TABLE PersonalAeroport
 ADD CONSTRAINT CNS_Functii CHECK (Functie IN('Pilot','Mecanic','Inginer','Stuard','Sanitar','Controlor','Casier','Ofiter Vamal','Plotist Frontiera'));
 --137
 ALTER TABLE Pasageri
 ADD CNP  NVARCHAR(20) UNIQUE NOT NULL;
 --138
 ALTER TABLE Pasageri
 ADD CONSTRAINT CHK_CNP CHECK (isnumeric(CNP)=1 AND len(CNP)=13)
 --139
 ALTER TABLE Pasageri
ADD CNP NVARCHAR(13) UNIQUE,
    Email NVARCHAR(100),
    NumarTelefon NVARCHAR(15),
    Adresa NVARCHAR(100);

--140 Inserare in tabela Destinatii
 INSERT INTO Destinatii (ID_Destinatie, OrasDestinatie, TaraDestinatie, AeroportDestinatie)
VALUES 
    (1, 'Paris', 'Franța', 'Charles de Gaulle Airport'),
    (2, 'New York', 'SUA', 'John F. Kennedy International Airport'),
    (3, 'London', 'Marea Britanie', 'Heathrow Airport'),
    (4, 'Tokyo', 'Japonia', 'Narita International Airport'),
    (5, 'Dubai', 'Emiratele Arabe Unite', 'Dubai International Airport'),
    (6, 'Los Angeles', 'SUA', 'Los Angeles International Airport'),
    (7, 'Singapore', 'Singapore', 'Singapore Changi Airport'),
    (8, 'Hong Kong', 'Hong Kong', 'Hong Kong International Airport'),
    (9, 'Sydney', 'Australia', 'Sydney Airport'),
    (10, 'Frankfurt', 'Germania', 'Frankfurt Airport'),
    (11, 'Istanbul', 'Turcia', 'Istanbul Airport'),
    (12, 'Amsterdam', 'Olanda', 'Amsterdam Airport Schiphol'),
    (13, 'Toronto', 'Canada', 'Toronto Pearson International Airport'),
    (14, 'Moscow', 'Rusia', 'Sheremetyevo International Airport'),
    (15, 'Barcelona', 'Spania', 'Barcelona–El Prat Airport'),
    (16, 'Rome', 'Italia', 'Leonardo da Vinci–Fiumicino Airport'),
    (17, 'Seoul', 'Coreea de Sud', 'Incheon International Airport'),
    (18, 'Munich', 'Germania', 'Munich Airport'),
    (19, 'Beijing', 'China', 'Beijing Capital International Airport'),
    (20, 'Zurich', 'Elveția', 'Zurich Airport');



  --141 Inserare in tabela CompaniiAeriene
  INSERT INTO CompaniiAeriene (ID_Companie, NumeCompanie, CodIATA, CodICAO)
VALUES 
    (1, 'Lufthansa', 'LH', 'DLH', 'Frankfurt, Germania'),
    (2, 'Air France', 'AF', 'AFR', 'Paris, Franța'),
    (3, 'British Airways', 'BA', 'BAW', 'Londra, Regatul Unit'),
    (4, 'Delta Air Lines', 'DL', 'DAL', 'Atlanta, SUA'),
    (5, 'Emirates', 'EK', 'UAE', 'Dubai, Emiratele Arabe Unite'),
    (6, 'American Airlines', 'AA', 'AAL', 'Fort Worth, SUA'),
    (7, 'Qatar Airways', 'QR', 'QTR', 'Doha, Qatar'),
    (8, 'Singapore Airlines', 'SQ', 'SIA', 'Singapore'),
    (9, 'Cathay Pacific', 'CX', 'CPA', 'Hong Kong'),
    (10, 'Qantas', 'SF', 'QFA', 'Sydney, Australia'),
    (11, 'Turkish Airlines', 'TK', 'THY', 'Istanbul, Turcia'),
    (12, 'Etihad Airways', 'EY', 'ETD', 'Abu Dhabi, Emiratele Arabe Unite'),
    (13, 'KLM Royal Dutch Airlines', 'KL', 'KLM', 'Amstelveen, Olanda'),
    (14, 'Virgin Atlantic Airways', 'VS', 'VIR', 'Crawley, Regatul Unit'),
    (15, 'Swiss International Air Lines', 'LX', 'SWR', 'Bazel, Elveția'),
    (16, 'Air Canada', 'AC', 'ACA', 'Montreal, Canada'),
    (17, 'Aeroflot', 'SU', 'AFL', 'Moscova, Rusia'),
    (18, 'QantasLink', 'QF', 'QLK', 'Sydney, Australia'),
    (19, 'Alaska Airlines', 'AS', 'ASA', 'Seattle, SUA'),
    (20, 'Iberia', 'IB', 'IBE', 'Madrid, Spania');

	--142 Update in Companii Aeriene (adaugarea ulterioara a campului "AdresaSediuCentral")
	UPDATE CompaniiAeriene
SET AdresaSediuCentral = 
    CASE ID_Companie
        WHEN 1 THEN 'Frankfurt, Germania'
        WHEN 2 THEN 'Paris, Franța'
        WHEN 3 THEN 'Londra, Regatul Unit'
        WHEN 4 THEN 'Atlanta, SUA'
        WHEN 5 THEN 'Dubai, Emiratele Arabe Unite'
        WHEN 6 THEN 'Fort Worth, SUA'
        WHEN 7 THEN 'Doha, Qatar'
        WHEN 8 THEN 'Singapore'
        WHEN 9 THEN 'Hong Kong'
        WHEN 10 THEN 'Sydney, Australia'
        WHEN 11 THEN 'Istanbul, Turcia'
        WHEN 12 THEN 'Abu Dhabi, Emiratele Arabe Unite'
        WHEN 13 THEN 'Amstelveen, Olanda'
        WHEN 14 THEN 'Crawley, Regatul Unit'
        WHEN 15 THEN 'Bazel, Elveția'
        WHEN 16 THEN 'Montreal, Canada'
        WHEN 17 THEN 'Moscova, Rusia'
        WHEN 18 THEN 'Sydney, Australia'
        WHEN 19 THEN 'Seattle, SUA'
        WHEN 20 THEN 'Madrid, Spania'
    END;


	--143 Inserare in tabela Pasageri
	INSERT INTO Pasageri (ID_Pasager, Nume, Prenume, DataNasterii, Gen, CNP, Email, NumarTelefon, Adresa)
VALUES
    (1, 'Popescu', 'Ion', '1990-01-15', 'Masculin', '1900115012345', 'ion.popescu@example.com', '0721123456', 'Str. Florilor nr. 10, București'),
    (2, 'Ionescu', 'Maria', '1985-05-20', 'Feminin', '2850520012345', 'maria.ionescu@example.com', '0732123456', 'Str. Libertății nr. 15, Cluj-Napoca'),
    (3, 'Popa', 'Mihai', '1978-09-10', 'Masculin', '1780910012345', 'mihai.popa@example.com', '0743123456', 'Str. Mihai Viteazu nr. 20, Timișoara'),
    (4, 'Georgescu', 'Ana', '2000-03-03', 'Feminin', '2000303123456', 'ana.georgescu@example.com', '0754123456', 'Bd. Republicii nr. 30, Iași'),
    (5, 'Constantin', 'Elena', '1982-11-25', 'Feminin', '1821125123456', 'elena.constantin@example.com', '0765123456', 'Aleea Trandafirilor nr. 5, Constanța'),
    (6, 'Radu', 'Adrian', '1995-07-12', 'Masculin', '1950712012345', 'adrian.radu@example.com', '0776123456', 'Bd. Independenței nr. 25, Brașov'),
    (7, 'Dumitru', 'Andreea', '1973-04-08', 'Feminin', '7300408123456', 'andreea.dumitru@example.com', '0787123456', 'Str. Păcii nr. 40, Galați'),
    (8, 'Gheorghiu', 'Alex', '1998-12-30', 'Masculin', '9811230123456', 'alex.gheorghiu@example.com', '0798123456', 'Bd. Unirii nr. 12, Sibiu'),
    (9, 'Stan', 'Diana', '1992-08-18', 'Feminin', '9200818123456', 'diana.stan@example.com', '0719123456', 'Str. Victoriei nr. 9, Timișoara'),
    (10, 'Stoica', 'Cristian', '1987-06-22', 'Masculin', '8700622123456', 'cristian.stoica@example.com', '0720123456', 'Bd. Revoluției nr. 87, Cluj-Napoca'),
    (11, 'Smith', 'John', '1988-07-15', 'Masculin', '8807151234567', 'john.smith@example.com', '0712345678', '123 Main Street, New York, USA'),
    (12, 'Johnson', 'Emily', '1995-04-20', 'Feminin', '9504202345678', 'emily.johnson@example.com', '0723456789', '456 Maple Avenue, Los Angeles, USA'),
    (13, 'Chen', 'Wei', '1990-09-10', 'Masculin', '9009103456789', 'wei.chen@example.com', '0734567890', '789 Oak Street, Beijing, China'),
    (14, 'Kim', 'Soo-Min', '1983-06-03', 'Feminin', '8306034567890', 'soomin.kim@example.com', '0745678901', '101 Cherry Lane, Seoul, South Korea'),
    (15, 'Garcia', 'Luis', '1975-11-22', 'Masculin', '7511225678901', 'luis.garcia@example.com', '0756789012', '456 Elm Street, Madrid, Spain'),
    (16, 'Tanaka', 'Yuki', '1992-09-10', 'Feminin', '9209106789012', 'yuki.tanaka@example.com', '0767890123', '789 Pine Street, Tokyo, Japan'),
    (17, 'Singh', 'Raj', '1988-04-25', 'Masculin', '8804257890123', 'raj.singh@example.com', '0778901234', '123 Cedar Street, Mumbai, India'),
    (18, 'Silva', 'Maria', '1998-03-18', 'Feminin', '9803188901234', 'maria.silva@example.com', '0789012345', '456 Birch Street, Rio de Janeiro, Brazil'),
    (19, 'Müller', 'Hans', '1986-08-12', 'Masculin', '8608129012345', 'hans.muller@example.com', '0790123456', '789 Walnut Street, Berlin, Germany'),
    (20, 'Nguyen', 'Linh', '1978-12-30', 'Feminin', '7812300123456', 'linh.nguyen@example.com', '0701234567', '101 Oak Street, Hanoi, Vietnam'),
    (21, 'Smith', 'John', '1978-05-10', 'Masculin', '7805101234567', 'john.smith@example.com', '0712345678', '123 Main Street, New York, USA'),
    (22, 'Garcia', 'Maria', '1992-08-25', 'Feminin', '9208252345678', 'maria.garcia@example.com', '0723456789', '456 Oak Avenue, Los Angeles, USA'),
    (23, 'Kim', 'Ji-Soo', '1985-03-17', 'Feminin', '8503173456789', 'jisoo.kim@example.com', '0734567890', '789 Elm Street, Seoul, South Korea'),
    (24, 'Müller', 'Thomas', '1980-12-03', 'Masculin', '8012034567890', 'thomas.muller@example.com', '0745678901', '101 Walnut Street, Berlin, Germany'),
    (25, 'López', 'Carlos', '1977-06-20', 'Masculin', '7706205678901', 'carlos.lopez@example.com', '0756789012', '123 Cedar Street, Madrid, Spain'),
    (26, 'Chen', 'Li', '1990-09-12', 'Feminin', '9009126789012', 'li.chen@example.com', '0767890123', '456 Pine Street, Shanghai, China'),
    (27, 'Kovács', 'Anna', '1983-02-28', 'Feminin', '8302287890123', 'anna.kovacs@example.com', '0778901234', '789 Oak Street, Budapest, Hungary'),
    (28, 'Nakamura', 'Takashi', '1995-07-05', 'Masculin', '9507058901234', 'takashi.nakamura@example.com', '0789012345', '101 Maple Street, Tokyo, Japan'),
    (29, 'Petrov', 'Ivan', '1979-11-18', 'Masculin', '7911189012345', 'ivan.petrov@example.com', '0790123456', '123 Elm Street, Moscow, Russia'),
    (30, 'Silva', 'Ana', '1987-04-22', 'Feminin', '8704220123456', 'ana.silva@example.com', '0701234567', '456 Cherry Street, Sao Paulo, Brazil'),
    (31, 'Chung', 'Sung-Hoon', '1988-12-15', 'Masculin', '8812153456789', 'sung-hoon.chung@example.com', '0701234567', '123 Oak Street, Seoul, South Korea'),
    (32, 'González', 'Luis', '1975-03-10', 'Masculin', '7503104567890', 'luis.gonzalez@example.com', '0701234567', '456 Pine Street, Mexico City, Mexico'),
    (33, 'Andersen', 'Mette', '1993-06-20', 'Feminin', '9306205678901', 'mette.andersen@example.com', '0701234567', '789 Elm Street, Copenhagen, Denmark'),
    (34, 'Martínez', 'María', '1981-09-25', 'Feminin', '8109256789012', 'maria.martinez@example.com', '0701234567', '101 Walnut Street, Madrid, Spain'),
    (35, 'Wang', 'Wei', '1976-01-05', 'Masculin', '7601057890123', 'wei.wang@example.com', '0701234567', '123 Cedar Street, Beijing, China'),
    (36, 'Kováč', 'Ján', '1990-04-30', 'Masculin', '9004308901234', 'jan.kovac@example.com', '0701234567', '456 Maple Street, Bratislava, Slovakia'),
    (37, 'Ramos', 'Sofía', '1984-07-12', 'Feminin', '8407129012345', 'sofia.ramos@example.com', '0701234567', '789 Oak Street, Madrid, Spain'),
    (38, 'Fischer', 'Hans', '1977-10-08', 'Masculin', '7710080123456', 'hans.fischer@example.com', '0701234567', '101 Pine Street, Berlin, Germany'),
    (39, 'Nguyen', 'Thi', '1989-02-17', 'Feminin', '8902171234567', 'thi.nguyen@example.com', '0701234567', '123 Cherry Street, Hanoi, Vietnam'),
    (40, 'Smith', 'David', '1982-05-22', 'Masculin', '8205222345678', 'david.smith@example.com', '0701234567', '456 Elm Street, Sydney, Australia'),
    (41, 'Wong', 'Li', '1980-02-14', 'Feminin', '8002143456789', 'li.wong@example.com', '0712345678', '456 Pine Street, Hong Kong, China'),
    (42, 'Kawamura', 'Takashi', '1977-10-05', 'Masculin', '7710054567890', 'takashi.kawamura@example.com', '0723456789', '789 Cherry Street, Tokyo, Japan'),
    (43, 'Martinez', 'Juan', '1991-03-28', 'Masculin', '9103285678901', 'juan.martinez@example.com', '0734567890', '101 Maple Street, Madrid, Spain'),
    (44, 'Dubois', 'Marie', '1984-06-17', 'Feminin', '8406176789012', 'marie.dubois@example.com', '0745678901', '123 Oak Street, Paris, France'),
    (45, 'Gupta', 'Ananya', '1996-09-22', 'Feminin', '9609227890123', 'ananya.gupta@example.com', '0756789012', '456 Pine Street, Mumbai, India'),
    (46, 'Santos', 'Gabriel', '1989-11-30', 'Masculin', '8911308901234', 'gabriel.santos@example.com', '0767890123', '789 Cedar Street, Sao Paulo, Brazil'),
    (47, 'Ferrari', 'Giulia', '1982-04-08', 'Feminin', '8204089012345', 'giulia.ferrari@example.com', '0778901234', '101 Elm Street, Rome, Italy'),
    (48, 'Lee', 'Ji-Hoon', '1976-07-25', 'Masculin', '7607250123456', 'jihoon.lee@example.com', '0789012345', '123 Walnut Street, Seoul, South Korea'),
    (49, 'Andersen', 'Lars', '1990-01-12', 'Masculin', '9001121234567', 'lars.andersen@example.com', '0790123456', '456 Pine Street, Copenhagen, Denmark'),
    (50, 'Ivanova', 'Elena', '1973-08-30', 'Feminin', '7308302345678', 'elena.ivanova@example.com', '0701234567', '789 Maple Street, Moscow, Russia');

	--144
	INSERT INTO FeedbackEvaluariZboruri (ID_Feedback, PasagerID, ZborID, DataFeedback, Comentariu, Nota)
VALUES
(1, 1, 1, '2024-03-20', 'Zbor excelent!', 5),
(2, 2, 2, '2024-03-21', 'Serviciu bun, dar zborul a fost întârziat.', 4),
(3, 3, 3, '2024-03-22', 'Personalul a fost foarte amabil.', 5),
(4, 4, 4, '2024-03-23', 'Zbor confortabil, dar mâncarea a fost proastă.', 3),
(5, 5, 5, '2024-03-24', 'Totul a fost în regulă.', 4),
(6, 6, 6, '2024-03-25', 'Scaunul a fost incomod.', 2),
(7, 7, 7, '2024-03-26', 'Zborul a fost anulat fără nicio notificare prealabilă.', 1),
(8, 8, 8, '2024-03-27', 'Personalul a fost nepoliticos.', 2),
(9, 9, 9, '2024-03-28', 'Zborul a fost bun, dar sistemul de divertisment nu a funcționat.', 3),
(10, 10, 10, '2024-03-29', 'Am avut o experiență excelentă cu această companie aeriană.', 5);



	-- 145		Inserare în tabela Zboruri
INSERT INTO Zboruri (ID_Zbor, CompanieID, DestinatieID, DataPlecare, OraPlecare, DurataZbor)
VALUES
    (1, 1, 1, '2024-03-20', '08:00:00', 270),
    (2, 2, 3, '2024-03-21', '10:30:00', 135),
    (3, 3, 2, '2024-03-22', '12:45:00', 180),
    (4, 4, 5, '2024-03-23', '15:15:00', 345),
    (5, 5, 4, '2024-03-24', '17:45:00', 90),
    (6, 6, 6, '2024-03-25', '20:00:00', 495),
    (7, 7, 7, '2024-03-26', '22:30:00', 390),
    (8, 8, 8, '2024-03-27', '05:00:00', 225),
    (9, 9, 9, '2024-03-28', '07:15:00', 240),
    (10, 10, 10, '2024-03-29', '09:45:00', 120),
	(11, 1, 2, '2024-03-30', '08:30:00', 180),
    (12, 2, 4, '2024-03-31', '11:00:00', 120),
    (13, 3, 6, '2024-04-01', '13:15:00', 300),
    (14, 4, 8, '2024-04-02', '16:45:00', 240),
    (15, 5, 10, '2024-04-03', '19:00:00', 180),
    (16, 6, 1, '2024-04-04', '21:30:00', 360),
    (17, 7, 3, '2024-04-05', '23:45:00', 240),
    (18, 8, 5, '2024-04-06', '06:15:00', 300),
    (19, 9, 7, '2024-04-07', '08:30:00', 180),
    (20, 10, 9, '2024-04-08', '10:45:00', 240);


	-- 146		Inserturi pentru ProgramZboruri
INSERT INTO ProgramZboruri (ID_ProgramZbor, ZborID, OraPlecareProgram, OraSosireProgram, PoartaImbarcare) 
VALUES
(1, 1, '08:00', '10:00', 'A1'),
(2, 2, '09:30', '11:30', 'B2'),
(3, 3, '11:00', '13:00', 'C3'),
(4, 4, '12:30', '14:30', 'D4'),
(5, 5, '14:00', '16:00', 'E5'),
(6, 6, '15:30', '17:30', 'F6'),
(7, 7, '17:00', '19:00', 'G7'),
(8, 8, '18:30', '20:30', 'H8'),
(9, 9, '20:00', '22:00', 'I9'),
(10, 10, '21:30', '23:30', 'J10'),
(11, 11, '08:30', '10:30', 'K11'),
(12, 12, '10:00', '12:00', 'L12'),
(13, 13, '12:45', '14:45', 'M13'),
(14, 14, '14:30', '16:30', 'N14'),
(15, 15, '16:00', '18:00', 'O15'),
(16, 16, '17:30', '19:30', 'P16'),
(17, 17, '19:00', '21:00', 'Q17'),
(18, 18, '20:30', '22:30', 'R18'),
(19, 19, '22:00', '00:00', 'S19'),
(20, 20, '23:30', '01:30', 'T20');

	-- 147		Inserare în tabela Bilete
INSERT INTO Bilete (ID_Bilet, ZborID, PasagerID, Clasa, Pret)
VALUES
    (1, 1, 1, 'Economy', 350.50),
    (2, 2, 2, 'Business', 780.00),
    (3, 3, 3, 'Economy', 420.75),
    (4, 4, 4, 'First Class', 1250.25),
    (5, 5, 5, 'Economy', 280.90),
    (6, 6, 6, 'Economy', 410.00),
    (7, 7, 7, 'Business', 720.50),
    (8, 8, 8, 'Economy', 380.25),
    (9, 9, 9, 'First Class', 1350.75),
    (10, 10, 10, 'Economy', 300.00);


	-- 148		Inserare în tabela Plecari
INSERT INTO Plecari (ID_Plecare, ZborID, DataPlecare, PoartaPlecare)
VALUES
    (1, 1, '2024-03-20 07:00:00', 'A1'),
    (2, 2, '2024-03-21 09:30:00', 'B3'),
    (3, 3, '2024-03-22 11:45:00', 'C2'),
    (4, 4, '2024-03-23 14:15:00', 'D5'),
    (5, 5, '2024-03-24 16:45:00', 'E4'),
    (6, 6, '2024-03-25 19:00:00', 'F6'),
    (7, 7, '2024-03-26 21:30:00', 'G7'),
    (8, 8, '2024-03-27 04:45:00', 'H2'),
    (9, 9, '2024-03-28 07:00:00', 'I3'),
    (10, 10, '2024-03-29 09:15:00', 'J1');

	-- 149		Inserare în tabela Sosiri
INSERT INTO Sosiri (ID_Sosire, ZborID, DataSosire, PoartaSosire)
VALUES
    (1, 1, '2024-03-20 10:30:00', 'A3'),
    (2, 2, '2024-03-21 12:45:00', 'B5'),
    (3, 3, '2024-03-22 15:00:00', 'C4'),
    (4, 4, '2024-03-23 17:30:00', 'D2'),
    (5, 5, '2024-03-24 20:00:00', 'E1'),
    (6, 6, '2024-03-25 22:15:00', 'F6'),
    (7, 7, '2024-03-26 01:00:00', 'G4'),
    (8, 8, '2024-03-27 08:30:00', 'H3'),
    (9, 9, '2024-03-28 10:45:00', 'I2'),
    (10, 10, '2024-03-29 13:00:00', 'J1');



	-- 150		Inserare în tabela Bagaje
INSERT INTO Bagaje (ID_Bagaj, PasagerID, Greutate, Dimensiuni, Pierdut)
VALUES
    (1, 1, 23, '60x40x30 cm', 0),
    (2, 2, 18, '55x35x25 cm', 1),
    (3, 3, 15, '50x40x20 cm', 0),
    (4, 4, 30, '70x50x40 cm', 1),
    (5, 5, 22, '65x45x35 cm', 0),
    (6, 6, 28, '75x55x45 cm', 0),
    (7, 7, 19, '55x35x25 cm', 0),
    (8, 8, 17, '50x40x20 cm', 1),
    (9, 9, 25, '65x45x35 cm', 0),
    (10, 10, 21, '70x50x40 cm', 1);



	-- 151		Inserare în tabela PersonalAeroport
INSERT INTO PersonalAeroport (ID_Angajat, Nume, Prenume, Functie)
VALUES
    (1, 'Popescu', 'Ion', 'Agent de securitate'),
    (2, 'Ionescu', 'Maria', 'Personal de check-in'),
    (3, 'Popa', 'Mihai', 'Agent de încărcare bagaje'),
    (4, 'Georgescu', 'Ana', 'Stewardesă'),
    (5, 'Constantin', 'Elena', 'Pilot'),
    (6, 'Radu', 'Adrian', 'Agent de îmbarcare'),
    (7, 'Dumitru', 'Andreea', 'Tehnician de întreținere'),
    (8, 'Gheorghiu', 'Alex', 'Controlor de trafic aerian'),
    (9, 'Stan', 'Diana', 'Personal de curățenie'),
    (10, 'Stoica', 'Cristian', 'Inginer aeronautic');




	-- 152		Inserare în tabela PozitiiParcare
INSERT INTO PozitiiParcare (ID_Pozitie, NumarPozitie, Terminal, Disponibil)
VALUES
    (1, 101, 'Terminal 1', 1),
    (2, 102, 'Terminal 1', 0),
    (3, 103, 'Terminal 2', 1),
    (4, 104, 'Terminal 2', 1),
    (5, 105, 'Terminal 3', 0),
    (6, 106, 'Terminal 3', 1),
    (7, 107, 'Terminal 4', 1),
    (8, 108, 'Terminal 4', 0),
    (9, 109, 'Terminal 5', 1),
    (10, 110, 'Terminal 5', 1);



	-- 153		Inserare în tabela EchipajeZbor
INSERT INTO EchipajeZbor (ID_Echipaj, PilotID, CopilotID, InsotitorID)
VALUES
    (1, 5, 6, 7),
    (2, 6, 8, 9),
    (3, 7, 9, 10),
    (4, 8, 10, 5),
    (5, 9, 5, 6),
    (6, 10, 6, 7),
    (7, 5, 7, 8),
    (8, 6, 8, 9),
    (9, 7, 9, 10),
    (10, 8, 10, 5);


	-- 154		Inserare în tabela InchirieriAuto
INSERT INTO InchirieriAuto (ID_Inchiriere, Companie, DataInchiriere, DataReturnare, Cost)
VALUES
    (1, 'Hertz', '2024-03-20 08:00:00', '2024-03-22 08:00:00', 150.00),
    (2, 'Avis', '2024-03-21 10:00:00', '2024-03-23 10:00:00', 180.00),
    (3, 'Europcar', '2024-03-22 12:00:00', '2024-03-24 12:00:00', 200.00),
    (4, 'Budget', '2024-03-23 14:00:00', '2024-03-25 14:00:00', 170.00),
    (5, 'Enterprise', '2024-03-24 16:00:00', '2024-03-26 16:00:00', 190.00),
    (6, 'Sixt', '2024-03-25 18:00:00', '2024-03-27 18:00:00', 220.00),
    (7, 'Alamo', '2024-03-26 20:00:00', '2024-03-28 20:00:00', 210.00),
    (8, 'National', '2024-03-27 22:00:00', '2024-03-29 22:00:00', 240.00),
    (9, 'Thrifty', '2024-03-28 10:00:00', '2024-03-30 10:00:00', 230.00),
    (10, 'Dollar', '2024-03-29 12:00:00', '2024-03-31 12:00:00', 260.00);



	-- 155		Inserare în tabela AgentiVanzari
INSERT INTO AgentiVanzari (ID_Agent, Nume, Prenume, CompanieID)
VALUES
    (1, 'Popescu', 'Ana', 1),
    (2, 'Ionescu', 'Mihai', 2),
    (3, 'Radu', 'Maria', 3),
    (4, 'Dumitru', 'Alex', 4),
    (5, 'Georgescu', 'Elena', 5),
    (6, 'Constantin', 'Vlad', 6),
    (7, 'Stan', 'Andreea', 7),
    (8, 'Gheorghiu', 'Cristian', 8),
    (9, 'Stoica', 'Diana', 9),
    (10, 'Popa', 'Andrei', 10);



	-- 156		Inserare în tabela ReclamatiiPasageri
INSERT INTO ReclamatiiPasageri (ID_Reclamatie, PasagerID, Descriere)
VALUES
    (1, 1, 'Serviciu la clienti necorespunzator'),
    (2, 2, 'Zbor intarziat cu 3 ore'),
    (3, 3, 'Pierdere bagaj'),
    (4, 4, 'Zgomote deranjante in avion'),
    (5, 5, 'Asistenta in zbor necorespunzatoare'),
    (6, 6, 'Zbor anulat'),
    (7, 7, 'Bagaj deteriorat'),
    (8, 8, 'Serviciu slab de catering'),
    (9, 9, 'Inconveniente la imbarcare'),
    (10, 10, 'Probleme cu rezervarea biletelor');


	-- 157		Inserare în tabela MagazineAeroport
INSERT INTO MagazineAeroport (ID_Magazin, NumeMagazin, Locatie, Program)
VALUES
    (1, 'Duty-Free Shop', 'Zona de îmbarcare Terminal 1', '24/7'),
    (2, 'Relay', 'Zona de așteptare Terminal 2', '07:00 - 21:00'),
    (3, 'Fashion Gallery', 'Zona de sosiri Terminal 3', '08:00 - 22:00'),
    (4, 'Tech Zone', 'Zona de tranzit Terminal 4', '09:00 - 20:00'),
    (5, 'Food Court', 'Zona publică Terminal 5', '10:00 - 23:00'),
    (6, 'Gift Shop', 'Zona de îmbarcare Terminal 1', '09:00 - 18:00'),
    (7, 'Bookstore', 'Zona de sosiri Terminal 2', '08:30 - 20:30'),
    (8, 'Electronics Store', 'Zona de așteptare Terminal 3', '10:00 - 19:00'),
    (9, 'Wine & Spirits', 'Zona de tranzit Terminal 4', '11:00 - 21:00'),
    (10, 'Souvenir Shop', 'Zona publică Terminal 5', '09:30 - 17:30');



	-- 158		Inserare în tabela RestauranteAeroport
INSERT INTO RestauranteAeroport (ID_Restaurant, NumeRestaurant, TipBucatarie, Locatie, Program)
VALUES
    (1, 'Sky Lounge', 'Internțională', 'Terminal 1, Nivel 2', '2024-03-16'),
    (2, 'Café Italia', 'Italiană', 'Terminal 2, Zona de Așteptare', '2024-03-16'),
    (3, 'Asian Fusion', 'Asiatică', 'Terminal 3, Zona de Sosiri', '2024-03-16'),
    (4, 'Burger Shack', 'Fast Food', 'Terminal 4, Zona de Tranzit', '2024-03-16'),
    (5, 'Steakhouse Grill', 'Americană', 'Terminal 5, Zona Publică', '2024-03-16'),
    (6, 'Sushi Express', 'Japoneză', 'Terminal 1, Zona de Îmbarcare', '2024-03-16'),
    (7, 'Café Paris', 'Franțuzească', 'Terminal 2, Nivel 1', '2024-03-16'),
    (8, 'Mediterranean Delight', 'Mediteraneană', 'Terminal 3, Zona de Tranzit', '2024-03-16'),
    (9, 'Vegetarian Garden', 'Vegetariană', 'Terminal 4, Zona de Așteptare', '2024-03-16'),
    (10, 'Seafood Paradise', 'Fructe de Mare', 'Terminal 5, Nivel 2', '2024-03-16');



	-- 159		Inserare în tabela ServiciiAeroport
INSERT INTO ServiciiAeroport (ID_Serviciu, NumeServiciu, Descriere, Pret)
VALUES
    (1, 'Wi-Fi', 'Acces gratuit la internet în întregul aeroport', 0.00),
    (2, 'Spa & Wellness', 'Masaj și tratamente de înfrumusețare', 150.00),
    (3, 'Business Lounge', 'Sală VIP cu servicii exclusive', 200.00),
    (4, 'Transport Aerogara', 'Serviciu de transport între terminale', 20.00),
    (5, 'Sala de Conferințe', 'Închiriere sală pentru întâlniri și conferințe', 300.00),
    (6, 'Zonă de joacă pentru copii', 'Atracții și jocuri pentru cei mici', 0.00),
    (7, 'Depozit de Bagaje', 'Spațiu sigur pentru păstrarea bagajelor', 10.00),
    (8, 'Informații și Asistență', 'Asistență pentru pasageri și informații utile', 0.00),
    (9, 'Încărcare Dispozitive', 'Stații pentru încărcarea telefoanelor și dispozitivelor', 0.00),
    (10, 'Serviciu de Rent-a-Car', 'Închiriere autoturisme pentru transport terestru', 50.00);


	-- 160		Inserare în tabela SistemSecuritateAeroport
INSERT INTO SistemSecuritateAeroport (ID_SistemSecuritate, TipSistem, NivelSecuritate, Activ)
VALUES
    (1, 'Scanare Corporală', 4, 1),
    (2, 'Control Bagaje', 3, 1),
    (3, 'Camere de Supraveghere', 5, 1),
    (4, 'Echipă Canină', 4, 1),
    (5, 'Detectoare de Metale', 4, 1),
    (6, 'Sisteme Biometrice', 5, 1),
    (7, 'Barieră Anti-Teroare', 5, 1),
    (8, 'Sisteme de Alarmă', 4, 1),
    (9, 'Patrule de Securitate', 3, 1),
    (10, 'Monitorizare Acces', 5, 1);

	--161
	INSERT INTO PersonalContact (ID_Contact, AngajatID, TipContact, DetaliiContact)
VALUES
    (1, 1, 'Telefon', '0721123456'),
    (2, 2, 'Email', 'maria.ionescu@aeroport.ro'),
    (3, 3, 'Telefon', '0722234567'),
    (4, 4, 'Email', 'ana.georgescu@aeroport.ro'),
    (5, 5, 'Telefon', '0723345678'),
    (6, 6, 'Email', 'adrian.radu@aeroport.ro'),
    (7, 7, 'Telefon', '0724456789'),
    (8, 8, 'Email', 'alex.gheorghiu@aeroport.ro'),
    (9, 9, 'Telefon', '0725567890'),
    (10, 10, 'Email', 'cristian.stoica@aeroport.ro');

	--162
	INSERT INTO AsignariEchipajeZbor (ID_Asignare, EchipajID, ZborID, DataAsignare)
VALUES
    (1, 1, 1, '2024-03-20'),
    (2, 2, 2, '2024-03-21'),
    (3, 3, 3, '2024-03-22'),
    (4, 4, 4, '2024-03-23'),
    (5, 5, 5, '2024-03-24'),
    (6, 6, 6, '2024-03-25'),
    (7, 7, 7, '2024-03-26'),
    (8, 8, 8, '2024-03-27'),
    (9, 9, 9, '2024-03-28'),
    (10, 10, 10, '2024-03-29');


	--163
	INSERT INTO UrmarireBagaje (ID_Urmarire, BagajID, Status, DataActualizare, Locatie)
VALUES
    (1, 1, 'În tranzit', '2024-03-20 08:00:00', 'Terminal 1'),
    (2, 2, 'Pierdut', '2024-03-21 10:00:00', 'Terminal 2'),
    (3, 3, 'La destinatie', '2024-03-22 12:00:00', 'Terminal 3'),
    (4, 4, 'În tranzit', '2024-03-23 14:00:00', 'Terminal 4'),
    (5, 5, 'La destinatie', '2024-03-24 16:00:00', 'Terminal 5'),
    (6, 6, 'În tranzit', '2024-03-25 18:00:00', 'Terminal 1'),
    (7, 7, 'La destinatie', '2024-03-26 20:00:00', 'Terminal 2'),
    (8, 8, 'Pierdut', '2024-03-27 22:00:00', 'Terminal 3'),
    (9, 9, 'În tranzit', '2024-03-28 10:00:00', 'Terminal 4'),
    (10, 10, 'La destinatie', '2024-03-29 12:00:00', 'Terminal 5');

	--164
	INSERT INTO TranzactiiInchirieriAuto (ID_Tranzactie, InchiriereID, PasagerID, DataTranzactie)
VALUES
    (1, 1, 1, '2024-03-20 08:30:00'),
    (2, 2, 2, '2024-03-21 10:30:00'),
    (3, 3, 3, '2024-03-22 12:30:00'),
    (4, 4, 4, '2024-03-23 14:30:00'),
    (5, 5, 5, '2024-03-24 16:30:00'),
    (6, 6, 6, '2024-03-25 18:30:00'),
    (7, 7, 7, '2024-03-26 20:30:00'),
    (8, 8, 8, '2024-03-27 22:30:00'),
    (9, 9, 9, '2024-03-28 10:30:00'),
    (10, 10, 10, '2024-03-29 12:30:00');

--1		Selectează toate destinațiile din Franța
	SELECT *
FROM Destinatii
WHERE TaraDestinatie = 'Franța';
--2		Selectează toate destinațiile și le ordonează în ordine alfabetică după orașul destinației
SELECT *
FROM Destinatii
ORDER BY OrasDestinatie ASC;

--3		Selectează primele 5 bilete disponibile, ordonate după preț în ordine crescătoare
SELECT TOP 5 *
FROM Bilete
ORDER BY Pret ASC;

--4		Selectează toate biletele pentru zborul cu ID-ul 1 și care sunt în clasa economică
SELECT *
FROM Bilete
WHERE ZborID = 1 AND Clasa = 'Economică';

--5		Selectează numele complet al pasagerilor concatenând numele și prenumele lor
SELECT Nume + ' ' + Prenume AS NumeComplet
FROM Pasageri;

--6			Selectare toate înregistrările
SELECT * FROM PersonalContact;


--7			Selectare ID-urile și Tipurile de contact
SELECT ID_Contact, TipContact FROM PersonalContact;


--8		Selectare contactele de tip Email
SELECT * FROM PersonalContact WHERE TipContact = 'Email';

--9			Selectare contactele pentru un anumit angajat

SELECT * FROM PersonalContact WHERE AngajatID = 1;

--10		Selectare detaliile de contact pentru tipul 'Telefon'
SELECT DetaliiContact FROM PersonalContact WHERE TipContact = 'Telefon';

--11			Selectare toate înregistrările
SELECT * FROM AsignariEchipajeZbor;

--12			Selectare ID-urile asignărilor și datele de asignare
SELECT ID_Asignare, DataAsignare FROM AsignariEchipajeZbor;

--13		Selectare asignările pentru un anumit echipaj	
SELECT * FROM AsignariEchipajeZbor WHERE EchipajID = 2;

--14			Selectare asignările pentru un anumit zbor
SELECT * FROM AsignariEchipajeZbor WHERE ZborID = 3;

--15			Selectare asignările după data de asignare
SELECT * FROM AsignariEchipajeZbor WHERE DataAsignare = '2024-03-24';


--16			Selectare ID-urile urmăririlor și statusurile
SELECT ID_Urmarire, Status FROM UrmarireBagaje;



--17. Selectează toate magazinele din aeroport și le ordonează în ordine alfabetică după nume.
SELECT *
FROM MagazineAeroport
ORDER BY NumeMagazin ASC;

--18. Selectează toate serviciile din aeroport și le ordonează în ordine descrescătoare după preț.
SELECT *
FROM ServiciiAeroport
ORDER BY Pret DESC;

--19. Selectează toate pozițiile de parcare din Terminalul 1 care sunt disponibile.
SELECT *
FROM PozitiiParcare
WHERE Terminal = 'Terminal 1' AND Disponibil = 1;

--20. Selectează toate sosirile din data de 20 martie 2024.
SELECT *
FROM Sosiri
WHERE DataSosire = '2024-03-20';

--21. Selectează toate bagajele care au o greutate mai mare de 20 kg și care nu sunt pierdute.
SELECT *
FROM Bagaje
WHERE Greutate > 20 AND Pierdut = 0;

--22. Selectează toate echipajele de zbor care au atât un pilot cât și un copilot asignați.
SELECT *
FROM EchipajeZbor
WHERE PilotID IS NOT NULL AND CopilotID IS NOT NULL;

--23. Selectează toți agenții de vânzări al căror nume conține 'Popescu' sau 'Ionescu'.
SELECT *
FROM AgentiVanzari
WHERE Nume LIKE '%Popescu%' OR Nume LIKE '%Ionescu%';

--24. Selectează toți agenții de vânzări al căror nume conține 'Popescu' sau 'Ionescu'.
SELECT *
FROM AgentiVanzari
WHERE Nume LIKE '%Popescu%' OR Nume LIKE '%Ionescu%';

--25. Selectează toate reclamațiile pasagerilor care au ca descriere 'Zbor Anulat'.
SELECT *
FROM ReclamatiiPasageri
WHERE Descriere LIKE 'Zbor Anulat';

--26. Selectează toate serviciile din aeroport care au în descriere cuvântul 'transport'.
SELECT *
FROM ServiciiAeroport
WHERE Descriere LIKE '%transport%';

--27. Selectează toate magazinele din aeroport care sunt deschise între orele 08:00 și 20:00.
SELECT *
FROM MagazineAeroport
WHERE Program = '08:00 - 20:00';

--28. Selectează toate zborurile și le ordonează după data și ora de plecare.
SELECT *
FROM Zboruri
ORDER BY DataPlecare, OraPlecare;




--29			Afisează numele, funcția, data și poarta de plecare a angajaților din aeroport, împreună cu ID-ul și data plecării zborului asociat

SELECT A.Nume AS Angajat, A.Functie, P.ID_Plecare, P.DataPlecare, P.PoartaPlecare,
    Z.ID_Zbor, Z.DataPlecare, D.OrasDestinatie AS Destinatie
FROM PersonalAeroport AS A
LEFT OUTER JOIN (Plecari AS P
    INNER JOIN Zboruri AS Z ON P.ZborID = Z.ID_Zbor
    INNER JOIN Destinatii AS D ON Z.DestinatieID = D.ID_Destinatie)
ON A.ID_Angajat = P.ID_Plecare;






--30		Afisează numele, genul, greutatea și dimensiunile bagajului pasagerilor, împreună cu ID-ul zborului și data plecării asociate.

SELECT P.Nume AS Pasager, P.Gen, B.ID_Bagaj, B.Greutate, B.Dimensiuni,
    Z.ID_Zbor, Z.DataPlecare, D.OrasDestinatie AS Destinatie
FROM Pasageri AS P
LEFT OUTER JOIN (Bagaje AS B
    INNER JOIN Zboruri AS Z ON B.PasagerID = P.ID_Pasager
    INNER JOIN Destinatii AS D ON Z.DestinatieID = D.ID_Destinatie)
ON P.ID_Pasager = B.PasagerID;





--31		Afisează numele și locația magazinelor din aeroport, împreună cu serviciile disponibile în fiecare magazin


SELECT M.NumeMagazin AS Magazin, M.Locatie, S.ID_Serviciu, S.NumeServiciu, S.Descriere, S.
Pret
FROM MagazineAeroport AS M
LEFT OUTER JOIN ServiciiAeroport AS S ON M.ID_Magazin = S.ID_Serviciu;





--32   UNION: Returnează toate înregistrările din două tabele, eliminând duplicările
SELECT Nume, Prenume FROM Pasageri
UNION
SELECT NumeMagazin, Locatie FROM MagazineAeroport;




--33    UNION ALL: Returnează toate înregistrările din două tabele, inclusiv duplicările.
SELECT Nume, Prenume FROM Pasageri
UNION ALL
SELECT NumeMagazin, Locatie FROM MagazineAeroport;



--34    EXCEPT: Returnează înregistrările din prima tabelă care nu se găsesc în a doua tabelă
SELECT Nume, Prenume FROM Pasageri
EXCEPT
SELECT Nume, Prenume FROM Pasageri WHERE Gen = 'Masculin';



--35   INTERSECT: Returnează înregistrările comune din două tabele
SELECT ID_Bilet, ZborID,Clasa  FROM Bilete
INTERSECT
SELECT ID_Bilet, ZborID,Clasa  FROM Bilete WHERE Clasa = 'Economy';





--36   Afișare număr de plecări și sosiri pe companie aeriană

SELECT 
    CA.NumeCompanie AS CompanieAeriana,
    COUNT(DISTINCT P.ID_Plecare) AS NumarPlecari,
    COUNT(DISTINCT S.ID_Sosire) AS NumarSosiri
FROM CompaniiAeriene CA
LEFT JOIN Zboruri Z ON CA.ID_Companie = Z.CompanieID
LEFT JOIN Plecari P ON Z.ID_Zbor = P.ZborID
LEFT JOIN Sosiri S ON Z.ID_Zbor = S.ZborID
GROUP BY CA.NumeCompanie;




--37   Afișare media de greutate a bagajelor pierdute pe destinație

SELECT 
    D.OrasDestinatie,
    AVG(B.Greutate) AS MediaGreutate
FROM Destinatii D
LEFT JOIN Zboruri Z ON D.ID_Destinatie = Z.DestinatieID
LEFT JOIN Plecari P ON Z.ID_Zbor = P.ZborID
LEFT JOIN Sosiri S ON Z.ID_Zbor = S.ZborID
LEFT JOIN Bagaje B ON P.ID_Plecare = B.PasagerID OR S.ID_Sosire = B.PasagerID
WHERE B.Pierdut = 1
GROUP BY D.OrasDestinatie;




--38  Afișare suma veniturilor din vânzări de bilete pe zi

SELECT 
    DATEPART(year, Z.DataPlecare) AS An,
    DATEPART(month, Z.DataPlecare) AS Luna,
    DATEPART(day, Z.DataPlecare) AS Zi,
    SUM(B.Pret) AS VenitTotal
FROM Zboruri Z
LEFT JOIN Bilete B ON Z.ID_Zbor = B.ZborID
GROUP BY DATEPART(year, Z.DataPlecare), DATEPART(month, Z.DataPlecare), DATEPART(day, Z.DataPlecare);




--39   Afișare numărul total de plecări pe poartă

SELECT 
    P.PoartaPlecare,
    COUNT(P.ID_Plecare) AS NumarPlecari
FROM Plecari P
LEFT JOIN Zboruri Z ON P.ZborID = Z.ID_Zbor
GROUP BY P.PoartaPlecare;




--40   Afișare destinații cu cea mai mare medie de greutate a bagajelor pierdute:

SELECT 
    D.OrasDestinatie,
    AVG(B.Greutate) AS MediaGreutate
FROM Destinatii D
LEFT JOIN Zboruri Z ON D.ID_Destinatie = Z.DestinatieID
LEFT JOIN Plecari P ON Z.ID_Zbor = P.ZborID
LEFT JOIN Sosiri S ON Z.ID_Zbor = S.ZborID
LEFT JOIN Bagaje B ON P.ID_Plecare = B.PasagerID OR S.ID_Sosire = B.PasagerID
WHERE B.Pierdut = 1
GROUP BY D.OrasDestinatie
HAVING AVG(B.Greutate) > 20;



--41   Afișare numărul total de sosiri pe companie aeriană cu cel puțin 5 plecări

SELECT 
    CA.NumeCompanie AS CompanieAeriana,
    COUNT(S.ID_Sosire) AS NumarSosiri
FROM CompaniiAeriene CA
LEFT JOIN Zboruri Z ON CA.ID_Companie = Z.CompanieID
LEFT JOIN Plecari P ON Z.ID_Zbor = P.ZborID
LEFT JOIN Sosiri S ON Z.ID_Zbor = S.ZborID
GROUP BY CA.NumeCompanie
HAVING COUNT(P.ID_Plecare) >= 5; 




--42   Afișare zile cu cele mai mari venituri din vânzarea de bilete

SELECT 
    DATEPART(year, Z.DataPlecare) AS An,
    DATEPART(month, Z.DataPlecare) AS Luna,
    DATEPART(day, Z.DataPlecare) AS Zi,
    SUM(B.Pret) AS VenitTotal
FROM Zboruri Z
LEFT JOIN Bilete B ON Z.ID_Zbor = B.ZborID
GROUP BY DATEPART(year, Z.DataPlecare), DATEPART(month, Z.DataPlecare), DATEPART(day, Z.DataPlecare)
HAVING SUM(B.Pret) > 10000; 




--43		Afișarepoartă cu cel puțin 10 plecări într-o zi specifică:

SELECT 
    P.PoartaPlecare,
    COUNT(P.ID_Plecare) AS NumarPlecari
FROM Plecari P
LEFT JOIN Zboruri Z ON P.ZborID = Z.ID_Zbor
WHERE CONVERT(date, Z.DataPlecare) = '2024-04-11' 
GROUP BY P.PoartaPlecare
HAVING COUNT(P.ID_Plecare) >= 10; 






--44		Destinații cu numărul total de plecări și sosiri pentru fiecare țară:

WITH PlecariSosiri AS (
    SELECT 
        D.TaraDestinatie,
        COUNT(DISTINCT P.ID_Plecare) AS NumarPlecari,
        COUNT(DISTINCT S.ID_Sosire) AS NumarSosiri
    FROM Destinatii D
    LEFT JOIN Zboruri Z ON D.ID_Destinatie = Z.DestinatieID
    LEFT JOIN Plecari P ON Z.ID_Zbor = P.ZborID
    LEFT JOIN Sosiri S ON Z.ID_Zbor = S.ZborID
    GROUP BY D.TaraDestinatie
)
SELECT 
    TaraDestinatie,
    SUM(NumarPlecari) AS TotalPlecari,
    SUM(NumarSosiri) AS TotalSosiri
FROM PlecariSosiri
GROUP BY TaraDestinatie;




--45	Numărul total de bilete vândute și venitul total pentru fiecare lună și an:

WITH BileteVenituri AS (
    SELECT 
        YEAR(Z.DataPlecare) AS An,
        MONTH(Z.DataPlecare) AS Luna,
        COUNT(B.ID_Bilet) AS NumarBilete,
        SUM(B.Pret) AS VenitTotal
    FROM Zboruri Z
    LEFT JOIN Bilete B ON Z.ID_Zbor = B.ZborID
    GROUP BY YEAR(Z.DataPlecare), MONTH(Z.DataPlecare)
)
SELECT 
    An,
    Luna,
    SUM(NumarBilete) AS TotalBilete,
    SUM(VenitTotal) AS TotalVenit
FROM BileteVenituri
GROUP BY An, Luna;




--46	Top 5 cele mai frecvente destinații pentru fiecare companie aeriană:

WITH TopDestinatii AS (
    SELECT 
        CA.NumeCompanie,
        D.OrasDestinatie,
        COUNT(Z.ID_Zbor) AS NumarZboruri,
        ROW_NUMBER() OVER (PARTITION BY CA.NumeCompanie ORDER BY COUNT(Z.ID_Zbor) DESC) AS Rank
    FROM CompaniiAeriene CA
    LEFT JOIN Zboruri Z ON CA.ID_Companie = Z.CompanieID
    LEFT JOIN Destinatii D ON Z.DestinatieID = D.ID_Destinatie
    GROUP BY CA.NumeCompanie, D.OrasDestinatie
)
SELECT 
    NumeCompanie,
    OrasDestinatie,
    NumarZboruri
FROM TopDestinatii
WHERE Rank <= 5;






--47	 Obținerea detaliilor despre echipajul de zbor și membrii acestuia

SELECT EZ.ID_Echipaj, P.Nume AS NumePilot, P.Prenume AS PrenumePilot, CP.Functie AS FunctieCopilot, IP.Nume AS NumeInsotitor, IP.Prenume AS PrenumeInsotitor
FROM EchipajeZbor EZ
JOIN PersonalAeroport P ON EZ.PilotID = P.ID_Angajat
JOIN PersonalAeroport CP ON EZ.CopilotID = CP.ID_Angajat
JOIN PersonalAeroport IP ON EZ.InsotitorID = IP.ID_Angajat;




--48		 Calcularea prețului total al tuturor biletelor pentru un anumit zbor

SELECT Z.ID_Zbor, SUM(B.Pret) AS PretTotalBilete
FROM Zboruri Z
JOIN Bilete B ON Z.ID_Zbor = B.ZborID
GROUP BY Z.ID_Zbor;




--50		 Obținerea numărului total de bagaje și greutatea totală pentru fiecare pasager

SELECT P.ID_Pasager, P.Nume, P.Prenume, COUNT(B.ID_Bagaj) AS NumarBagaje, SUM(B.Greutate) AS GreutateTotala
FROM Pasageri P
LEFT JOIN Bagaje B ON P.ID_Pasager = B.PasagerID
GROUP BY P.ID_Pasager, P.Nume, P.Prenume;




--51		Calcularea numărului total de tranzacții de închiriere auto pentru fiecare companie de închirieri

SELECT IA.Companie, COUNT(TIA.ID_Tranzactie) AS NumarTranzactii
FROM InchirieriAuto IA
LEFT JOIN TranzactiiInchirieriAuto TIA ON IA.ID_Inchiriere = TIA.InchiriereID
GROUP BY IA.Companie;





--52		 Obținerea numărului total de reclamații pentru fiecare pasager

SELECT P.ID_Pasager, P.Nume, P.Prenume, COUNT(RP.ID_Reclamatie) AS NumarReclamatii
FROM Pasageri P
LEFT JOIN ReclamatiiPasageri RP ON P.ID_Pasager = RP.PasagerID
GROUP BY P.ID_Pasager, P.Nume, P.Prenume;





--53		Selectarea datelor despre plecări și sosiri, inclusiv informații despre pasageri și destinații

SELECT P.ID_Pasager, P.Nume, P.Prenume, D.OrasDestinatie, D.TaraDestinatie, PL.DataPlecare, SO.DataSosire
FROM Pasageri P
JOIN Bilete B ON P.ID_Pasager = B.PasagerID
JOIN Zboruri Z ON B.ZborID = Z.ID_Zbor
JOIN Destinatii D ON Z.DestinatieID = D.ID_Destinatie
JOIN Plecari PL ON Z.ID_Zbor = PL.ZborID
JOIN Sosiri SO ON Z.ID_Zbor = SO.ZborID;





--54		Calcularea profitului total generat de vânzarea biletelor pe fiecare destinație

SELECT D.OrasDestinatie, D.TaraDestinatie, SUM(B.Pret) AS ProfitTotal
FROM Destinatii D
JOIN Zboruri Z ON D.ID_Destinatie = Z.DestinatieID
JOIN Bilete B ON Z.ID_Zbor = B.ZborID
GROUP BY D.OrasDestinatie, D.TaraDestinatie;




--55		Obținerea datelor despre personalul de contact al aeroportului și pozițiile lor

SELECT PC.ID_Contact, PA.Nume, PA.Prenume, PA.Functie, PC.TipContact, PC.DetaliiContact
FROM PersonalAeroport PA
JOIN PersonalContact PC ON PA.ID_Angajat = PC.AngajatID;




--56		 Selectarea detaliilor despre urmărirea bagajelor și starea lor actuală

SELECT UB.ID_Urmarire, B.ID_Bagaj, B.Greutate, B.Dimensiuni, UB.Status, UB.DataActualizare, UB.Locatie
FROM Bagaje B
JOIN UrmarireBagaje UB ON B.ID_Bagaj = UB.BagajID;




-- 57  View pentru detaliile complete ale zborurilor

CREATE VIEW DetaliiZboruri AS
SELECT Z.ID_Zbor, C.NumeCompanie, D.OrasDestinatie, D.TaraDestinatie, Z.DataPlecare, Z.OraPlecare, P.OraPlecareProgram, P.OraSosireProgram
FROM Zboruri Z
JOIN CompaniiAeriene C ON Z.CompanieID = C.ID_Companie
JOIN Destinatii D ON Z.DestinatieID = D.ID_Destinatie
JOIN ProgramZboruri P ON Z.ID_Zbor = P.ZborID;


SELECT * FROM DetaliiZboruri;





--58		View pentru detaliile complete ale echipajelor de zbor

CREATE VIEW DetaliiEchipaje AS
SELECT EZ.ID_Echipaj, P.Nume AS NumePilot, P.Prenume AS PrenumePilot, CP.Functie AS FunctieCopilot, IP.Nume AS NumeInsotitor, IP.Prenume AS PrenumeInsotitor
FROM EchipajeZbor EZ
JOIN PersonalAeroport P ON EZ.PilotID = P.ID_Angajat
JOIN PersonalAeroport CP ON EZ.CopilotID = CP.ID_Angajat
JOIN PersonalAeroport IP ON EZ.InsotitorID = IP.ID_Angajat;

SELECT * FROM DetaliiEchipaje;




--59		 View pentru urmărirea bagajelor cu detaliile complete

CREATE VIEW DetaliiUrmareBagaje AS
SELECT UB.ID_Urmarire, B.ID_Bagaj, B.PasagerID, P.Nume AS NumePasager, P.Prenume AS PrenumePasager, B.Greutate, B.Dimensiuni, UB.Status, UB.DataActualizare, UB.Locatie
FROM Bagaje B
JOIN UrmarireBagaje UB ON B.ID_Bagaj = UB.BagajID
JOIN Pasageri P ON B.PasagerID = P.ID_Pasager;

SELECT * FROM DetaliiUrmareBagaje;





--60		View pentru detaliile complete ale tranzacțiilor de închiriere auto

CREATE VIEW DetaliiTranzactiiInchirieri AS
SELECT TIA.ID_Tranzactie, IA.Companie, IA.DataInchiriere, IA.DataReturnare, IA.Cost, P.Nume AS NumePasager, P.Prenume AS PrenumePasager
FROM InchirieriAuto IA
JOIN TranzactiiInchirieriAuto TIA ON IA.ID_Inchiriere = TIA.InchiriereID
JOIN Pasageri P ON TIA.PasagerID = P.ID_Pasager;

SELECT * FROM DetaliiTranzactiiInchirieri;




--61		View pentru feedback-ul și evaluările zborurilor cu detalii complete

CREATE VIEW DetaliiFeedbackZboruri AS
SELECT F.ID_Feedback, P.Nume AS NumePasager, P.Prenume AS PrenumePasager, Z.ID_Zbor, Z.DataPlecare, F.Nota, F.Comentariu
FROM FeedbackEvaluariZboruri F
JOIN Pasageri P ON F.PasagerID = P.ID_Pasager
JOIN Zboruri Z ON F.ZborID = Z.ID_Zbor;

SELECT * FROM DetaliiFeedbackZboruri;





--62		Trigger pentru a actualiza statusul bagajului în caz de modificare

CREATE TRIGGER UpdateStatusBagaj
ON Bagaje
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Pierdut)
    BEGIN
        UPDATE UrmarireBagaje
        SET Status = CASE WHEN i.Pierdut = 1 THEN 'Pierdut' ELSE 'Găsit' END
        FROM UrmarireBagaje u
        JOIN inserted i ON u.BagajID = i.ID_Bagaj;
    END
END;

UPDATE Bagaje
SET Pierdut = 1
WHERE ID_Bagaj = 3;





--63		Trigger pentru a actualiza data de angajare a personalului din aeroport

CREATE TRIGGER UpdateDataAngajare
ON PersonalAeroport
AFTER INSERT
AS
BEGIN
    UPDATE PersonalAeroport
    SET DataAngajare = GETDATE()
    WHERE ID_Angajat IN (SELECT ID_Angajat FROM inserted);
END;





--64		Trigger pentru a actualiza codul IATA și codul ICAO al companiilor aeriene

CREATE TRIGGER UpdateCodCompanie
ON CompaniiAeriene
AFTER UPDATE
AS
BEGIN
    IF UPDATE(CodIATA) OR UPDATE(CodICAO)
    BEGIN
        UPDATE CompaniiAeriene
        SET CodIATA = 'NewIATA', CodICAO = 'NewICAO'
        WHERE ID_Companie IN (SELECT ID_Companie FROM inserted);
    END
END;





--65		.Trigger pentru a actualiza codul telefonului pentru destinații

CREATE TRIGGER UpdateCodTelefonDestinatie
ON Destinatii
AFTER INSERT
AS
BEGIN
    UPDATE Destinatii
    SET CodTelefon = 'NewPhoneNumber'
    WHERE ID_Destinatie IN (SELECT ID_Destinatie FROM inserted);
END;





--66		Trigger pentru a actualiza poziția de parcare a aeronavei în cazul în care devine disponibilă

CREATE TRIGGER UpdatePozitieParcare
ON PozitiiParcare
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Disponibil)
    BEGIN
        UPDATE PozitiiParcare
        SET Terminal = 'NewTerminal'
        WHERE Disponibil = 1;
    END
END;






--67		Numărul mediu de bagaje pierdute pe zbor pentru fiecare destinație:


WITH MedieBagajePierdute AS (
    SELECT 
        D.OrasDestinatie,
        AVG(B.Greutate) AS MedieGreutatePierduta
    FROM Destinatii D
    LEFT JOIN Zboruri Z ON D.ID_Destinatie = Z.DestinatieID
    LEFT JOIN Plecari P ON Z.ID_Zbor = P.ZborID
    LEFT JOIN Sosiri S ON Z.ID_Zbor = S.ZborID
    LEFT JOIN Bagaje B ON P.ID_Plecare = B.PasagerID OR S.ID_Sosire = B.PasagerID
    WHERE B.Pierdut = 1
    GROUP BY D.OrasDestinatie
)
SELECT 
    OrasDestinatie,
    MedieGreutatePierduta
FROM MedieBagajePierdute;





--68		Top 3 cele mai vândute categorii de bilete pentru fiecare destinație:

WITH TopCategoriiBilete AS (
    SELECT 
        D.OrasDestinatie,
        B.Clasa,
        COUNT(B.ID_Bilet) AS NumarBilete,
        ROW_NUMBER() OVER (PARTITION BY D.OrasDestinatie ORDER BY COUNT(B.ID_Bilet) DESC) AS Rank
    FROM Destinatii D
    LEFT JOIN Zboruri Z ON D.ID_Destinatie = Z.DestinatieID
    LEFT JOIN Bilete B ON Z.ID_Zbor = B.ZborID
    GROUP BY D.OrasDestinatie, B.Clasa
)
SELECT 
    OrasDestinatie,
    Clasa,
    NumarBilete
FROM TopCategoriiBilete
WHERE Rank <= 3;


--69		View pentru rapoartele de vânzări lunar: 

CREATE VIEW RapoarteVanzariLunare AS
WITH BileteVenituri AS (
    SELECT 
        YEAR(Z.DataPlecare) AS An,
        MONTH(Z.DataPlecare) AS Luna,
        COUNT(B.ID_Bilet) AS NumarBilete,
        SUM(B.Pret) AS VenitTotal
    FROM Zboruri Z
    LEFT JOIN Bilete B ON Z.ID_Zbor = B.ZborID
    GROUP BY YEAR(Z.DataPlecare), MONTH(Z.DataPlecare)
)
SELECT 
    An,
    Luna,
    SUM(NumarBilete) AS TotalBilete,
    SUM(VenitTotal) AS TotalVenit
FROM BileteVenituri
GROUP BY An, Luna;



--70		View pentru topul companiilor aeriene după numărul total de zboruri:

CREATE VIEW TopCompaniiAeriene AS
WITH NumarZboruri AS (
    SELECT 
        CA.NumeCompanie,
        COUNT(Z.ID_Zbor) AS NumarTotalZboruri
    FROM CompaniiAeriene CA
    LEFT JOIN Zboruri Z ON CA.ID_Companie = Z.CompanieID
    GROUP BY CA.NumeCompanie
)
SELECT 
    NumeCompanie,
    NumarTotalZboruri
FROM NumarZboruri
ORDER BY NumarTotalZboruri DESC;

--71		View pentru afișarea detalii despre biletele achiziționate de pasageri pentru clasa superioară.

CREATE VIEW BiletePasageriClasaSuperioara AS
SELECT 
    P.Nume AS NumePasager,
    P.Prenume AS PrenumePasager,
    B.ID_Bilet AS IDBilet,
    B.Clasa AS ClasaBilet,
    B.Pret AS PretBilet
FROM 
    Pasageri P
JOIN 
    Bilete B ON P.ID_Pasager = B.PasagerID
WHERE 
    B.Clasa = 'Business' OR B.Clasa = 'Economy';


--72		View pentru numărul mediu de bagaje pierdute pe zbor pentru fiecare destinație: 

CREATE VIEW MedieBagajePierdute AS
WITH MedieBagaje AS (
    SELECT 
        D.OrasDestinatie,
        AVG(B.Greutate) AS MedieGreutatePierduta
    FROM Destinatii D
    LEFT JOIN Zboruri Z ON D.ID_Destinatie = Z.DestinatieID
    LEFT JOIN Plecari P ON Z.ID_Zbor = P.ZborID
    LEFT JOIN Sosiri S ON Z.ID_Zbor = S.ZborID
    LEFT JOIN Bagaje B ON P.ID_Plecare = B.PasagerID OR S.ID_Sosire = B.PasagerID
    WHERE B.Pierdut = 1
    GROUP BY D.OrasDestinatie
)
SELECT 
    OrasDestinatie,
    MedieGreutatePierduta
FROM MedieBagaje;


--73		View pentru rapoartele de vânzări pe țară: 

CREATE VIEW RapoarteVanzariTari AS
WITH BileteVenituri AS (
    SELECT 
        D.TaraDestinatie,
        COUNT(B.ID_Bilet) AS NumarBilete,
        SUM(B.Pret) AS VenitTotal
    FROM Zboruri Z
    LEFT JOIN Bilete B ON Z.ID_Zbor = B.ZborID
    LEFT JOIN Destinatii D ON Z.DestinatieID = D.ID_Destinatie
    GROUP BY D.TaraDestinatie
)
SELECT 
    TaraDestinatie,
    NumarBilete,
    VenitTotal
FROM BileteVenituri;


--74		View pentru topul destinațiilor după numărul total de bilete vândute: 

CREATE VIEW TopDestinatii AS
WITH NumarBilete AS (
    SELECT 
        D.OrasDestinatie,
        COUNT(B.ID_Bilet) AS NumarTotalBilete
    FROM Destinatii D
    LEFT JOIN Zboruri Z ON D.ID_Destinatie = Z.DestinatieID
    LEFT JOIN Bilete B ON Z.ID_Zbor = B.ZborID
    GROUP BY D.OrasDestinatie
)
SELECT 
    OrasDestinatie,
    NumarTotalBilete
FROM NumarBilete
ORDER BY NumarTotalBilete DESC;


--75		TopCompaniiAeriene in functie de numarul de bilete vandute

CREATE VIEW TopCompaniiAeriene AS
WITH NumarBilete AS (
    SELECT TOP 100 PERCENT
        CA.NumeCompanie,
        COUNT(B.ID_Bilet) AS NumarTotalBilete
    FROM CompaniiAeriene CA
    LEFT JOIN Zboruri Z ON CA.ID_Companie = Z.CompanieID
    LEFT JOIN Bilete B ON Z.ID_Zbor = B.ZborID
    GROUP BY CA.NumeCompanie
    ORDER BY NumarTotalBilete DESC
)
SELECT 
    NumeCompanie,
    NumarTotalBilete
FROM NumarBilete;


--76		View pentru a afișa statistici despre numărul total de zboruri efectuate de fiecare companie aeriană

CREATE VIEW StatisticiZboruriCompanii AS
SELECT 
    CA.NumeCompanie AS CompanieAeriana,
    COUNT(Z.ID_Zbor) AS NumarTotalZboruri
FROM 
    CompaniiAeriene CA
LEFT JOIN 
    Zboruri Z ON CA.ID_Companie = Z.CompanieID
GROUP BY 
    CA.NumeCompanie;






--77		Trigger pentru actualizarea numărului de bilete vândute

	CREATE TRIGGER ActualizareNumarBileteVandute
ON Bilete
AFTER INSERT
AS
BEGIN
    DECLARE @ZborID INT;
    DECLARE @NumarBilete INT;

    SELECT @ZborID = ZborID, @NumarBilete = COUNT(*) FROM inserted GROUP BY ZborID;

    UPDATE Zboruri
    SET NumarBileteVandute = NumarBileteVandute + @NumarBilete
    WHERE ID_Zbor = @ZborID;
END;


--78		CTE pentru a găsi toate zborurile care au bagaje pierdute

WITH ZboruriCuBagajePierdute AS (
    SELECT DISTINCT Z.ID_Zbor, Z.CompanieID, Z.DestinatieID
    FROM Zboruri Z
    INNER JOIN Plecari P ON Z.ID_Zbor = P.ZborID
    INNER JOIN Bagaje B ON P.ID_Plecare = B.PasagerID
    WHERE B.Pierdut = 1
)
SELECT ZCBP.ID_Zbor, CA.NumeCompanie, D.OrasDestinatie
FROM ZboruriCuBagajePierdute ZCBP
INNER JOIN CompaniiAeriene CA ON ZCBP.CompanieID = CA.ID_Companie
INNER JOIN Destinatii D ON ZCBP.DestinatieID = D.ID_Destinatie;


--79		Interogare pentru a găsi toți pasagerii cu bagaje pierdute și informații despre bagaje

SELECT P.Nume, P.Prenume, B.Greutate, B.Dimensiuni, UB.Status
FROM Pasageri P
INNER JOIN Bagaje B ON P.ID_Pasager = B.PasagerID
INNER JOIN UrmarireBagaje UB ON B.ID_Bagaj = UB.BagajID
WHERE UB.Status = 'Pierdut';


--80		 CTE pentru a calcula durata medie a fiecărui zbor

WITH DurataMedieZboruri AS (
    SELECT Z.ID_Zbor, AVG(Z.DurataZbor) AS DurataMedie
    FROM Zboruri Z
    GROUP BY Z.ID_Zbor
)
SELECT DMZ.ID_Zbor, DMZ.DurataMedie, C.NumeCompanie, D.OrasDestinatie
FROM DurataMedieZboruri DMZ
INNER JOIN Zboruri Z ON DMZ.ID_Zbor = Z.ID_Zbor
INNER JOIN CompaniiAeriene C ON Z.CompanieID = C.ID_Companie
INNER JOIN Destinatii D ON Z.DestinatieID = D.ID_Destinatie;

--81		Interogare pentru a găsi toate tranzacțiile de închiriere auto și detalii despre pasageri

SELECT TC.ID_Tranzactie, TC.DataTranzactie, P.Nume, P.Prenume, IA.Companie
FROM TranzactiiInchirieriAuto TC
INNER JOIN Pasageri P ON TC.PasagerID = P.ID_Pasager
INNER JOIN InchirieriAuto IA ON TC.InchiriereID = IA.ID_Inchiriere;


--82		CTE pentru a afișa numele și funcția angajaților de la aeroport și informații despre bagaje

WITH AngajatiSiBagaje AS (
    SELECT PA.Nume, PA.Prenume, PA.Functie, B.Greutate, B.Dimensiuni
    FROM PersonalAeroport PA
    INNER JOIN Bagaje B ON PA.ID_Angajat = B.PasagerID
)
SELECT AB.Nume, AB.Prenume, AB.Functie, AB.Greutate, AB.Dimensiuni
FROM AngajatiSiBagaje AB;

--83		 Procedură stocată pentru a actualiza statusul bagajului și locația în funcție de data de actualizare

CREATE PROCEDURE ActualizareStatusBagaj
    @BagajID INT,
    @Status NVARCHAR(50),
    @DataActualizare DATETIME,
    @Locatie NVARCHAR(100)
AS
BEGIN
    UPDATE UrmarireBagaje
    SET Status = @Status, DataActualizare = @DataActualizare, Locatie = @Locatie
    WHERE BagajID = @BagajID;
END;


--84		 Procedură stocată pentru a calcula durata medie a zborurilor pentru fiecare companie aeriană


CREATE PROCEDURE DurataMedieZboruriPeCompanie
AS
BEGIN
    SELECT CA.NumeCompanie, AVG(Z.DurataZbor) AS DurataMedieZbor
    FROM Zboruri Z
    INNER JOIN CompaniiAeriene CA ON Z.CompanieID = CA.ID_Companie
    GROUP BY CA.NumeCompanie;
END;

--85		 Procedură stocată pentru a obține detalii despre un anumit zbor și bagajele asociate unui pasager

CREATE PROCEDURE DetaliiZborSiBagaj
    @PasagerID INT
AS
BEGIN
    SELECT Z.*, B.*
    FROM Zboruri Z
    INNER JOIN Plecari P ON Z.ID_Zbor = P.ZborID
    INNER JOIN Bagaje B ON P.ID_Plecare = B.PasagerID
    WHERE B.PasagerID = @PasagerID;
END;

--86		 Procedură stocată pentru a găsi toți pasagerii care au călătorit cu o anumită companie aeriană

CREATE PROCEDURE PasageriCuCompanieAeriana
    @CompanieID INT
AS
BEGIN
    SELECT DISTINCT P.*
    FROM Pasageri P
    INNER JOIN Bilete B ON P.ID_Pasager = B.PasagerID
    INNER JOIN Zboruri Z ON B.ZborID = Z.ID_Zbor
    WHERE Z.CompanieID = @CompanieID;
END;

 --87		Procedura stocată pentru înregistrarea unei reclamații a unui pasager și adăugarea unei notificări în sistem

 CREATE PROCEDURE InregistrareReclamatiePasager
    @ReclamatieID INT OUTPUT,
    @NotificareID INT OUTPUT
AS
BEGIN
    -- Înregistrare reclamație pasager
    INSERT INTO ReclamatiiPasageri (PasagerID, Descriere)
    VALUES (1, 'Descriere reclamație');

    -- Setare @ReclamatieID cu ID-ul reclamației noi
    SET @ReclamatieID = SCOPE_IDENTITY();

    -- Adăugare notificare în sistem
    INSERT INTO Notificari (ReclamatieID, Mesaj)
    VALUES (@ReclamatieID, 'Reclamație înregistrată cu succes');

    -- Setare @NotificareID cu ID-ul notificării noi
    SET @NotificareID = SCOPE_IDENTITY();
END;

--88		 Procedura stocată pentru rezervarea unui bilet de avion și actualizarea disponibilității bagajului

CREATE PROCEDURE RezervareBilet
    @BiletID INT OUTPUT,
    @Bagaj_ID INT OUTPUT
AS
BEGIN
    -- Rezervare bilet de avion
    INSERT INTO Bilete (ZborID, PasagerID, Clasa, Pret)
    VALUES (1, 1, 'Economy', 100.00);

    -- Setare @BiletID cu ID-ul biletului nou
    SET @BiletID = SCOPE_IDENTITY();

    -- Actualizare disponibilitate bagaj
    UPDATE Bagaje
    SET Pierdut = 1
    OUTPUT INSERTED.Bagaj_ID INTO @BagajID
    WHERE Pierdut = 0;
END;


--89		Procedura stocată pentru actualizarea datelor personale ale unui pasager și generarea unui nou cod de rezervare

CREATE PROCEDURE ActualizareDatePersonalePasager
    @PasagerID INT OUTPUT,
    @CodRezervare NVARCHAR(10) OUTPUT
AS
BEGIN
    -- Actualizare date personale pasager
    UPDATE Pasageri
    SET Nume = 'NumeNou', Prenume = 'PrenumeNou', DataNasterii = '2000-01-01'
    WHERE ID_Pasager = 1;

    -- Setare @PasagerID cu ID-ul pasagerului actualizat
    SET @PasagerID = 1;

    -- Generare cod rezervare nou
    SET @CodRezervare = NEWID();
END;

--90	Procedura stocată pentru înregistrarea unei noi plecări a unui zbor și actualizarea disponibilității echipajului

CREATE PROCEDURE InregistrarePlecareZbor
    @PlecareID INT OUTPUT,
    @EchipajID INT OUTPUT
AS
BEGIN
    -- Declara variabila tabelului @EchipajID pentru a reține ID-ul echipajului
    DECLARE @EchipajID TABLE (ID INT);

    -- Înregistrare plecare zbor
    INSERT INTO Plecari (ZborID, DataPlecare, PoartaPlecare)
    VALUES (1, '2024-01-01', 'A1');

    -- Setare @PlecareID cu ID-ul plecării noi
    SET @PlecareID = SCOPE_IDENTITY();

    -- Actualizare disponibilitate echipaj
    UPDATE EchipajeZbor
    SET TipAeronava = 'Boeing 737'
    OUTPUT INSERTED.ID_Echipaj INTO @EchipajID
    WHERE TipAeronava IS NULL;

    -- Obține ID-ul echipajului actualizat și îl setează în variabila de ieșire @EchipajID
    SELECT TOP 1 @EchipajID = ID FROM @EchipajID;
END;

	


--91		Trigger pentru generarea automată a reclamațiilor pasagerilor

CREATE TRIGGER GenerareReclamatieZborAnulat
ON Plecari
AFTER DELETE
AS
BEGIN
    DECLARE @ZborID INT;
    DECLARE @PasagerID INT;

    SELECT @ZborID = deleted.ZborID, @PasagerID = Bilete.PasagerID
    FROM deleted
    JOIN Bilete ON deleted.ZborID = Bilete.ZborID;

    INSERT INTO ReclamatiiPasageri (PasagerID, Descriere)
    VALUES (@PasagerID, 'Zbor Anulat');
END;





--92		Trigger pentru generarea automată a feedback-urilor pentru zboruri


CREATE TRIGGER GenerareFeedbackZborAnulat
ON Zboruri
AFTER DELETE
AS
BEGIN
    DECLARE @ZborID INT;
    DECLARE @PasagerID INT;

    SELECT @ZborID = deleted.ID_Zbor, @PasagerID = Bilete.PasagerID
    FROM deleted
    JOIN Bilete ON deleted.ID_Zbor = Bilete.ZborID;

    INSERT INTO FeedbackEvaluariZboruri (PasagerID, ZborID, DataFeedback, Comentariu, Nota)
    VALUES (@PasagerID, @ZborID, GETDATE(), 'Zborul a fost anulat.', 1);
END;




--93		Trigger pentru actualizarea automată a datei de angajare pentru noul personal


CREATE TRIGGER ActualizareDataAngajare
ON PersonalAeroport
AFTER INSERT
AS
BEGIN
    UPDATE PersonalAeroport
    SET DataAngajare = GETDATE()
    WHERE ID_Angajat IN (SELECT ID_Angajat FROM inserted);
END;


--94		Trigger pentru înregistrarea automată a reclamațiilor pasagerilor la zborurile anulate

CREATE TRIGGER InregistrareReclamatieZborAnulat
ON Plecari
AFTER DELETE
AS
BEGIN
    INSERT INTO ReclamatiiPasageri (PasagerID, Descriere)
    SELECT Bilete.PasagerID, 'Zbor Anulat'
    FROM deleted
    JOIN Bilete ON deleted.ZborID = Bilete.ZborID;
END;



--95		Trigger pentru actualizarea automată a nivelului de securitate maxim al aeroportului


CREATE TRIGGER ActualizareNivelSecuritateMaximAeroport
ON SistemSecuritateAeroport
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @NivelMaxim INT;
    SELECT @NivelMaxim = MAX(NivelSecuritate) FROM SistemSecuritateAeroport;
    UPDATE SistemSecuritateAeroport
    SET Activ = (CASE WHEN NivelSecuritate = @NivelMaxim THEN 1 ELSE 0 END)
    WHERE NivelSecuritate = @NivelMaxim;
END;



--96		Procedura stocată pentru adăugarea unui nou pasager


CREATE PROCEDURE AdaugaPasager
    @Nume NVARCHAR(50),
    @Prenume NVARCHAR(50),
    @DataNasterii DATE,
    @Gen NVARCHAR(10),
    @Adresa NVARCHAR(100),
    @NumarTelefon NVARCHAR(20),
    @Email NVARCHAR(100),
    @CNP NVARCHAR(13)
AS
BEGIN
    INSERT INTO Pasageri (Nume, Prenume, DataNasterii, Gen, Adresa, NumarTelefon, Email, CNP)
    VALUES (@Nume, @Prenume, @DataNasterii, @Gen, @Adresa, @NumarTelefon, @Email, @CNP);
END;


--97		Procedura stocată pentru actualizarea informațiilor despre un pasager

CREATE PROCEDURE ActualizeazaInformatiiPasager
    @ID_Pasager INT,
    @Nume NVARCHAR(50),
    @Prenume NVARCHAR(50),
    @DataNasterii DATE,
    @Gen NVARCHAR(10),
    @Adresa NVARCHAR(100),
    @NumarTelefon NVARCHAR(20),
    @Email NVARCHAR(100),
    @CNP NVARCHAR(13)
AS
BEGIN
    UPDATE Pasageri
    SET Nume = @Nume, Prenume = @Prenume, DataNasterii = @DataNasterii, Gen = @Gen, Adresa = @Adresa,
        NumarTelefon = @NumarTelefon, Email = @Email, CNP = @CNP
    WHERE ID_Pasager = @ID_Pasager;
END;


--98		Procedura stocată pentru ștergerea unui pasager și a tuturor datelor asociate acestuia

CREATE PROCEDURE StergePasager
    @ID_Pasager INT
AS
BEGIN
    DELETE FROM Bagaje WHERE PasagerID = @ID_Pasager;
    DELETE FROM Bilete WHERE PasagerID = @ID_Pasager;
    DELETE FROM ReclamatiiPasageri WHERE PasagerID = @ID_Pasager;
    DELETE FROM Pasageri WHERE ID_Pasager = @ID_Pasager;
END;


DECLARE @ID_Pasager INT = 123; -- ID-ul pasagerului pe care dorești să-l actualizezi
DECLARE @Nume NVARCHAR(50) = 'NoulNume';
DECLARE @Prenume NVARCHAR(50) = 'NoulPrenume';
DECLARE @DataNasterii DATE = '1990-01-01';
DECLARE @Gen NVARCHAR(10) = 'Masculin';
DECLARE @Adresa NVARCHAR(100) = 'Adresa nouă';
DECLARE @NumarTelefon NVARCHAR(20) = '1234567890';
DECLARE @Email NVARCHAR(100) = 'noul@email.com';
DECLARE @CNP NVARCHAR(13) = '1234567890123';

EXEC ActualizeazaInformatiiPasager 
    @ID_Pasager = @ID_Pasager,
    @Nume = @Nume,
    @Prenume = @Prenume,
    @DataNasterii = @DataNasterii,
    @Gen = @Gen,
    @Adresa = @Adresa,
    @NumarTelefon = @NumarTelefon,
    @Email = @Email,
    @CNP = @CNP;

-- Apelare și execuție pentru procedura StergePasager
DECLARE @ID_PasagerToDelete INT = 123; -- ID-ul pasagerului pe care dorești să-l ștergi

EXEC StergePasager @ID_Pasager = @ID_PasagerToDelete;




--99		Procedura stocată pentru obținerea informațiilor despre toți pasagerii


CREATE PROCEDURE AfiseazaTotiPasagerii
AS
BEGIN
    SELECT * FROM Pasageri;
END;




--100		Procedura stocată pentru căutarea unui pasager după nume și prenume


CREATE PROCEDURE CautaPasager
    @Nume NVARCHAR(50),
    @Prenume NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Pasageri WHERE Nume = @Nume AND Prenume = @Prenume;
END;





--101		Procedura stocată pentru obținerea tuturor informațiilor despre un zbor în funcție de destinație și dată


CREATE PROCEDURE InfoZboruriDestinatieData
    @OrasDestinatie NVARCHAR(100),
    @DataPlecare DATE
AS
BEGIN
    SELECT Z.ID_Zbor, CA.NumeCompanie, D.OrasDestinatie, D.TaraDestinatie, Z.DataPlecare, Z.OraPlecare
    FROM Zboruri Z
    INNER JOIN CompaniiAeriene CA ON Z.CompanieID = CA.ID_Companie
    INNER JOIN Destinatii D ON Z.DestinatieID = D.ID_Destinatie
    WHERE D.OrasDestinatie = @OrasDestinatie AND Z.DataPlecare = @DataPlecare;
END;


--102		Procedura stocată pentru adăugarea unui nou zbor și programul său asociat

CREATE PROCEDURE AdaugaZborSiProgram
    @CompanieID INT,
    @DestinatieID INT,
    @DataPlecare DATE,
    @OraPlecare TIME,
    @OraSosireProgram TIME,
    @PoartaImbarcare NVARCHAR(10)
AS
BEGIN
    BEGIN TRANSACTION;
    DECLARE @ZborID INT;

    INSERT INTO Zboruri (CompanieID, DestinatieID, DataPlecare, OraPlecare)
    VALUES (@CompanieID, @DestinatieID, @DataPlecare, @OraPlecare);

    SET @ZborID = SCOPE_IDENTITY();

    INSERT INTO ProgramZboruri (ZborID, OraPlecareProgram, OraSosireProgram, PoartaImbarcare)
    VALUES (@ZborID, @OraPlecare, @OraSosireProgram, @PoartaImbarcare);

    COMMIT;
END;





--103		Procedura stocată pentru actualizarea informațiilor despre un zbor și programul său asociat

CREATE PROCEDURE ActualizeazaZborSiProgram
    @ZborID INT,
    @CompanieID INT,
    @DestinatieID INT,
    @DataPlecare DATE,
    @OraPlecare TIME,
    @OraSosireProgram TIME,
    @PoartaImbarcare NVARCHAR(10)
AS
BEGIN
    BEGIN TRANSACTION;

    UPDATE Zboruri
    SET CompanieID = @CompanieID, DestinatieID = @DestinatieID, DataPlecare = @DataPlecare, OraPlecare = @OraPlecare
    WHERE ID_Zbor = @ZborID;

    UPDATE ProgramZboruri
    SET OraPlecareProgram = @OraPlecare, OraSosireProgram = @OraSosireProgram, PoartaImbarcare = @PoartaImbarcare
    WHERE ZborID = @ZborID;

    COMMIT;
END;


--104		Procedura stocată pentru ștergerea unui zbor și a programului său asociat



CREATE PROCEDURE StergeZborSiProgram @ZborID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Șterge toate înregistrările asociate cu zborul din FeedbackEvaluariZboruri
    DELETE FROM FeedbackEvaluariZboruri WHERE ZborID = @ZborID;

    -- Șterge programul zborului
    DELETE FROM ProgramZboruri WHERE ZborID = @ZborID;

    -- Șterge zborul
    DELETE FROM Zboruri WHERE ID_Zbor = @ZborID;
END





--105		Procedura stocată pentru calcularea prețului total al unui bilet în funcție de zbor și clasă

CREATE PROCEDURE CalculPretBilet
    @ZborID INT,
    @Clasa NVARCHAR(20)
AS
BEGIN
    DECLARE @PretBaza MONEY;
    DECLARE @Discount DECIMAL(5, 2) = 0.0;

    SELECT @PretBaza = Pret
    FROM Bilete
    WHERE ZborID = @ZborID AND Clasa = @Clasa;

    -- Implementarea logicii pentru discounturi sau promoții în funcție de anumite criterii

    SELECT @PretBaza * (1 - @Discount) AS PretTotal;
END;








EXEC InfoZboruriDestinatieData 'Singapore', '2024-03-20';

EXEC ActualizeazaZborSiProgram 3, 2, 4, '2024-05-30', '10:00:00', '14:00:00', 'GATE B2';

EXEC CalculPretBilet 4, 'Economy';







	
	--106		Actualizeze codul IATA pentru o
	--companie aeriană dată plus actualizarea  compani_ID în tabela Zboruri
	
	
	
	CREATE PROCEDURE ActualizareDate
    @NumeCompanie NVARCHAR(100),
    @NouCodIATA NVARCHAR(3),
    @NumarLiniiAfectateCompanii INT OUTPUT,
    @NumarLiniiAfectateZboruri INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    
	--Actualizam tabea CompaniiAeriene cu nol cod iata conform numelui care este dat ca parametru
    UPDATE CompaniiAeriene
    SET CodIATA = @NouCodIATA
    WHERE NumeCompanie = @NumeCompanie;

    SET @NumarLiniiAfectateCompanii = @@ROWCOUNT;

    --Nu uitam sa actualizam si in table Zboruri, conform modificarii precedente ,astfel ne folosim de selecturi:
    UPDATE Zboruri
    SET CompanieID = (SELECT ID_Companie FROM CompaniiAeriene WHERE NumeCompanie = @NumeCompanie)
    WHERE CompanieID IN (SELECT ID_Companie FROM CompaniiAeriene WHERE NumeCompanie = @NumeCompanie);

    SET @NumarLiniiAfectateZboruri = @@ROWCOUNT;
END;


--executarea procedurii:
DECLARE @NumarLiniiCompanii INT,
        @NumarLiniiZboruri INT;
EXEC ActualizareDate 'Lufthansa', 'LH', @NumarLiniiCompanii OUTPUT, @NumarLiniiZboruri OUTPUT;

SELECT 'Numarul de linii afectate in tabela CompaniiAeriene: ' + CAST(@NumarLiniiCompanii AS NVARCHAR(10)),
       'Numarul de linii afectate in tabela Zboruri: ' + CAST(@NumarLiniiZboruri AS NVARCHAR(10));



	   

	   ---------------------------------------------------------------------------------
 -- 107		Crearea trigger-ului AFTER INSERT pentru tabela Bilete: actualizam prograul de zbor dupa inserarea unui nou bilet (achizitia sa)


CREATE TRIGGER ActualizareProgramZboruri
ON Bilete
AFTER INSERT
AS
BEGIN
    -- Actualizarea programului de zboruri după inserarea unui nou bilet
    UPDATE ProgramZboruri
    SET OraSosireProgram = DATEADD(MINUTE, 30, OraSosireProgram)
    WHERE ZborID IN (SELECT ZborID FROM inserted);
END;

--executarea:
INSERT INTO Bilete (ID_Bilet,ZborID, PasagerID, Clasa, Pret)
VALUES (20,1, 1, 'Economy', 150.00);







--108		inserarea de date in tabella Sosiri, (am inserat mai mult de 22 date, parametrii pt nu a avea campuri NULL, va vor incurca in interogari ulterioare)
--tratarea exceptiilor: cea mai comuna PK duplicat

CREATE PROCEDURE InserareSosireCuTranzactie
    @ID_Sosire INT,
    @ZborID INT,
    @DataSosire DATETIME,
    @PoartaSosire NVARCHAR(10)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION; 

        -- inserare
        INSERT INTO Sosiri (ID_Sosire, ZborID, DataSosire, PoartaSosire)
        VALUES (@ID_Sosire, @ZborID, @DataSosire, @PoartaSosire);

       
        COMMIT TRANSACTION; 
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION; 
        -- verificare eroare de tip primary key 
        IF ERROR_NUMBER() = 2627
        BEGIN
            -- tratare cu mesaj
            THROW 50001, 'ID-ul de sosir introdus acum există deja în tabela de Sosiri', 1;
        END
        ELSE
        BEGIN
            THROW;
        END
    END CATCH;
END;

--Executia sa:
EXEC InserareSosireCuTranzactie 
    @ID_Sosire = 21, 
    @ZborID = 2, 
    @DataSosire = '2024-07-25 12:15:00', 
    @PoartaSosire = 'B3';






	--109		Procedură stocată pentru a găsi detalii despre bagajele pierdute pentru un anumit zbor

	CREATE PROCEDURE BagajePierdutePeZbor
    @ZborID INT
AS
BEGIN
    SELECT B.*
    FROM Plecari P
    INNER JOIN Bagaje B ON P.ID_Plecare = B.PasagerID
    INNER JOIN UrmarireBagaje UB ON B.ID_Bagaj = UB.BagajID
    WHERE P.ZborID = @ZborID AND UB.Status = 'Pierdut';
END;




	--------------------------------------------------------

	--110		carearea de tranzactie in care se fac 3 inerturi,updateuri si delte
	--inserare de date si actualizare restul tabelellor


DECLARE @NumeCompanie NVARCHAR(100) = 'FineFlierCompany';
DECLARE @OrasDestinatie NVARCHAR(100) = 'Seattle';
DECLARE @DataPlecare DATE = '2024-06-01';
DECLARE @OraPlecare TIME = '08:00';
DECLARE @Nume NVARCHAR(50) = 'Adam';
DECLARE @Prenume NVARCHAR(50) = 'Stones';
DECLARE @DataNasterii DATE = '1993-01-15';
DECLARE @Gen NVARCHAR(10) = 'Masculin';
DECLARE @AeroportDestinatie NVARCHAR(100)='Kingstones'
DECLARE @TaraDestinatie NVARCHAR(100)='SUA'

BEGIN TRANSACTION TranzactieCompleta;

BEGIN TRY
    -- inserari in tabele
    INSERT INTO CompaniiAeriene (ID_Companie,NumeCompanie, CodIATA, CodICAO)
    VALUES (22, @NumeCompanie,'A5', 'ABC');

    INSERT INTO Destinatii (ID_Destinatie,OrasDestinatie, TaraDestinatie, AeroportDestinatie)
    VALUES (22,@OrasDestinatie , @TaraDestinatie, @AeroportDestinatie);

    INSERT INTO Zboruri (ID_Zbor,CompanieID, DestinatieID, DataPlecare, OraPlecare)
    SELECT 22,CA.ID_Companie, D.ID_Destinatie, @DataPlecare, @OraPlecare
    FROM CompaniiAeriene CA
    INNER JOIN Destinatii D ON CA.NumeCompanie = @NumeCompanie AND D.OrasDestinatie = @OrasDestinatie;

    -- update-uri
    UPDATE Zboruri
    SET DataPlecare = @DataPlecare
    WHERE CompanieID = (SELECT ID_Companie FROM CompaniiAeriene WHERE NumeCompanie = @NumeCompanie)
    AND DestinatieID = (SELECT ID_Destinatie FROM Destinatii WHERE OrasDestinatie = @OrasDestinatie);

    -- delete-uri
    DELETE FROM Zboruri
    WHERE CompanieID = (SELECT ID_Companie FROM CompaniiAeriene WHERE NumeCompanie = @NumeCompanie)
    AND DestinatieID = (SELECT ID_Destinatie FROM Destinatii WHERE OrasDestinatie = @OrasDestinatie);

    COMMIT TRANSACTION TranzactieCompleta;
END TRY
BEGIN CATCH
--tratare de roare
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION TranzactieCompleta;
		--cod sugestiv , print declararea unui error message
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    PRINT 'A apărut o eroare: ' + @ErrorMessage;
END CATCH;







--111		Actualizarea nivelului de securitate al sistemului de securitate al aeroportului

DECLARE @errnum AS INT;

BEGIN TRAN;

UPDATE SistemSecuritateAeroport
SET NivelSecuritate = 4
WHERE TipSistem = 'Sistem de scanare corporală'; 

SET @errnum = @@ERROR;
IF @errnum <> 0
BEGIN
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    PRINT 'Actualizarea nivelului de securitate a eșuat: eroare ' + CAST(@errnum AS VARCHAR);
END;

IF @@TRANCOUNT > 0 COMMIT TRAN;





--112		Adaugarea unui serviciu nou în baza de date


DECLARE @errnum AS INT;

BEGIN TRAN;

INSERT INTO ServiciiAeroport (ID_Serviciu,NumeServiciu, Descriere, Pret)
VALUES (11,'Wi-Fi Premium', 'Serviciu Wi-Fi de înaltă viteză pentru pasageri', 9.99); -- Insert #1

SET @errnum = @@ERROR;
IF @errnum <> 0
BEGIN
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    PRINT 'Adăugarea serviciului a eșuat: eroare ' + CAST(@errnum AS VARCHAR);
END;

IF @@TRANCOUNT > 0 COMMIT TRAN;





--113		Tranzactie pentru actualizarea magazinului din aeroport dupa id-ul sau 

BEGIN TRY
    BEGIN TRAN;

    UPDATE MagazineAeroport
    SET Program = '08:00 - 22:00'
    WHERE ID_Magazin = 1; --cu id-ul 1

    COMMIT TRAN;
    PRINT 'Programul magazinului din aeroport a fost actualizat cu succes.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    SELECT 
        ERROR_NUMBER() AS errornumber, 
        ERROR_MESSAGE() AS errormessage, 
        ERROR_LINE() AS errorline, 
        ERROR_SEVERITY() AS errorseverity, 
        ERROR_STATE() AS errorstate; 
    PRINT 'Actualizarea programului magazinului din aeroport a eșuat.';
END CATCH;








 -- 114		Tranzactia aceasta simuleaza o plasare de reclamatie si actualizare starea bagajului asociat


BEGIN TRY
    BEGIN TRAN;

    DECLARE @PasagerID INT, @BagajID INT;

    -- Pasagerul plasează o reclamație
    INSERT INTO ReclamatiiPasageri (PasagerID, Descriere)
    VALUES (3, 'Bagajul nu a fost găsit la sosire.');

    -- obtinerea de id reclamatie
    SET @BagajID = (SELECT TOP 1 ID_Bagaj FROM Bagaje WHERE PasagerID = 3);

    -- starea bazajului este actualizata
    UPDATE Bagaje
    SET Pierdut = 1
    WHERE ID_Bagaj = @BagajID;

    COMMIT TRAN;
    PRINT 'Reclamația a fost plasată cu succes și starea bagajului a fost actualizată.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    SELECT 
        ERROR_NUMBER() AS errornumber, 
        ERROR_MESSAGE() AS errormessage, 
        ERROR_LINE() AS errorline, 
        ERROR_SEVERITY() AS errorseverity, 
        ERROR_STATE() AS errorstate; 
    PRINT 'Plasarea reclamației sau actualizarea stării bagajului a eșuat.';
END CATCH;





--115		pregatire si actualizare explicita a tabelei Zbor pentru exectuarea tranzactiei:
ALTER TABLE Zboruri
ADD LocuriDisponibile INT DEFAULT 0;


INSERT INTO Zboruri (ID_Zbor, CompanieID, DestinatieID, DataPlecare, OraPlecare, DurataZbor, LocuriDisponibile)
VALUES
    (21, 5, 1, '2024-03-20', '08:00:00', 270,150),
    (23, 2, 3, '2024-03-21', '10:30:00', 135,200),
    (24, 3, 8, '2024-03-22', '12:45:00', 180,300),
    (25, 4, 5, '2024-03-23', '15:15:00', 345,400);
   

   --aceasta tranzactie efectueaza urmatoarele actiuni:

--Actualizeaza stocul de locuri disponibile pentru un anumit zbor din tabelul Zboruri
--Genereaza un bilet pentru rezervarea plasata de un anumit pasager in tabelul Bilete
--Afiseaza un mesaj de confirmare in cazul in care tranzactia este finalizata cu succes
--In caz de eroare tranzactia va fi anulata iar detalii despre eroare vor fi afisate

BEGIN TRY
    BEGIN TRAN;

  
    DECLARE @PasagerID INT, @ZborID INT, @BiletID INT;

   
    SET @PasagerID = 5;--hardcoded
    SET @ZborID = 3;--hardcoded

   
    UPDATE Zboruri
    SET LocuriDisponibile = LocuriDisponibile - 1
    WHERE ID_Zbor = @ZborID;

   
    INSERT INTO Bilete (ID_Bilet,ZborID, PasagerID, Clasa, Pret)
    VALUES (12,@ZborID, @PasagerID, 'Economy', 250.00);--biletu cu id: 12 hardcodat!!!

  
    SET @BiletID = (SELECT SCOPE_IDENTITY());

    
    PRINT 'Rezervarea a fost plasată cu succes. ID-ul biletului: ' + CAST(@BiletID AS NVARCHAR(10));

    COMMIT TRAN;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    SELECT 
        ERROR_NUMBER() AS errornumber, 
        ERROR_MESSAGE() AS errormessage, 
        ERROR_LINE() AS errorline, 
        ERROR_SEVERITY() AS errorseverity, 
        ERROR_STATE() AS errorstate; 
    PRINT 'Plasarea rezervării a eșuat.';
END CATCH;







--116		Tranzactie: Inserare de date multiple cu tratarea erorilor
--eroarea: 2627 prezenta pentru exemplificarea tratarii erorilor, afisarea ei (Violation of Unique Key)
BEGIN TRY
    BEGIN TRAN;

    -- inserare in tabela CompaniiAeriene
    INSERT INTO CompaniiAeriene (ID_Companie,NumeCompanie, CodIATA, CodICAO, AdresaSediuCentral)
    VALUES (23,'American Airlines', 'AA', 'AAL', '123 Main Street, New York');

    -- inserare in tabela Destinatii
    INSERT INTO Destinatii (OrasDestinatie, TaraDestinatie, AeroportDestinatie)
    VALUES ('Paris', 'Franta', 'CDG');

    -- inserare in tabela Zboruri
    DECLARE @CompanieID INT, @DestinatieID INT;
    SELECT @CompanieID = SCOPE_IDENTITY();
    SELECT @DestinatieID = SCOPE_IDENTITY();

    INSERT INTO Zboruri (ID_Zbor,CompanieID, DestinatieID, DataPlecare, OraPlecare)
    VALUES (23,@CompanieID, @DestinatieID, '2024-06-01', '10:00');

    -- inserare in tabela ProgramZboruri
    DECLARE @ZborID INT;
    SELECT @ZborID = SCOPE_IDENTITY();

    INSERT INTO ProgramZboruri (ZborID, OraPlecareProgram, OraSosireProgram, PoartaImbarcare)
    VALUES (@ZborID, '09:30', '12:30', 'A1');

    -- inserare in tabela Pasageri
    INSERT INTO Pasageri (Nume, Prenume, DataNasterii, Gen, Adresa, NumarTelefon, Email)
    VALUES ('Popescu', 'Ana', '1990-03-15', 'F', 'Str. Libertatii, nr. 10, Bucuresti', '0722123456', 'ana.popescu@example.com');

    -- inserare in tabela Bilete
    DECLARE @PasagerID INT;
    SELECT @PasagerID = SCOPE_IDENTITY();

    INSERT INTO Bilete (ZborID, PasagerID, Clasa, Pret)
    VALUES (@ZborID, @PasagerID, 'Economy', 500.00);

    -- Afisare mesaj de confirmare
    PRINT 'Rezervarea a fost plasata cu succes.';

    COMMIT TRAN;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;

    SELECT 
        ERROR_NUMBER() AS errornumber, 
        ERROR_MESSAGE() AS errormessage, 
        ERROR_LINE() AS errorline, 
        ERROR_SEVERITY() AS errorseverity, 
        ERROR_STATE() AS errorstate; 

    PRINT 'Plasarea rezervarii a esuat.';
END CATCH;







--117		pregatire si actualizare explicita a tabelei Zbor pentru exectuarea tranzactiei:
ALTER TABLE Zboruri
    ADD LocuriRezervate INT DEFAULT 0;
   
   INSERT INTO Zboruri (ID_Zbor, CompanieID, DestinatieID, DataPlecare, OraPlecare, DurataZbor, LocuriDisponibile,LocuriRezervate)
VALUES
    (26, 8, 5, '2024-04-24', '08:30:00', 470,150,10),
    (27, 1, 7, '2024-01-21', '10:45:00', 235,400,202),
    (28, 10, 12, '2024-07-29', '15:35:00', 180,200,45),
    (29, 11, 2, '2024-05-22', '19:15:00', 100,100,34);



	--Aceasta tranzactie incearca sa adauge o noua coloana LocuriRezervate in tabela Zboruri. 
	--Daca operatia este finalizata cu succes, coloana este initializata cu valoarea implicita 0 pentru fiecare zbor. 
	--Daca apare o eroare in timpul procesului, tranzactia este anulata, iar detalii despre eroare sunt afisate.

BEGIN TRY
    BEGIN TRAN;

    -- Se actualizează stocul de locuri disponibile pentru un anumit zbor din tabelul Zboruri
    DECLARE @ZborID INT, @LocuriRezervate INT;

    -- Se alege un zbor disponibil pentru a plasa o rezervare
    SELECT TOP 1 @ZborID = ID_Zbor, @LocuriRezervate = LocuriRezervate
    FROM Zboruri
    WHERE DataPlecare >= GETDATE() AND LocuriRezervate < LocuriDisponibile
    ORDER BY DataPlecare;

    -- Dacă nu există zboruri disponibile, se generează o eroare
    IF @ZborID IS NULL
    BEGIN
        THROW 50001, 'Nu există zboruri disponibile pentru rezervare în acest moment.', 1;
    END

    -- Se actualizează stocul de locuri disponibile pentru zborul selectat
    UPDATE Zboruri
    SET LocuriRezervate = LocuriRezervate + 1
    WHERE ID_Zbor = @ZborID;

    -- Se generează un bilet pentru rezervarea plasată de un anumit pasager în tabelul Bilete
    DECLARE @PasagerID INT, @BiletID INT;

    -- Se inserează un nou pasager în cazul în care nu există deja
    IF NOT EXISTS (SELECT 1 FROM Pasageri WHERE Nume = 'Doe' AND Prenume = 'John')
    BEGIN
	   INSERT INTO Pasageri (ID_Pasager, Nume, Prenume, DataNasterii, CNP, Gen, Adresa, NumarTelefon, Email)
       VALUES (51, 'Doe', 'John', '1985-05-20', '098384672893', 'Masculin', 'Str. Centrală, nr. 20, București', '0723123456', 'john.doe@example.com');
    END

    -- Se obține ID-ul pasagerului
    SELECT @PasagerID = ID_Pasager FROM Pasageri WHERE Nume = 'Doe' AND Prenume = 'John';

    -- Se generează biletul pentru pasagerul și zborul selectat
    INSERT INTO Bilete (ID_Bilet,ZborID, PasagerID, Clasa, Pret)
    VALUES (13,@ZborID, @PasagerID, 'Economy', 250.00);

    -- Se obține ID-ul biletului generat
    SELECT @BiletID = SCOPE_IDENTITY();

    -- Se afișează un mesaj de confirmare în cazul în care tranzacția este finalizată cu succes
    PRINT 'Rezervarea pentru zborul cu ID-ul ' + CAST(@ZborID AS NVARCHAR(10)) + ' a fost plasată cu succes. ID-ul biletului: ' + CAST(@BiletID AS NVARCHAR(10));

    COMMIT TRAN;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;

    SELECT 
        ERROR_NUMBER() AS errornumber, 
        ERROR_MESSAGE() AS errormessage, 
        ERROR_LINE() AS errorline, 
        ERROR_SEVERITY() AS errorseverity, 
        ERROR_STATE() AS errorstate; 

    PRINT 'Plasarea rezervării a eșuat.';
END CATCH;







