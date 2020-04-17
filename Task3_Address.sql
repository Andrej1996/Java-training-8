-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema addressdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema addressdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `addressdb` DEFAULT CHARACTER SET utf8 ;
USE `addressdb` ;

-- -----------------------------------------------------
-- Table `addressdb`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addressdb`.`countries` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `addressdb`.`regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addressdb`.`regions` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `countries_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `countries_id`),
  INDEX `fk_regions_countries_idx` (`countries_id` ASC),
  CONSTRAINT `fk_regions_countries`
    FOREIGN KEY (`countries_id`)
    REFERENCES `addressdb`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `addressdb`.`populated_area_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addressdb`.`populated_area_types` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `addressdb`.`populated_areas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addressdb`.`populated_areas` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `regions_id` INT(11) NOT NULL,
  `populated_area_types_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `regions_id`, `populated_area_types_id`),
  INDEX `fk_populated_areas_regions1_idx` (`regions_id` ASC),
  INDEX `fk_populated_areas_populated_area_types1_idx` (`populated_area_types_id` ASC),
  CONSTRAINT `fk_populated_areas_regions1`
    FOREIGN KEY (`regions_id`)
    REFERENCES `addressdb`.`regions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_populated_areas_populated_area_types1`
    FOREIGN KEY (`populated_area_types_id`)
    REFERENCES `addressdb`.`populated_area_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `addressdb`.`municipalities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addressdb`.`municipalities` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `postal_code` INT(11) NULL DEFAULT NULL,
  `populated_areas_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `populated_areas_id`),
  INDEX `fk_municipalities_populated_areas1_idx` (`populated_areas_id` ASC),
  CONSTRAINT `fk_municipalities_populated_areas1`
    FOREIGN KEY (`populated_areas_id`)
    REFERENCES `addressdb`.`populated_areas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `addressdb`.`streets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addressdb`.`streets` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `municipalities_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `municipalities_id`),
  INDEX `fk_streets_municipalities1_idx` (`municipalities_id` ASC),
  CONSTRAINT `fk_streets_municipalities1`
    FOREIGN KEY (`municipalities_id`)
    REFERENCES `addressdb`.`municipalities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `addressdb`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addressdb`.`addresses` (
  `id` INT(11) NOT NULL,
  `number` INT(11) NULL DEFAULT NULL,
  `apartmentNo` INT(11) NULL DEFAULT NULL,
  `streets_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `streets_id`),
  INDEX `fk_addresses_streets1_idx` (`streets_id` ASC),
  CONSTRAINT `fk_addresses_streets1`
    FOREIGN KEY (`streets_id`)
    REFERENCES `addressdb`.`streets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
