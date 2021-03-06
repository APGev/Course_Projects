-- MySQL Script generated by MySQL Workbench
-- Sun Nov 22 12:59:44 2020
-- Model: New Model    Version: 1.1
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema car_rental
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `car_rental` ;

-- -----------------------------------------------------
-- Schema car_rental
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `car_rental` DEFAULT CHARACTER SET utf8 ;
USE `car_rental` ;

-- -----------------------------------------------------
-- Table `car_rental`.`car_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_rental`.`car_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  `price_per_day` DECIMAL(6) NOT NULL,
  `price_per_hour` DECIMAL(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rental`.`car`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_rental`.`car` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `car_type_id` INT NOT NULL,
  `registration_number` VARCHAR(45) NOT NULL,
  `make` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `year` INT NOT NULL,
  `city_mpg` INT NOT NULL,
  `highway_mpg` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  ,
  UNIQUE INDEX `registration_number_UNIQUE` (`registration_number` ASC)  ,
  INDEX `fk_car_car_types1_idx` (`car_type_id` ASC)  ,
  CONSTRAINT `fk_car_car_types1`
    FOREIGN KEY (`car_type_id`)
    REFERENCES `car_rental`.`car_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `car_rental`.`renter_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_rental`.`renter_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `licence_number` VARCHAR(45) NOT NULL,
  `membership_number` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  `street_address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `zip_code` VARCHAR(45) NULL,
  `failed_attempts` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)  ,
  UNIQUE INDEX `licence_number_UNIQUE` (`licence_number` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rental`.`cc_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_rental`.`cc_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cc_name` VARCHAR(45) NOT NULL,
  `cc_number` VARCHAR(16) NOT NULL,
  `cc_exp_month` INT NOT NULL,
  `cc_exp_year` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rental`.`rental_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_rental`.`rental_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rental_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rental`.`rental_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_rental`.`rental_information` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `renter_id` INT NOT NULL,
  `cc_info_id` INT NOT NULL,
  `car_id` INT NOT NULL,
  `rental_time` TIMESTAMP(6) NOT NULL,
  `rental_location` VARCHAR(45) NOT NULL,
  `rental_type` INT NOT NULL,
  `rental_return_date` INT NOT NULL,
  `rental_return_status` INT NOT NULL COMMENT 'This is wether or not the car is returned:\n0: the car is out\n1: the car is returned\n',
  PRIMARY KEY (`id`, `renter_id`, `cc_info_id`, `car_id`),
  INDEX `fk_rental_information_renter_info1_idx` (`renter_id` ASC)  ,
  INDEX `fk_rental_information_car1_idx` (`car_id` ASC)  ,
  INDEX `fk_rental_information_cc_info1_idx` (`cc_info_id` ASC)  ,
  INDEX `fk_rental_information_rental_type1_idx` (`rental_type` ASC)  ,
  CONSTRAINT `fk_rental_information_renter_info1`
    FOREIGN KEY (`renter_id`)
    REFERENCES `car_rental`.`renter_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_information_car1`
    FOREIGN KEY (`car_id`)
    REFERENCES `car_rental`.`car` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_information_cc_info1`
    FOREIGN KEY (`cc_info_id`)
    REFERENCES `car_rental`.`cc_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_information_rental_type1`
    FOREIGN KEY (`rental_type`)
    REFERENCES `car_rental`.`rental_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rental`.`damage_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_rental`.`damage_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `damage_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rental`.`incident_reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_rental`.`incident_reports` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rental_information_id` INT NOT NULL,
  `damage_type_id` INT NOT NULL,
  `damage_location` VARCHAR(45) NOT NULL,
  `damage_charge` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `rental_information_id`),
  INDEX `fk_incident_reports_rental_information1_idx` (`rental_information_id` ASC)  ,
  INDEX `fk_incident_reports_damage_type1_idx` (`damage_type_id` ASC)  ,
  CONSTRAINT `fk_incident_reports_rental_information1`
    FOREIGN KEY (`rental_information_id`)
    REFERENCES `car_rental`.`rental_information` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_incident_reports_damage_type1`
    FOREIGN KEY (`damage_type_id`)
    REFERENCES `car_rental`.`damage_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rental`.`rental_extension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_rental`.`rental_extension` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rental_id` INT NOT NULL,
  `extended_to` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `rental_id`),
  INDEX `fk_rental_extension_rental_information1_idx` (`rental_id` ASC)  ,
  CONSTRAINT `fk_rental_extension_rental_information1`
    FOREIGN KEY (`rental_id`)
    REFERENCES `car_rental`.`rental_information` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
