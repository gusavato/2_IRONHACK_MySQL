-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Video_Club
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Video_Club
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Video_Club` DEFAULT CHARACTER SET utf8 ;
USE `Video_Club` ;

-- -----------------------------------------------------
-- Table `Video_Club`.`Actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Actors` (
  `Id_Actors` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Actors`),
  UNIQUE INDEX `Id_Actors_UNIQUE` (`Id_Actors` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Category` (
  `Id_Category` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(20) CHARACTER SET 'armscii8' NOT NULL,
  PRIMARY KEY (`Id_Category`),
  UNIQUE INDEX `Id_Category_UNIQUE` (`Id_Category` ASC) VISIBLE,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Films`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Films` (
  `Id_Films` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(300) NULL,
  `Release_year` YEAR NULL,
  `Category_Id` INT NOT NULL,
  `Rent_duration` INT NULL,
  `Rent_rate` FLOAT NOT NULL,
  `Length` INT NULL,
  `Replacement_cost` FLOAT NOT NULL,
  `Rating` VARCHAR(15) NULL,
  `Special_features` VARCHAR(60) NULL,
  PRIMARY KEY (`Id_Films`, `Category_Id`),
  UNIQUE INDEX `ID_Films_UNIQUE` (`Id_Films` ASC) VISIBLE,
  INDEX `fk_Films_Category1_idx` (`Category_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Films_Category1`
    FOREIGN KEY (`Category_Id`)
    REFERENCES `Video_Club`.`Category` (`Id_Category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Languages` (
  `ID_Languages` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID_Languages`),
  UNIQUE INDEX `ID_Languages_UNIQUE` (`ID_Languages` ASC) VISIBLE,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Films_Original`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Films_Original` (
  `Films_Id` INT NOT NULL,
  `Languages_Id` INT NOT NULL,
  PRIMARY KEY (`Films_Id`, `Languages_Id`),
  INDEX `fk_Films_has_Languages_Languages1_idx` (`Languages_Id` ASC) VISIBLE,
  INDEX `fk_Films_has_Languages_Films_idx` (`Films_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Films_has_Languages_Films`
    FOREIGN KEY (`Films_Id`)
    REFERENCES `Video_Club`.`Films` (`Id_Films`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Films_has_Languages_Languages1`
    FOREIGN KEY (`Languages_Id`)
    REFERENCES `Video_Club`.`Languages` (`ID_Languages`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Films_Languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Films_Languages` (
  `Films_Id` INT NOT NULL,
  `Languages_Id` INT NOT NULL,
  PRIMARY KEY (`Films_Id`, `Languages_Id`),
  INDEX `fk_Films_has_Languages1_Languages1_idx` (`Languages_Id` ASC) VISIBLE,
  INDEX `fk_Films_has_Languages1_Films1_idx` (`Films_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Films_has_Languages1_Films1`
    FOREIGN KEY (`Films_Id`)
    REFERENCES `Video_Club`.`Films` (`Id_Films`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Films_has_Languages1_Languages1`
    FOREIGN KEY (`Languages_Id`)
    REFERENCES `Video_Club`.`Languages` (`ID_Languages`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Stores` (
  `Id_Stores` INT NOT NULL AUTO_INCREMENT,
  `Adress` VARCHAR(80) NOT NULL,
  `Postal_code` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_Stores`),
  UNIQUE INDEX `Id_Stores_UNIQUE` (`Id_Stores` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Copies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Copies` (
  `Id_Copy` INT NOT NULL AUTO_INCREMENT,
  `Is_rent` TINYINT NOT NULL,
  `Copiescol` VARCHAR(45) NULL,
  `Films_Id` INT NOT NULL,
  `Store_Id` INT NOT NULL,
  PRIMARY KEY (`Id_Copy`, `Films_Id`, `Store_Id`),
  UNIQUE INDEX `Id_Rental_UNIQUE` (`Id_Copy` ASC) VISIBLE,
  INDEX `fk_Copies_Films1_idx` (`Films_Id` ASC) VISIBLE,
  INDEX `fk_Copies_Stores1_idx` (`Store_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Copies_Films1`
    FOREIGN KEY (`Films_Id`)
    REFERENCES `Video_Club`.`Films` (`Id_Films`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Copies_Stores1`
    FOREIGN KEY (`Store_Id`)
    REFERENCES `Video_Club`.`Stores` (`Id_Stores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Directors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Directors` (
  `Id_Directors` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Directors`),
  UNIQUE INDEX `Id_Actors_UNIQUE` (`Id_Directors` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Director_Film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Director_Film` (
  `Films_Id` INT NOT NULL,
  `Directors_Id` INT NOT NULL,
  PRIMARY KEY (`Films_Id`, `Directors_Id`),
  INDEX `fk_Films_has_Directors_Directors1_idx` (`Directors_Id` ASC) VISIBLE,
  INDEX `fk_Films_has_Directors_Films1_idx` (`Films_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Films_has_Directors_Films1`
    FOREIGN KEY (`Films_Id`)
    REFERENCES `Video_Club`.`Films` (`Id_Films`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Films_has_Directors_Directors1`
    FOREIGN KEY (`Directors_Id`)
    REFERENCES `Video_Club`.`Directors` (`Id_Directors`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Actor_Film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Actor_Film` (
  `Actors_Id_Actors` INT NOT NULL,
  `Films_Id_Films` INT NOT NULL,
  PRIMARY KEY (`Actors_Id_Actors`, `Films_Id_Films`),
  INDEX `fk_Actors_has_Films_Films1_idx` (`Films_Id_Films` ASC) VISIBLE,
  INDEX `fk_Actors_has_Films_Actors1_idx` (`Actors_Id_Actors` ASC) VISIBLE,
  CONSTRAINT `fk_Actors_has_Films_Actors1`
    FOREIGN KEY (`Actors_Id_Actors`)
    REFERENCES `Video_Club`.`Actors` (`Id_Actors`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actors_has_Films_Films1`
    FOREIGN KEY (`Films_Id_Films`)
    REFERENCES `Video_Club`.`Films` (`Id_Films`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Employees` (
  `id_Employee` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Last_name` VARCHAR(45) NOT NULL,
  `Adress` VARCHAR(80) NOT NULL,
  `Postal_code` VARCHAR(45) NOT NULL,
  `Document_Id` VARCHAR(20) NOT NULL,
  `Store_Id` INT NOT NULL,
  PRIMARY KEY (`id_Employee`, `Store_Id`),
  UNIQUE INDEX `id_Employee_UNIQUE` (`id_Employee` ASC) VISIBLE,
  UNIQUE INDEX `Document_Id_UNIQUE` (`Document_Id` ASC) VISIBLE,
  INDEX `fk_Employees_Stores1_idx` (`Store_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Employees_Stores1`
    FOREIGN KEY (`Store_Id`)
    REFERENCES `Video_Club`.`Stores` (`Id_Stores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Customers` (
  `Id_Customer` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Last_name` VARCHAR(45) NOT NULL,
  `Adress` VARCHAR(80) NOT NULL,
  `Document_Id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_Customer`),
  UNIQUE INDEX `Id_Customer_UNIQUE` (`Id_Customer` ASC) VISIBLE,
  UNIQUE INDEX `Document_Id_UNIQUE` (`Document_Id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Video_Club`.`Rent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Video_Club`.`Rent` (
  `ID_Rent` INT NOT NULL AUTO_INCREMENT,
  `Customers_Id` INT NOT NULL,
  `Copy_Id` INT NOT NULL,
  `Rental_date` DATETIME NOT NULL,
  `Expired_date` DATETIME NULL,
  `Employee_Id` INT NOT NULL,
  PRIMARY KEY (`ID_Rent`, `Customers_Id`, `Copy_Id`, `Employee_Id`),
  UNIQUE INDEX `ID_Rent_UNIQUE` (`ID_Rent` ASC) VISIBLE,
  INDEX `fk_Rent_Copies1_idx` (`Copy_Id` ASC) VISIBLE,
  INDEX `fk_Rent_Employees1_idx` (`Employee_Id` ASC) VISIBLE,
  INDEX `fk_Rent_Customers1_idx` (`Customers_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Rent_Copies1`
    FOREIGN KEY (`Copy_Id`)
    REFERENCES `Video_Club`.`Copies` (`Id_Copy`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rent_Employees1`
    FOREIGN KEY (`Employee_Id`)
    REFERENCES `Video_Club`.`Employees` (`id_Employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rent_Customers1`
    FOREIGN KEY (`Customers_Id`)
    REFERENCES `Video_Club`.`Customers` (`Id_Customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
