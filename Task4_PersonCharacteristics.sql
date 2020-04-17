-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema citizen_registrations
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema citizen_registrations
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `citizen_registrations` DEFAULT CHARACTER SET utf8 ;
USE `citizen_registrations` ;

-- -----------------------------------------------------
-- Table `citizen_registrations`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citizen_registrations`.`addresses` (
  `id` INT(11) NOT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `municipality` VARCHAR(45) NULL DEFAULT NULL,
  `postal_code` VARCHAR(45) NULL DEFAULT NULL,
  `street` VARCHAR(45) NULL DEFAULT NULL,
  `number` INT(11) NULL DEFAULT NULL,
  `floor` INT(11) NULL DEFAULT NULL,
  `apartmentNo` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `citizen_registrations`.`education_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citizen_registrations`.`education_types` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `citizen_registrations`.`educations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citizen_registrations`.`educations` (
  `id` INT(11) NOT NULL,
  `type_id` INT(11) NULL DEFAULT NULL,
  `institution_name` VARCHAR(45) NULL DEFAULT NULL,
  `enrollment_date` DATE NULL DEFAULT NULL,
  `graduation_date` DATE NULL DEFAULT NULL,
  `graduated` BIT(1) NULL DEFAULT NULL,
  `final_grade` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `type_id_idx` (`type_id` ASC),
  CONSTRAINT `type_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `citizen_registrations`.`education_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `citizen_registrations`.`genders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citizen_registrations`.`genders` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `citizen_registrations`.`people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citizen_registrations`.`people` (
  `id` INT(11) NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `middle_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `gender_id` INT(11) NULL DEFAULT NULL,
  `height` INT(11) NULL DEFAULT NULL,
  `birth_date` DATE NULL DEFAULT NULL,
  `current_address` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `gender_id_idx` (`gender_id` ASC),
  INDEX `current_address_idx` (`current_address` ASC),
  CONSTRAINT `current_address`
    FOREIGN KEY (`current_address`)
    REFERENCES `citizen_registrations`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `gender_id`
    FOREIGN KEY (`gender_id`)
    REFERENCES `citizen_registrations`.`genders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `citizen_registrations`.`people_addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citizen_registrations`.`people_addresses` (
  `person_id` INT(11) NOT NULL,
  `address_id` INT(11) NULL DEFAULT NULL,
  INDEX `person_id_idx` (`person_id` ASC),
  INDEX `address_id_idx` (`address_id` ASC),
  CONSTRAINT `address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `citizen_registrations`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `citizen_registrations`.`people` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `citizen_registrations`.`people_educations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citizen_registrations`.`people_educations` (
  `person_id` INT(11) NULL DEFAULT NULL,
  `education_id` INT(11) NULL DEFAULT NULL,
  INDEX `education_id_idx` (`education_id` ASC),
  INDEX `person_id_idx` (`person_id` ASC),
  CONSTRAINT `person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `citizen_registrations`.`people` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `education_id`
    FOREIGN KEY (`education_id`)
    REFERENCES `citizen_registrations`.`educations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
