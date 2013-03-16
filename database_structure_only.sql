CREATE DATABASE `dm_phase2`;
USE `dm_phase2`;

CREATE TABLE `bus` (
  `Plate_No` varchar(10) NOT NULL,
  `Model` varchar(20) NOT NULL,
  `Capacity` int(11) NOT NULL,
  `Date_Acquired` date NOT NULL,
  PRIMARY KEY (`Plate_No`)
);


CREATE TABLE `card` (
  `Card_ID` int(11) NOT NULL,
  `Owner_NRIC` char(9) NOT NULL,
  `Issued_Date` date NOT NULL,
  `Stored_Value` double NOT NULL,
  `Old_Card_ID` int(11) NOT NULL,
  PRIMARY KEY (`Card_ID`)
);


CREATE TABLE `service` (
  `Service_No` int(11) NOT NULL,
  `Label` varchar(100) NOT NULL,
  `Start_Time` time NOT NULL,
  `End_Time` time NOT NULL,
  `Frequency` int(11) NOT NULL,
  PRIMARY KEY (`Service_No`)
);

CREATE TABLE `staff` (
  `Staff_ID` int(11) NOT NULL,
  `NRIC` char(9) NOT NULL,
  `Staff_Name` varchar(50) NOT NULL,
  `DOB` date NOT NULL,
  `Staff_Type` char(1) NOT NULL,
  PRIMARY KEY (`Staff_ID`)
);



CREATE TABLE `stop` (
  `Stop_No` int(11) NOT NULL,
  `Location_Desp` varchar(100) NOT NULL,
  `Address` varchar(100) NOT NULL,
  PRIMARY KEY (`Stop_No`)
);


CREATE TABLE `admin` (
  `Staff_ID` int(11) NOT NULL,
  `Cubicle_No` int(11) NOT NULL,
  `Job_Title` varchar(255) NOT NULL,
  PRIMARY KEY (`Staff_ID`),
  CONSTRAINT `admin_fk2` FOREIGN KEY (`Staff_ID`) REFERENCES `staff` (`Staff_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
);






CREATE TABLE `driver` (
  `Staff_ID` int(11) NOT NULL,
  `License_No` int(11) NOT NULL,
  `Date_Certified` date NOT NULL,
  PRIMARY KEY (`Staff_ID`),
  CONSTRAINT `driver_fk2` FOREIGN KEY (`Staff_ID`) REFERENCES `staff` (`Staff_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
);






CREATE TABLE `servicestop` (
  `Service_No` int(11) NOT NULL,
  `Stop_No` int(11) NOT NULL,
  `S_Order` int(11) NOT NULL,
  PRIMARY KEY (`Service_No`,`Stop_No`),
  KEY `servicestop_fk2` (`Stop_No`),
  CONSTRAINT `servicestop_fk1` FOREIGN KEY (`Service_No`) REFERENCES `service` (`Service_No`),
  CONSTRAINT `servicestop_fk2` FOREIGN KEY (`Stop_No`) REFERENCES `stop` (`Stop_No`)
);


CREATE TABLE `trip` (
  `Service_No` int(11) NOT NULL,
  `Serial_No` int(11) NOT NULL,
  `Trip_SDT` datetime NOT NULL,
  `Duration` double DEFAULT NULL,
  `Plate_No` varchar(9) DEFAULT NULL,
  `Staff_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Service_No`,`Serial_No`),
  KEY `trip_fk2` (`Plate_No`),
  KEY `trip_fk3` (`Staff_ID`),
  CONSTRAINT `trip_fk5` FOREIGN KEY (`Staff_ID`) REFERENCES `driver` (`Staff_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `trip_fk1` FOREIGN KEY (`Service_No`) REFERENCES `service` (`Service_No`),
  CONSTRAINT `trip_fk2` FOREIGN KEY (`Plate_No`) REFERENCES `bus` (`Plate_No`)
);

CREATE TABLE `remark` (
  `Service_No` int(11) NOT NULL,
  `Serial_No` int(11) NOT NULL,
  `Remark_No` int(11) NOT NULL,
  `Description` text NOT NULL,
  PRIMARY KEY (`Service_No`,`Serial_No`,`Remark_No`),
  CONSTRAINT `remark_fk1` FOREIGN KEY (`Service_No`, `Serial_No`) REFERENCES `trip` (`Service_No`, `Serial_No`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `transaction` (
  `Service_No` int(11) NOT NULL,
  `Card_ID` int(11) NOT NULL,
  `Serial_No` int(11) NOT NULL,
  `Start_Stop_No` int(11) NOT NULL,
  `End_Stop_No` int(11) NOT NULL,
  `Tap_In_Time` time NOT NULL,
  `Tap_Out_Time` time NOT NULL,
  PRIMARY KEY (`Service_No`,`Card_ID`,`Serial_No`,`Start_Stop_No`,`Tap_In_Time`),
  KEY `transcation_fk1` (`Start_Stop_No`),
  KEY `transaction_fk4` (`End_Stop_No`),
  KEY `transaction_fk2` (`Service_No`,`Serial_No`),
  KEY `transcation_fk3` (`Card_ID`),
  CONSTRAINT `transaction_fk2` FOREIGN KEY (`Service_No`, `Serial_No`) REFERENCES `trip` (`Service_No`, `Serial_No`),
  CONSTRAINT `transaction_fk4` FOREIGN KEY (`End_Stop_No`) REFERENCES `stop` (`Stop_No`),
  CONSTRAINT `transcation_fk1` FOREIGN KEY (`Card_ID`) REFERENCES `card` (`Card_ID`),
  CONSTRAINT `transcation_fk3` FOREIGN KEY (`Start_Stop_No`) REFERENCES `stop` (`Stop_No`)
);