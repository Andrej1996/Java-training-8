-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema school
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema school
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `school` DEFAULT CHARACTER SET utf8 ;
USE `school` ;

-- -----------------------------------------------------
-- Table `school`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`addresses` (
  `id` INT(11) NOT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `street` VARCHAR(45) NULL DEFAULT NULL,
  `number` INT(11) NULL DEFAULT NULL,
  `floor` INT(11) NULL DEFAULT NULL,
  `apartment_no` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `school`.`disciplines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`disciplines` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `school`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`students` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `enrollment_date` DATE NULL DEFAULT NULL,
  `addresses_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `addresses_id`),
  INDEX `fk_students_addresses_idx` (`addresses_id` ASC),
  CONSTRAINT `fk_students_addresses`
    FOREIGN KEY (`addresses_id`)
    REFERENCES `school`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `school`.`teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`teachers` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `salary` INT(11) NULL DEFAULT NULL,
  `addresses_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `addresses_id`),
  INDEX `fk_teachers_addresses1_idx` (`addresses_id` ASC),
  CONSTRAINT `fk_teachers_addresses1`
    FOREIGN KEY (`addresses_id`)
    REFERENCES `school`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `school`.`students_has_disciplines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`students_has_disciplines` (
  `students_id` INT(11) NOT NULL,
  `disciplines_id` INT(11) NOT NULL,
  PRIMARY KEY (`students_id`, `disciplines_id`),
  INDEX `fk_students_has_disciplines_disciplines1_idx` (`disciplines_id` ASC),
  INDEX `fk_students_has_disciplines_students1_idx` (`students_id` ASC),
  CONSTRAINT `fk_students_has_disciplines_students1`
    FOREIGN KEY (`students_id`)
    REFERENCES `school`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_students_has_disciplines_disciplines1`
    FOREIGN KEY (`disciplines_id`)
    REFERENCES `school`.`disciplines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `school`.`disciplines_has_teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`disciplines_has_teachers` (
  `disciplines_id` INT(11) NOT NULL,
  `teachers_id` INT(11) NOT NULL,
  PRIMARY KEY (`disciplines_id`, `teachers_id`),
  INDEX `fk_disciplines_has_teachers_teachers1_idx` (`teachers_id` ASC),
  INDEX `fk_disciplines_has_teachers_disciplines1_idx` (`disciplines_id` ASC),
  CONSTRAINT `fk_disciplines_has_teachers_disciplines1`
    FOREIGN KEY (`disciplines_id`)
    REFERENCES `school`.`disciplines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disciplines_has_teachers_teachers1`
    FOREIGN KEY (`teachers_id`)
    REFERENCES `school`.`teachers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
