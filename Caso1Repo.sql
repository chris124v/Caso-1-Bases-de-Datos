-- MySQL Script generated by MySQL Workbench
-- Sat Mar 22 12:48:59 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantUsers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantUsers` (
  `UserId` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(80) NOT NULL,
  `firtsname` VARCHAR(50) NOT NULL,
  `lastname` VARCHAR(50) NOT NULL,
  `birthdate` DATE NOT NULL,
  `role` TINYINT(128) NOT NULL,
  `password` VARBINARY(250) NOT NULL,
  `enabled` BIT(1) NOT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssitantRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssitantRoles` (
  `RoleId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `description` VARCHAR(300) NULL,
  `updated` DATE NULL DEFAULT NOW(),
  PRIMARY KEY (`RoleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssitantPermissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssitantPermissions` (
  `PermissionId` INT NOT NULL AUTO_INCREMENT,
  `permissionName` VARCHAR(100) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `updated` DATETIME NOT NULL,
  PRIMARY KEY (`PermissionId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssitantRolePermissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssitantRolePermissions` (
  `RolePermissionId` INT NOT NULL AUTO_INCREMENT,
  `PermissionId` INT NOT NULL,
  `RoleId` INT NOT NULL,
  PRIMARY KEY (`RolePermissionId`),
  INDEX `fk_AppAssitantRolePermissions_AppAssitantPermissions1_idx` (`PermissionId` ASC) VISIBLE,
  INDEX `fk_AppAssitantRolePermissions_AppAssitantRoles1_idx` (`RoleId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantRolePermissions_AppAssitantPermissions1`
    FOREIGN KEY (`PermissionId`)
    REFERENCES `mydb`.`AppAssitantPermissions` (`PermissionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantRolePermissions_AppAssitantRoles1`
    FOREIGN KEY (`RoleId`)
    REFERENCES `mydb`.`AppAssitantRoles` (`RoleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantFileTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantFileTypes` (
  `FileTypeId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `mimeType` VARCHAR(5) NOT NULL,
  `icon` VARCHAR(200) NOT NULL,
  `enabled` BIT NULL,
  PRIMARY KEY (`FileTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantFiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantFiles` (
  `FileId` INT NOT NULL AUTO_INCREMENT,
  `fileName` VARCHAR(200) NOT NULL,
  `description` VARCHAR(250) NULL,
  `fileURL` VARCHAR(200) NOT NULL,
  `deleted` BIT NULL,
  `lastupdated` DATETIME NOT NULL,
  `creation` DATETIME NOT NULL,
  `fileSize` BIGINT NOT NULL,
  `mimeType` VARCHAR(5) NOT NULL,
  `UserId` INT NOT NULL,
  `FileTypeId` INT NOT NULL,
  PRIMARY KEY (`FileId`),
  INDEX `fk_AppAssitantFiles_AppAssistanUsers1_idx` (`UserId` ASC) VISIBLE,
  INDEX `fk_AppAssitantFiles_AppAssitantFileTypes1_idx` (`FileTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantFiles_AppAssistanUsers1`
    FOREIGN KEY (`UserId`)
    REFERENCES `mydb`.`AppAssistantUsers` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantFiles_AppAssitantFileTypes1`
    FOREIGN KEY (`FileTypeId`)
    REFERENCES `mydb`.`AppAssistantFileTypes` (`FileTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantPaymentMethods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantPaymentMethods` (
  `PaymentMethodId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `apiURL` VARCHAR(255) NULL,
  `secreteKey` VARBINARY(255) NULL,
  `key` VARBINARY(255) NULL,
  `logoIconURL` VARCHAR(200) NULL,
  `enable` BIT NOT NULL,
  PRIMARY KEY (`PaymentMethodId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantDataPayments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantDataPayments` (
  `DataPaymentId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `token` VARBINARY(250) NOT NULL,
  `expToken` DATETIME NOT NULL,
  `maskAccount` VARBINARY(250) NOT NULL,
  `UserId` INT NOT NULL,
  `PaymentMethodId` INT NOT NULL,
  PRIMARY KEY (`DataPaymentId`),
  INDEX `fk_AppAssitantDataPayments_AppAssistanUsers1_idx` (`UserId` ASC) VISIBLE,
  INDEX `fk_AppAssitantDataPayments_AppAssitantPaymentMethods1_idx` (`PaymentMethodId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantDataPayments_AppAssistanUsers1`
    FOREIGN KEY (`UserId`)
    REFERENCES `mydb`.`AppAssistantUsers` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantDataPayments_AppAssitantPaymentMethods1`
    FOREIGN KEY (`PaymentMethodId`)
    REFERENCES `mydb`.`AppAssistantPaymentMethods` (`PaymentMethodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantResultPayment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantResultPayment` (
  `ResultPaymentId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `description` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`ResultPaymentId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssitantPayments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssitantPayments` (
  `PaymentId` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(15) NOT NULL,
  `actualAmount` DECIMAL(15) NOT NULL,
  `currency` DECIMAL(15) NOT NULL,
  `auth` VARCHAR(200) NOT NULL,
  `reference` VARCHAR(200) NOT NULL,
  `chargeToken` VARBINARY(250) NOT NULL,
  `date` DATETIME NOT NULL,
  `checksum` VARBINARY(255) NOT NULL,
  `DataPaymentId` INT NOT NULL,
  `PaymentMethodId` INT NOT NULL,
  `UserId` INT NOT NULL,
  `ResultPaymentId` INT NOT NULL,
  PRIMARY KEY (`PaymentId`),
  INDEX `fk_AppAssitantPayments_AppAssitantDataPayments1_idx` (`DataPaymentId` ASC) VISIBLE,
  INDEX `fk_AppAssitantPayments_AppAssitantPaymentMethods1_idx` (`PaymentMethodId` ASC) VISIBLE,
  INDEX `fk_AppAssitantPayments_AppAssistanUsers1_idx` (`UserId` ASC) VISIBLE,
  INDEX `fk_AppAssitantPayments_AppAssistantResultPayment1_idx` (`ResultPaymentId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantPayments_AppAssitantDataPayments1`
    FOREIGN KEY (`DataPaymentId`)
    REFERENCES `mydb`.`AppAssistantDataPayments` (`DataPaymentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantPayments_AppAssitantPaymentMethods1`
    FOREIGN KEY (`PaymentMethodId`)
    REFERENCES `mydb`.`AppAssistantPaymentMethods` (`PaymentMethodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantPayments_AppAssistanUsers1`
    FOREIGN KEY (`UserId`)
    REFERENCES `mydb`.`AppAssistantUsers` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantPayments_AppAssistantResultPayment1`
    FOREIGN KEY (`ResultPaymentId`)
    REFERENCES `mydb`.`AppAssistantResultPayment` (`ResultPaymentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantTransactionsTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantTransactionsTypes` (
  `TransactionTypeId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`TransactionTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantTransactionsSubTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantTransactionsSubTypes` (
  `TransactionsSubTypesId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`TransactionsSubTypesId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantCurrencyTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantCurrencyTypes` (
  `CurrencyTypeId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `acronym` VARCHAR(10) NOT NULL,
  `symbol` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`CurrencyTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssitantCurrencyExchanges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssitantCurrencyExchanges` (
  `CurrencyExchangeId` INT NOT NULL AUTO_INCREMENT,
  `startDate` DATETIME NOT NULL,
  `endDate` DATETIME NOT NULL,
  `exchangeRate` DECIMAL(10,2) NOT NULL,
  `enable` BIT NOT NULL,
  `currentExchangeRate` BIT NOT NULL,
  `CurrencyTypeId` INT NOT NULL,
  PRIMARY KEY (`CurrencyExchangeId`),
  INDEX `fk_AppAssitantCurrencyExchanges_AppAssitantCurrencyTypes1_idx` (`CurrencyTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantCurrencyExchanges_AppAssitantCurrencyTypes1`
    FOREIGN KEY (`CurrencyTypeId`)
    REFERENCES `mydb`.`AppAssistantCurrencyTypes` (`CurrencyTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantTransactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantTransactions` (
  `TransactionId` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(15) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `transactionDateTime` DATETIME NULL,
  `postTime` DATETIME NULL,
  `referenceNumber` VARCHAR(200) NULL,
  `checkSum` VARBINARY(255) NULL,
  `TransactionTypeId` INT NOT NULL,
  `TransactionsSubTypesId` INT NOT NULL,
  `CurrencyTypeId` INT NOT NULL,
  `PaymentId` INT NOT NULL,
  `UserId` INT NOT NULL,
  `ExchangerateId` INT NOT NULL,
  PRIMARY KEY (`TransactionId`),
  INDEX `fk_AppAssitantTransactions_AppAssitantTransactionsTypes1_idx` (`TransactionTypeId` ASC) VISIBLE,
  INDEX `fk_AppAssitantTransactions_AppAssitantTransactionsSubTypes1_idx` (`TransactionsSubTypesId` ASC) VISIBLE,
  INDEX `fk_AppAssitantTransactions_AppAssitantCurrencyTypes1_idx` (`CurrencyTypeId` ASC) VISIBLE,
  INDEX `fk_AppAssitantTransactions_AppAssitantPayments1_idx` (`PaymentId` ASC) VISIBLE,
  INDEX `fk_AppAssitantTransactions_AppAssistanUsers1_idx` (`UserId` ASC) VISIBLE,
  INDEX `fk_AppAssitantTransactions_AppAssitantCurrencyExchanges1_idx` (`ExchangerateId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantTransactions_AppAssitantTransactionsTypes1`
    FOREIGN KEY (`TransactionTypeId`)
    REFERENCES `mydb`.`AppAssistantTransactionsTypes` (`TransactionTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantTransactions_AppAssitantTransactionsSubTypes1`
    FOREIGN KEY (`TransactionsSubTypesId`)
    REFERENCES `mydb`.`AppAssistantTransactionsSubTypes` (`TransactionsSubTypesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantTransactions_AppAssitantCurrencyTypes1`
    FOREIGN KEY (`CurrencyTypeId`)
    REFERENCES `mydb`.`AppAssistantCurrencyTypes` (`CurrencyTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantTransactions_AppAssitantPayments1`
    FOREIGN KEY (`PaymentId`)
    REFERENCES `mydb`.`AppAssitantPayments` (`PaymentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantTransactions_AppAssistanUsers1`
    FOREIGN KEY (`UserId`)
    REFERENCES `mydb`.`AppAssistantUsers` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantTransactions_AppAssitantCurrencyExchanges1`
    FOREIGN KEY (`ExchangerateId`)
    REFERENCES `mydb`.`AppAssitantCurrencyExchanges` (`CurrencyExchangeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantCountries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantCountries` (
  `CountryId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `language` VARCHAR(20) NOT NULL,
  `CurrencyTypeId` INT NOT NULL,
  PRIMARY KEY (`CountryId`),
  INDEX `fk_AppAssistantCountries_AppAssistantCurrencyTypes1_idx` (`CurrencyTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssistantCountries_AppAssistantCurrencyTypes1`
    FOREIGN KEY (`CurrencyTypeId`)
    REFERENCES `mydb`.`AppAssistantCurrencyTypes` (`CurrencyTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantStates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantStates` (
  `StateId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `CountryId` INT NOT NULL,
  PRIMARY KEY (`StateId`),
  INDEX `fk_AppAssitantStates_AppAssitantCountries1_idx` (`CountryId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantStates_AppAssitantCountries1`
    FOREIGN KEY (`CountryId`)
    REFERENCES `mydb`.`AppAssistantCountries` (`CountryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantCities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantCities` (
  `CityId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `StateId` INT NOT NULL,
  PRIMARY KEY (`CityId`),
  INDEX `fk_AppAssitantCities_AppAssitantStates1_idx` (`StateId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantCities_AppAssitantStates1`
    FOREIGN KEY (`StateId`)
    REFERENCES `mydb`.`AppAssistantStates` (`StateId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantAddress` (
  `AddressId` INT NOT NULL AUTO_INCREMENT,
  `line1` VARCHAR(200) NOT NULL,
  `line2` VARCHAR(100) NULL,
  `zipCode` VARCHAR(10) NOT NULL,
  `location` POINT NOT NULL,
  `CityId` INT NOT NULL,
  PRIMARY KEY (`AddressId`),
  INDEX `fk_AppAssitantAddress_AppAssitantCities1_idx` (`CityId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantAddress_AppAssitantCities1`
    FOREIGN KEY (`CityId`)
    REFERENCES `mydb`.`AppAssistantCities` (`CityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantLogTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantLogTypes` (
  `LogTypeId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`LogTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantLogSeverities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantLogSeverities` (
  `LogSeverityId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`LogSeverityId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssitantLogSources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssitantLogSources` (
  `LogSourceId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`LogSourceId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantLogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantLogs` (
  `LogId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(200) NOT NULL,
  `postTime` DATETIME NOT NULL,
  `computer` VARBINARY(250) NOT NULL,
  `userName` VARCHAR(80) NOT NULL,
  `trace` VARCHAR(300) NOT NULL,
  `referenceId1` BIGINT NOT NULL,
  `referenceId2` BIGINT NOT NULL,
  `value1` VARCHAR(60) NOT NULL,
  `value2` VARCHAR(60) NOT NULL,
  `checkSum` VARBINARY(255) NOT NULL,
  `LogTypeId` INT NOT NULL,
  `LogSourceId` INT NOT NULL,
  `LogSeverityId` INT NOT NULL,
  `TransactionId` INT NOT NULL,
  `UserId` INT NOT NULL,
  PRIMARY KEY (`LogId`),
  INDEX `fk_AppAssitantLogs_AppAssitantLogTypes1_idx` (`LogTypeId` ASC) VISIBLE,
  INDEX `fk_AppAssitantLogs_AppAssitantLogSources1_idx` (`LogSourceId` ASC) VISIBLE,
  INDEX `fk_AppAssitantLogs_AppAssitantLogSeverities1_idx` (`LogSeverityId` ASC) VISIBLE,
  INDEX `fk_AppAssitantLogs_AppAssitantTransactions1_idx` (`TransactionId` ASC) VISIBLE,
  INDEX `fk_AppAssitantLogs_AppAssistanUsers1_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantLogs_AppAssitantLogTypes1`
    FOREIGN KEY (`LogTypeId`)
    REFERENCES `mydb`.`AppAssistantLogTypes` (`LogTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantLogs_AppAssitantLogSources1`
    FOREIGN KEY (`LogSourceId`)
    REFERENCES `mydb`.`AppAssitantLogSources` (`LogSourceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantLogs_AppAssitantLogSeverities1`
    FOREIGN KEY (`LogSeverityId`)
    REFERENCES `mydb`.`AppAssistantLogSeverities` (`LogSeverityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantLogs_AppAssitantTransactions1`
    FOREIGN KEY (`TransactionId`)
    REFERENCES `mydb`.`AppAssistantTransactions` (`TransactionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantLogs_AppAssistanUsers1`
    FOREIGN KEY (`UserId`)
    REFERENCES `mydb`.`AppAssistantUsers` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantSuscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantSuscriptions` (
  `SuscriptionsId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `logoURL` VARCHAR(200) NULL,
  `enable` BIT NOT NULL,
  PRIMARY KEY (`SuscriptionsId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssitantSuscriptionPrices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssitantSuscriptionPrices` (
  `SuscriptionPricesId` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL NOT NULL,
  `postTime` DATETIME NOT NULL,
  `endDate` DATETIME NOT NULL,
  `update` DATETIME NOT NULL,
  `SuscriptionsId` INT NOT NULL,
  `CurrencyTypeId` INT NOT NULL,
  PRIMARY KEY (`SuscriptionPricesId`),
  INDEX `fk_AppAssitantSuscriptionPrices_AppAssitantSuscriptions1_idx` (`SuscriptionsId` ASC) VISIBLE,
  INDEX `fk_AppAssitantSuscriptionPrices_AppAssitantCurrencyTypes1_idx` (`CurrencyTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantSuscriptionPrices_AppAssitantSuscriptions1`
    FOREIGN KEY (`SuscriptionsId`)
    REFERENCES `mydb`.`AppAssistantSuscriptions` (`SuscriptionsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantSuscriptionPrices_AppAssitantCurrencyTypes1`
    FOREIGN KEY (`CurrencyTypeId`)
    REFERENCES `mydb`.`AppAssistantCurrencyTypes` (`CurrencyTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssitantSuscriptionUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssitantSuscriptionUser` (
  `SuscriptionUserId` INT NOT NULL AUTO_INCREMENT,
  `UserId` INT NOT NULL,
  `SuscriptionPricesId` INT NOT NULL,
  `enable` BIT(1) NOT NULL,
  `startDate` DATETIME NOT NULL,
  `endDate` DATETIME NOT NULL,
  PRIMARY KEY (`SuscriptionUserId`),
  INDEX `fk_AppAssitantSuscriptionUser_AppAssistanUsers1_idx` (`UserId` ASC) VISIBLE,
  INDEX `fk_AppAssitantSuscriptionUser_AppAssitantSuscriptionPrices1_idx` (`SuscriptionPricesId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantSuscriptionUser_AppAssistanUsers1`
    FOREIGN KEY (`UserId`)
    REFERENCES `mydb`.`AppAssistantUsers` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantSuscriptionUser_AppAssitantSuscriptionPrices1`
    FOREIGN KEY (`SuscriptionPricesId`)
    REFERENCES `mydb`.`AppAssitantSuscriptionPrices` (`SuscriptionPricesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssitantPlanFeatures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssitantPlanFeatures` (
  `PlanFeatureId` INT NOT NULL,
  `description` VARCHAR(200) NULL,
  `enable` BIT NULL,
  `dataType` VARCHAR(25) NULL,
  PRIMARY KEY (`PlanFeatureId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssitantFeaturePerPlan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssitantFeaturePerPlan` (
  `FeaturePerPlanId` INT NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  `enable` BIT NOT NULL,
  `PlanFeatureId` INT NOT NULL,
  `SuscriptionsId` INT NOT NULL,
  PRIMARY KEY (`FeaturePerPlanId`),
  INDEX `fk_AppAssitantFeaturePerPlan_AppAssitantPlanFeatures1_idx` (`PlanFeatureId` ASC) VISIBLE,
  INDEX `fk_AppAssitantFeaturePerPlan_AppAssitantSuscriptions1_idx` (`SuscriptionsId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantFeaturePerPlan_AppAssitantPlanFeatures1`
    FOREIGN KEY (`PlanFeatureId`)
    REFERENCES `mydb`.`AppAssitantPlanFeatures` (`PlanFeatureId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssitantFeaturePerPlan_AppAssitantSuscriptions1`
    FOREIGN KEY (`SuscriptionsId`)
    REFERENCES `mydb`.`AppAssistantSuscriptions` (`SuscriptionsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantLanguages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantLanguages` (
  `LanguagesId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NULL,
  `culture` VARCHAR(30) NULL,
  PRIMARY KEY (`LanguagesId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantTranslations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantTranslations` (
  `TranslationsId` INT NOT NULL AUTO_INCREMENT,
  `LanguagesId` INT NOT NULL,
  PRIMARY KEY (`TranslationsId`),
  INDEX `fk_AppAssitantTranslations_AppAssitantLanguages1_idx` (`LanguagesId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssitantTranslations_AppAssitantLanguages1`
    FOREIGN KEY (`LanguagesId`)
    REFERENCES `mydb`.`AppAssistantLanguages` (`LanguagesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantRolesPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantRolesPerUser` (
  `RolePerUserId` INT NOT NULL,
  `UserId` INT NOT NULL,
  `RoleId` INT NOT NULL,
  `update` DATETIME NOT NULL,
  `enabled` BIT(1) NOT NULL,
  PRIMARY KEY (`RolePerUserId`),
  INDEX `fk_AppAssistantRolesPerUser_AppAssistanUsers1_idx` (`UserId` ASC) VISIBLE,
  INDEX `fk_AppAssistantRolesPerUser_AppAssitantRoles1_idx` (`RoleId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssistantRolesPerUser_AppAssistanUsers1`
    FOREIGN KEY (`UserId`)
    REFERENCES `mydb`.`AppAssistantUsers` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssistantRolesPerUser_AppAssitantRoles1`
    FOREIGN KEY (`RoleId`)
    REFERENCES `mydb`.`AppAssitantRoles` (`RoleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantUserAddresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantUserAddresses` (
  `UserAddressId` INT NOT NULL,
  `AddressId` INT NOT NULL,
  `UserId` INT NOT NULL,
  PRIMARY KEY (`UserAddressId`),
  INDEX `fk_AppAssistantUserAddresses_AppAssitantAddress1_idx` (`AddressId` ASC) VISIBLE,
  INDEX `fk_AppAssistantUserAddresses_AppAssistanUsers1_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssistantUserAddresses_AppAssitantAddress1`
    FOREIGN KEY (`AddressId`)
    REFERENCES `mydb`.`AppAssistantAddress` (`AddressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssistantUserAddresses_AppAssistanUsers1`
    FOREIGN KEY (`UserId`)
    REFERENCES `mydb`.`AppAssistantUsers` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantLanguagesPerCountry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantLanguagesPerCountry` (
  `LanguagePerCountryId` INT NOT NULL,
  `LanguagesId` INT NOT NULL,
  `CountryId` INT NOT NULL,
  PRIMARY KEY (`LanguagePerCountryId`),
  INDEX `fk_AppAssistantLanguagesPerCountry_AppAssitantLanguages1_idx` (`LanguagesId` ASC) VISIBLE,
  INDEX `fk_AppAssistantLanguagesPerCountry_AppAssitantCountries1_idx` (`CountryId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssistantLanguagesPerCountry_AppAssitantLanguages1`
    FOREIGN KEY (`LanguagesId`)
    REFERENCES `mydb`.`AppAssistantLanguages` (`LanguagesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssistantLanguagesPerCountry_AppAssitantCountries1`
    FOREIGN KEY (`CountryId`)
    REFERENCES `mydb`.`AppAssistantCountries` (`CountryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantSchedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantSchedules` (
  `ScheduleId` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `repeat` ENUM('biweekly', 'mothly', 'yearly') NOT NULL,
  `endType` VARCHAR(45) NULL,
  `repetitionsl` INT NULL,
  PRIMARY KEY (`ScheduleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantScheduleDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantScheduleDetails` (
  `ScheduleDetailId` INT NOT NULL,
  `deleted` BIT(1) NOT NULL,
  `baseDate` DATETIME NOT NULL,
  `lastExecution` DATETIME NOT NULL,
  `NextExecution` DATETIME NOT NULL,
  `ScheduleId` INT NOT NULL,
  PRIMARY KEY (`ScheduleDetailId`),
  INDEX `fk_AppAssistantScheduleDetails_AppAssistantSchedules1_idx` (`ScheduleId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssistantScheduleDetails_AppAssistantSchedules1`
    FOREIGN KEY (`ScheduleId`)
    REFERENCES `mydb`.`AppAssistantSchedules` (`ScheduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppAssistantSuscriptionSchedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppAssistantSuscriptionSchedules` (
  `AppAssistantSuscriptionSchedulesId` INT NULL AUTO_INCREMENT,
  `startDate` DATETIME NOT NULL,
  `status` BIT(1) NOT NULL,
  `SuscriptionsId` INT NOT NULL,
  `SuscriptionPricesId` INT NOT NULL,
  `ScheduleId` INT NOT NULL,
  PRIMARY KEY (`AppAssistantSuscriptionSchedulesId`),
  INDEX `fk_AppAssistantSuscriptionSchedules_AppAssitantSuscriptions_idx` (`SuscriptionsId` ASC) VISIBLE,
  INDEX `fk_AppAssistantSuscriptionSchedules_AppAssitantSuscriptionP_idx` (`SuscriptionPricesId` ASC) VISIBLE,
  INDEX `fk_AppAssistantSuscriptionSchedules_AppAssistantSchedules1_idx` (`ScheduleId` ASC) VISIBLE,
  CONSTRAINT `fk_AppAssistantSuscriptionSchedules_AppAssitantSuscriptions1`
    FOREIGN KEY (`SuscriptionsId`)
    REFERENCES `mydb`.`AppAssistantSuscriptions` (`SuscriptionsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssistantSuscriptionSchedules_AppAssitantSuscriptionPri1`
    FOREIGN KEY (`SuscriptionPricesId`)
    REFERENCES `mydb`.`AppAssitantSuscriptionPrices` (`SuscriptionPricesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppAssistantSuscriptionSchedules_AppAssistantSchedules1`
    FOREIGN KEY (`ScheduleId`)
    REFERENCES `mydb`.`AppAssistantSchedules` (`ScheduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
