-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema mainnet
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mainnet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mainnet` DEFAULT CHARACTER SET utf8 ;
USE `mainnet` ;

-- -----------------------------------------------------
-- Table `mainnet`.`calendar_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`calendar_table` (
  `dt` DATE NOT NULL,
  `y` SMALLINT NULL DEFAULT NULL,
  `q` TINYINT NULL DEFAULT NULL,
  `m` TINYINT NULL DEFAULT NULL,
  `d` TINYINT NULL DEFAULT NULL,
  `dw` TINYINT NULL DEFAULT NULL,
  `monthName` VARCHAR(9) NULL DEFAULT NULL,
  `dayName` VARCHAR(9) NULL DEFAULT NULL,
  `w` TINYINT NULL DEFAULT NULL,
  `epoch` INT NULL DEFAULT NULL,
  PRIMARY KEY (`dt`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`ints`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`ints` (
  `i` TINYINT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`load_delegations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`load_delegations` (
  `id` INT NOT NULL,
  `validator_id` INT NULL DEFAULT NULL,
  `created` BIGINT NULL DEFAULT NULL,
  `delegation_period` INT NULL DEFAULT NULL,
  `started` INT NULL DEFAULT NULL,
  `finished` INT NULL DEFAULT NULL,
  `holder_address` VARCHAR(255) NULL DEFAULT NULL,
  `info` VARCHAR(255) NULL DEFAULT NULL,
  `status` VARCHAR(255) NULL DEFAULT NULL,
  `amount` DECIMAL(16,4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`load_linked_nodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`load_linked_nodes` (
  `validator_id` INT NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `balance` DECIMAL(16,4) NULL DEFAULT NULL,
  PRIMARY KEY (`validator_id`, `address`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`load_node_containers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`load_node_containers` (
  `# Node ID` INT NULL DEFAULT NULL,
  `Node name` TEXT NULL DEFAULT NULL,
  `Admin` TEXT NULL DEFAULT NULL,
  `API` TEXT NULL DEFAULT NULL,
  `Nginx` TEXT NULL DEFAULT NULL,
  `TM` TEXT NULL DEFAULT NULL,
  `MySql` TEXT NULL DEFAULT NULL,
  `Watchdog` TEXT NULL DEFAULT NULL,
  `Bounty` TEXT NULL DEFAULT NULL,
  `Filebeat` TEXT NULL DEFAULT NULL,
  `Configs` TEXT NULL DEFAULT NULL,
  `CLI` TEXT NULL DEFAULT NULL,
  `sChain` TEXT NULL DEFAULT NULL,
  `IMA` TEXT NULL DEFAULT NULL,
  `Lvmpy` TEXT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`load_node_hardware`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`load_node_hardware` (
  `# ID` INT NULL DEFAULT NULL,
  `Name` TEXT NULL DEFAULT NULL,
  `Cores` TEXT NULL DEFAULT NULL,
  `Memory` TEXT NULL DEFAULT NULL,
  `Storage` TEXT NULL DEFAULT NULL,
  `Swap` TEXT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`load_node_health_check`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`load_node_health_check` (
  `# Node ID` INT NULL DEFAULT NULL,
  `Node name` VARCHAR(250) NULL DEFAULT NULL,
  `Is node active` VARCHAR(10) NULL DEFAULT NULL,
  `Validator SRW balance` VARCHAR(10) NULL DEFAULT NULL,
  `Node balance` VARCHAR(10) NULL DEFAULT NULL,
  `Container statuses` VARCHAR(10) NULL DEFAULT NULL,
  `Component versions` VARCHAR(10) NULL DEFAULT NULL,
  `SGX` VARCHAR(10) NULL DEFAULT NULL,
  `SGX version` VARCHAR(10) NULL DEFAULT NULL,
  `Endpoint` VARCHAR(10) NULL DEFAULT NULL,
  `Hardware` VARCHAR(10) NULL DEFAULT NULL,
  `Trusted endpoint` VARCHAR(10) NULL DEFAULT NULL,
  `Filebeat logs` VARCHAR(10) NULL DEFAULT NULL,
  `BTRFS` VARCHAR(45) NULL DEFAULT NULL,
  `Val nodes` VARCHAR(45) NULL DEFAULT NULL,
  `Public IP` VARCHAR(45) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`load_nodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`load_nodes` (
  `id` INT NOT NULL,
  `validator_id` INT NULL DEFAULT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `ip` VARCHAR(255) NULL DEFAULT NULL,
  `pub_key` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `port` VARCHAR(255) NULL DEFAULT NULL,
  `status` VARCHAR(255) NULL DEFAULT NULL,
  `balance` DECIMAL(16,4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`load_nodes_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`load_nodes_info` (
  `# ID` INT NULL DEFAULT NULL,
  `Name` TEXT NULL DEFAULT NULL,
  `IP` TEXT NULL DEFAULT NULL,
  `Status` TEXT NULL DEFAULT NULL,
  `Address` TEXT NULL DEFAULT NULL,
  `Balance (Wei)` TEXT NULL DEFAULT NULL,
  `Base containers` TEXT NULL DEFAULT NULL,
  `SGX` TEXT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`load_schain_health_checks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`load_schain_health_checks` (
  `# Node ID` INT NULL DEFAULT NULL,
  `Schain Name` TEXT NULL DEFAULT NULL,
  `HTTP` TEXT NULL DEFAULT NULL,
  `HTTPs` TEXT NULL DEFAULT NULL,
  `Blocks` TEXT NULL DEFAULT NULL,
  `Data directory` TEXT NULL DEFAULT NULL,
  `DKG` TEXT NULL DEFAULT NULL,
  `Config file` TEXT NULL DEFAULT NULL,
  `Volume` TEXT NULL DEFAULT NULL,
  `Container` TEXT NULL DEFAULT NULL,
  `IMA` TEXT NULL DEFAULT NULL,
  `Firewall` TEXT NULL DEFAULT NULL,
  `RPC` TEXT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`load_schain_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`load_schain_info` (
  `# Name` VARCHAR(250) NOT NULL,
  `Type` TEXT NULL DEFAULT NULL,
  `Creation time` TEXT NULL DEFAULT NULL,
  `Owner` TEXT NULL DEFAULT NULL,
  `Chain ID` TEXT NULL DEFAULT NULL,
  `Rotation ID` VARCHAR(250) NULL DEFAULT NULL,
  `Nodes` VARCHAR(250) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`load_validators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`load_validators` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `mdr` BIGINT NULL DEFAULT NULL,
  `fee_rate` DECIMAL(16,4) NULL DEFAULT NULL,
  `trusted` TINYINT(1) NULL DEFAULT NULL,
  `balance` DECIMAL(16,4) NULL DEFAULT NULL,
  `total_staked` BIGINT NULL DEFAULT NULL,
  `total_staked_next_epoch` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`node_containers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`node_containers` (
  `# Node ID` INT NOT NULL,
  `Node name` TEXT NULL DEFAULT NULL,
  `Admin` TEXT NULL DEFAULT NULL,
  `API` TEXT NULL DEFAULT NULL,
  `Nginx` TEXT NULL DEFAULT NULL,
  `TM` TEXT NULL DEFAULT NULL,
  `MySql` TEXT NULL DEFAULT NULL,
  `Watchdog` TEXT NULL DEFAULT NULL,
  `Bounty` TEXT NULL DEFAULT NULL,
  `Filebeat` TEXT NULL DEFAULT NULL,
  `Configs` TEXT NULL DEFAULT NULL,
  `CLI` TEXT NULL DEFAULT NULL,
  `sChain` TEXT NULL DEFAULT NULL,
  `IMA` TEXT NULL DEFAULT NULL,
  `Lvmpy` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`# Node ID`),
  UNIQUE INDEX `# Node ID_UNIQUE` (`# Node ID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`node_hardware`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`node_hardware` (
  `# ID` INT NOT NULL,
  `Name` TEXT NULL DEFAULT NULL,
  `Cores` TEXT NULL DEFAULT NULL,
  `Memory` TEXT NULL DEFAULT NULL,
  `Storage` TEXT NULL DEFAULT NULL,
  `Swap` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`# ID`),
  UNIQUE INDEX `# ID_UNIQUE` (`# ID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`node_health_check`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`node_health_check` (
  `# Node ID` INT NOT NULL,
  `Node name` VARCHAR(250) NULL DEFAULT NULL,
  `Is node active` VARCHAR(10) NULL DEFAULT NULL,
  `Validator SRW balance` VARCHAR(10) NULL DEFAULT NULL,
  `Node balance` VARCHAR(10) NULL DEFAULT NULL,
  `Container statuses` VARCHAR(10) NULL DEFAULT NULL,
  `Component versions` VARCHAR(10) NULL DEFAULT NULL,
  `SGX` VARCHAR(10) NULL DEFAULT NULL,
  `SGX version` VARCHAR(10) NULL DEFAULT NULL,
  `Endpoint` VARCHAR(10) NULL DEFAULT NULL,
  `Hardware` VARCHAR(10) NULL DEFAULT NULL,
  `Trusted endpoint` VARCHAR(10) NULL DEFAULT NULL,
  `Filebeat logs` VARCHAR(10) NULL DEFAULT NULL,
  `BTRFS` VARCHAR(45) NULL DEFAULT NULL,
  `Val nodes` VARCHAR(45) NULL DEFAULT NULL,
  `Public IP` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`# Node ID`),
  UNIQUE INDEX `# Node ID_UNIQUE` (`# Node ID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`nodes_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`nodes_info` (
  `# ID` INT NOT NULL,
  `Name` TEXT NULL DEFAULT NULL,
  `IP` TEXT NULL DEFAULT NULL,
  `Status` TEXT NULL DEFAULT NULL,
  `Address` TEXT NULL DEFAULT NULL,
  `Balance (Wei)` TEXT NULL DEFAULT NULL,
  `Base containers` TEXT NULL DEFAULT NULL,
  `SGX` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`# ID`),
  UNIQUE INDEX `# ID_UNIQUE` (`# ID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`schain_health_checks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`schain_health_checks` (
  `# Node ID` INT NOT NULL,
  `Schain Name` VARCHAR(250) NOT NULL,
  `HTTP` TEXT NULL DEFAULT NULL,
  `HTTPs` TEXT NULL DEFAULT NULL,
  `Blocks` TEXT NULL DEFAULT NULL,
  `Data directory` TEXT NULL DEFAULT NULL,
  `DKG` TEXT NULL DEFAULT NULL,
  `Config file` TEXT NULL DEFAULT NULL,
  `Volume` TEXT NULL DEFAULT NULL,
  `Container` TEXT NULL DEFAULT NULL,
  `IMA` TEXT NULL DEFAULT NULL,
  `Firewall` TEXT NULL DEFAULT NULL,
  `RPC` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`# Node ID`, `Schain Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`schain_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`schain_info` (
  `# Name` VARCHAR(250) NOT NULL,
  `Type` TEXT NULL DEFAULT NULL,
  `Creation time` TEXT NULL DEFAULT NULL,
  `Owner` TEXT NULL DEFAULT NULL,
  `Chain ID` TEXT NULL DEFAULT NULL,
  `Rotation ID` VARCHAR(250) NULL DEFAULT NULL,
  `Nodes` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`# Name`),
  UNIQUE INDEX `# Name_UNIQUE` (`# Name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_bounty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_bounty` (
  `id` INT NOT NULL DEFAULT '1',
  `address` VARCHAR(45) NOT NULL,
  `validator_id` VARCHAR(45) NOT NULL,
  `earned_bounty` DECIMAL(32,16) NULL DEFAULT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`type`, `validator_id`, `address`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_contract` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `lastblock` INT NULL DEFAULT '0',
  `repository` VARCHAR(45) NULL DEFAULT NULL,
  `last_internal_tx_block` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 458
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_contract_internal_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_contract_internal_transactions` (
  `tx_blockNumber` VARCHAR(45) NULL DEFAULT NULL,
  `tx_timeStamp` INT NULL DEFAULT NULL,
  `tx_hash` VARCHAR(100) NOT NULL,
  `tx_from` VARCHAR(45) NOT NULL,
  `tx_to` VARCHAR(45) NULL DEFAULT NULL,
  `tx_value` VARCHAR(45) NULL DEFAULT NULL,
  `tx_gas` INT NULL DEFAULT NULL,
  `tx_isError` VARCHAR(45) NULL DEFAULT NULL,
  `tx_input` VARCHAR(1000) NULL DEFAULT NULL,
  `tx_contractAddress` VARCHAR(45) NULL DEFAULT NULL,
  `tx_gasUsed` DECIMAL(16,4) NULL DEFAULT NULL,
  `tx_type` VARCHAR(45) NULL DEFAULT NULL,
  `tx_traceId` VARCHAR(45) NULL DEFAULT NULL,
  `tx_errCode` VARCHAR(45) NULL DEFAULT NULL,
  `contract_id` INT NULL DEFAULT NULL,
  `contract_address` VARCHAR(45) NULL DEFAULT NULL,
  `contract_function_name` VARCHAR(100) NULL DEFAULT NULL,
  `contract_parameters` VARCHAR(1000) NULL DEFAULT NULL,
  `contract_implementation_address` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`tx_hash`),
  UNIQUE INDEX `tx_hash_UNIQUE` (`tx_hash` ASC) VISIBLE,
  INDEX `tx_from` (`tx_from` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_contract_proxy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_contract_proxy` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(45) NOT NULL,
  `lastblock` INT NULL DEFAULT '0',
  `repository` VARCHAR(45) NULL DEFAULT NULL,
  `last_internal_tx_block` INT NULL DEFAULT NULL,
  `implementation_address` VARCHAR(45) NULL DEFAULT NULL,
  `implementation_name` VARCHAR(45) NULL DEFAULT NULL,
  `holder_address` VARCHAR(45) NULL DEFAULT 'Unknown',
  PRIMARY KEY (`address`),
  UNIQUE INDEX `address_UNIQUE` (`address` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `holder` (`holder_address` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 284
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_contract_token_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_contract_token_transactions` (
  `tx_blockNumber` VARCHAR(45) NULL DEFAULT NULL,
  `tx_timeStamp` INT NULL DEFAULT NULL,
  `tx_hash` VARCHAR(100) NOT NULL,
  `tx_nonce` VARCHAR(100) NULL DEFAULT NULL,
  `tx_transactionIndex` INT NULL DEFAULT NULL,
  `tx_from` VARCHAR(45) NULL DEFAULT NULL,
  `tx_to` VARCHAR(45) NULL DEFAULT NULL,
  `tx_value` VARCHAR(45) NULL DEFAULT NULL,
  `tx_gas` INT NULL DEFAULT NULL,
  `tx_gasPrice` DECIMAL(32,16) NULL DEFAULT NULL,
  `tx_isError` VARCHAR(45) NULL DEFAULT NULL,
  `tx_txreceipt_status` VARCHAR(45) NULL DEFAULT NULL,
  `tx_input` VARCHAR(1000) NULL DEFAULT NULL,
  `tx_contractAddress` VARCHAR(45) NULL DEFAULT NULL,
  `tx_cumulativeGasUsed` DECIMAL(16,4) NULL DEFAULT NULL,
  `tx_gasUsed` DECIMAL(16,4) NULL DEFAULT NULL,
  `tx_confirmations` VARCHAR(45) NULL DEFAULT NULL,
  `contract_id` INT NULL DEFAULT NULL,
  `contract_address` VARCHAR(45) NULL DEFAULT NULL,
  `contract_function_name` VARCHAR(100) NULL DEFAULT NULL,
  `contract_parameters` VARCHAR(1000) NULL DEFAULT NULL,
  `contract_implementation_address` VARCHAR(45) NULL DEFAULT NULL,
  `tx_tokenName` VARCHAR(45) NULL DEFAULT NULL,
  `tx_tokenSymbol` VARCHAR(45) NULL DEFAULT NULL,
  `tx_tokenDecimal` VARCHAR(45) NULL DEFAULT NULL,
  `tx_blockHash` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`tx_hash`),
  UNIQUE INDEX `tx_hash_UNIQUE` (`tx_hash` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_contract_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_contract_transactions` (
  `tx_blockNumber` VARCHAR(45) NULL DEFAULT NULL,
  `tx_timeStamp` INT NULL DEFAULT NULL,
  `tx_hash` VARCHAR(100) NOT NULL,
  `tx_nonce` VARCHAR(100) NULL DEFAULT NULL,
  `tx_transactionIndex` INT NULL DEFAULT NULL,
  `tx_from` VARCHAR(45) NOT NULL,
  `tx_to` VARCHAR(45) NULL DEFAULT NULL,
  `tx_value` VARCHAR(45) NULL DEFAULT NULL,
  `tx_gas` INT NULL DEFAULT NULL,
  `tx_gasPrice` DECIMAL(32,16) NULL DEFAULT NULL,
  `tx_isError` VARCHAR(45) NULL DEFAULT NULL,
  `tx_txreceipt_status` VARCHAR(45) NULL DEFAULT NULL,
  `tx_input` VARCHAR(1000) NULL DEFAULT NULL,
  `tx_contractAddress` VARCHAR(45) NULL DEFAULT NULL,
  `tx_cumulativeGasUsed` DECIMAL(16,4) NULL DEFAULT NULL,
  `tx_gasUsed` DECIMAL(16,4) NULL DEFAULT NULL,
  `tx_confirmations` VARCHAR(45) NULL DEFAULT NULL,
  `contract_id` INT NULL DEFAULT NULL,
  `contract_address` VARCHAR(45) NULL DEFAULT NULL,
  `contract_function_name` VARCHAR(100) NULL DEFAULT NULL,
  `contract_parameters` VARCHAR(1000) NULL DEFAULT NULL,
  `contract_implementation_address` VARCHAR(45) NULL DEFAULT NULL,
  `tx_tokenName` VARCHAR(45) NULL DEFAULT NULL,
  `tx_tokenSymbol` VARCHAR(45) NULL DEFAULT NULL,
  `tx_tokenDecimal` VARCHAR(45) NULL DEFAULT NULL,
  `tx_blockHash` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`tx_hash`),
  UNIQUE INDEX `tx_hash_UNIQUE` (`tx_hash` ASC) VISIBLE,
  INDEX `tx_from` (`tx_from` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_delegations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_delegations` (
  `id` INT NOT NULL,
  `validator_id` INT NULL DEFAULT NULL,
  `created` BIGINT NULL DEFAULT NULL,
  `delegation_period` INT NULL DEFAULT NULL,
  `started` INT NULL DEFAULT NULL,
  `finished` INT NULL DEFAULT NULL,
  `holder_address` VARCHAR(255) NULL DEFAULT NULL,
  `info` VARCHAR(255) NULL DEFAULT NULL,
  `status` VARCHAR(255) NULL DEFAULT NULL,
  `amount` DECIMAL(16,4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_delegator_monthly`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_delegator_monthly` (
  `holder_address` VARCHAR(45) NOT NULL,
  `validator_id` INT NOT NULL,
  `YYYYMM` INT NULL DEFAULT NULL,
  `MonthName` VARCHAR(45) NULL DEFAULT NULL,
  `epoch` INT NOT NULL,
  `TotalStaked` DECIMAL(16,4) NULL DEFAULT NULL,
  PRIMARY KEY (`validator_id`, `epoch`, `holder_address`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_linked_nodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_linked_nodes` (
  `validator_id` INT NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `active` TINYINT NULL DEFAULT '0',
  `balance` DECIMAL(16,4) NULL DEFAULT NULL,
  PRIMARY KEY (`validator_id`, `address`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_mastervalidator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_mastervalidator` (
  `Validator Main` TEXT NULL DEFAULT NULL,
  `Notes` TEXT NULL DEFAULT NULL,
  `Address` TEXT NULL DEFAULT NULL,
  `Validator ID` INT NOT NULL,
  PRIMARY KEY (`Validator ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_nodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_nodes` (
  `id` INT NOT NULL,
  `validator_id` INT NULL DEFAULT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `ip` VARCHAR(255) NULL DEFAULT NULL,
  `pub_key` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `port` VARCHAR(255) NULL DEFAULT NULL,
  `status` VARCHAR(255) NULL DEFAULT NULL,
  `balance` DECIMAL(16,4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_rewards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_rewards` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `escrow_address` VARCHAR(45) NULL DEFAULT NULL,
  `validator_id` INT NOT NULL,
  `claimed_rewards` DECIMAL(16,4) NULL DEFAULT NULL,
  `unclaimed_rewards` DECIMAL(16,4) NULL DEFAULT NULL,
  `rewards_to_date` DECIMAL(16,4) NULL DEFAULT NULL,
  `type` VARCHAR(45) NOT NULL,
  `earned_rewards` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`validator_id`, `address`, `type`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `address` (`address` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4361
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_token_inflation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_token_inflation` (
  `year_no` INT NULL DEFAULT NULL,
  `start_dt_int` INT NULL DEFAULT NULL,
  `starting_token_amount` DECIMAL(16,4) NULL DEFAULT NULL,
  `inflation` DECIMAL(16,4) NULL DEFAULT NULL,
  `ending_token_amount` DECIMAL(16,4) NULL DEFAULT NULL,
  `inflation_percent` DECIMAL(16,4) NULL DEFAULT NULL,
  `start_dt_datetime` DATETIME NULL DEFAULT NULL,
  `end_dt_datetime` DATETIME NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_validator_monthly`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_validator_monthly` (
  `validator_id` INT NOT NULL,
  `YYYYMM` INT NULL DEFAULT NULL,
  `MonthName` VARCHAR(45) NULL DEFAULT NULL,
  `epoch` INT NOT NULL,
  `TotalStaked` DECIMAL(16,4) NULL DEFAULT NULL,
  `TotalRewards` DECIMAL(16,4) NULL DEFAULT NULL,
  `TotalValidatorRewards` DECIMAL(16,4) NULL DEFAULT NULL,
  `TotalDelegatorRewards` DECIMAL(16,4) NULL DEFAULT NULL,
  PRIMARY KEY (`validator_id`, `epoch`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`skale_validators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`skale_validators` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `mdr` BIGINT NULL DEFAULT NULL,
  `fee_rate` DECIMAL(16,4) NULL DEFAULT NULL,
  `trusted` TINYINT(1) NULL DEFAULT NULL,
  `balance` DECIMAL(16,4) NULL DEFAULT NULL,
  `total_staked` BIGINT NULL DEFAULT NULL,
  `total_staked_next_epoch` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mainnet`.`xxx_skale_delegations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`xxx_skale_delegations` (
  `id` INT NOT NULL,
  `validator_id` INT NULL DEFAULT NULL,
  `created` BIGINT NULL DEFAULT NULL,
  `delegation_period` INT NULL DEFAULT NULL,
  `started` INT NULL DEFAULT NULL,
  `finished` INT NULL DEFAULT NULL,
  `holder_address` VARCHAR(255) NULL DEFAULT NULL,
  `info` VARCHAR(255) NULL DEFAULT NULL,
  `status` VARCHAR(255) NULL DEFAULT NULL,
  `amount` DECIMAL(16,4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `mainnet` ;

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`address_escrow_match_delegators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`address_escrow_match_delegators` (`escrow_address` INT, `holder_address` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`check_validator_node_reward_distribution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`check_validator_node_reward_distribution` (`dt` INT, `id` INT, `name` INT, `tx_hash` INT, `amount` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`contract_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`contract_stats` (`id` INT, `name` INT, `address` INT, `lastblock` INT, `repository` INT, `functions` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`escrow_holder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`escrow_holder` (`holder_address` INT, `escrow_address` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`gas_reimbursement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`gas_reimbursement` (`tx_hash` INT, `name` INT, `NodeOperator` INT, `tx_from` INT, `contract` INT, `contract_function_name` INT, `ethcost` INT, `tx_datetime` INT, `tx_timeStamp` INT, `tx_isError` INT, `contract_parameters` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`monthly_cumulative`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`monthly_cumulative` (`holder_address` INT, `validator_id` INT, `amt` INT, `created` INT, `startmonth` INT, `endmonth` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`monthly_expected_bounty_for_each_node_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`monthly_expected_bounty_for_each_node_address` (`year_month` INT, `node_address` INT, `inflation_epoch_per_node` INT, `this_epoch` INT, `prev_epoch` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`monthly_rewards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`monthly_rewards` (`node_address` INT, `validator_id` INT, `fee_rate` INT, `yyyymm` INT, `full_reward` INT, `validator_reward` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`monthlycumulative`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`monthlycumulative` (`holder_address` INT, `validator_id` INT, `amt` INT, `created` INT, `startmonth` INT, `endmonth` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`montly_active_nodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`montly_active_nodes` (`year_month` INT, `active_nodes_in_network` INT, `inflation_for_epoch` INT, `inflation_epoch_per_node` INT, `inflation_for_year` INT, `inflation_percent` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`network_delegation_monthly_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`network_delegation_monthly_stats` (`Total_Amount_In_Delegated_Status` INT, `YearMonth` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`network_delegation_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`network_delegation_stats` (`Total_Amount_In_Delegated_Status` INT, `Total_Amount_In_Un_Delegated_Status` INT, `Total_Amount_In_Canceled_Status` INT, `Total_Amount_In_Accepted_Status` INT, `Total_Amount_In_Proposed_Status` INT, `Total_count_In_Delegated_Status` INT, `Total_count_In_Un_Delegated_Status` INT, `Total_count_In_Canceled_Status` INT, `Total_count_In_Accepted_Status` INT, `Total_count_In_Proposed_Status` INT, `Total_count_In_Completed_Status` INT, `current_unique_delegators` INT, `next_epoch_unique_delegators` INT, `Total_Amount_UnDelegated_Next_Epoch` INT, `Total_count_UnDelegated_Next_Epoch` INT, `total_staked_this_epoch` INT, `total_staked_cnt_this_epoch` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`network_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`network_stats` (`Total_Amount_In_Delegated_Status` INT, `Total_Amount_In_Accepted_Status` INT, `Total_Amount_In_Un_Delegated_Status` INT, `Total_Amount_In_Canceled_Status` INT, `Total_Amount_In_Proposed_Status` INT, `Total_count_In_Delegated_Status` INT, `Total_count_In_Un_Delegated_Status` INT, `CurrentDelegationCount` INT, `Total_count_In_Canceled_Status` INT, `Total_count_In_Accepted_Status` INT, `Total_count_In_Proposed_Status` INT, `Total_Amount_UnDelegated_Next_Epoch` INT, `Total_count_In_Completed_Status` INT, `total_staked_this_epoch` INT, `Total_Amount_Current_Delegations` INT, `Total_Amount_Delegated_Next_Epoch` INT, `Total_Count_Delegated_Next_Epoch` INT, `validator_count` INT, `active_nodes_in_network` INT, `active_nodes_needed_next_epoch` INT, `linked_nodes_count` INT, `gasusedETH` INT, `current_unique_delegators` INT, `next_epoch_unique_delegators` INT, `amt_and_nodes` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`node_dates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`node_dates` (`node_address` INT, `registration_date` INT, `exit_date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`node_operator_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`node_operator_stats` (`node_operator` INT, `validator_addresses` INT, `Total_Amount_In_Delegated_Status` INT, `Total_Amount_In_Accepted_Status` INT, `Total_Amount_In_Un_Delegated_Status` INT, `Total_Amount_In_Canceled_Status` INT, `Total_Amount_In_Proposed_Status` INT, `Total_count_In_Delegated_Status` INT, `Total_count_In_Un_Delegated_Status` INT, `Total_count_In_Canceled_Status` INT, `Total_count_In_Accepted_Status` INT, `Total_count_In_Proposed_Status` INT, `Total_Amount_UnDelegated_Next_Epoch` INT, `Total_Amount_Current_Delegations` INT, `Total_Amount_Delegated_Next_Epoch` INT, `Total_Count_Delegated_Next_Epoch` INT, `del_needed_for_next_node` INT, `del_needed_for_next_node_with_proposed` INT, `active_nodes_in_network` INT, `active_nodes_needed_current_epoch` INT, `active_nodes_needed_next_epoch` INT, `gastUsedByValidatorAccount` INT, `totalGasUsedByAllNodes` INT, `totalGasUsed` INT, `current_unique_delegators` INT, `next_epoch_unique_delegators` INT, `linked_nodes` INT, `linked_nodes_count` INT, `missing_linked_nodes` INT, `registered_nodes` INT, `missing_registered_nodes` INT, `expected_NodeBounty_NextEpoch` INT, `expected_validator_fee` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`node_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`node_stats` (`id` INT, `validator_id` INT, `validator_name` INT, `validator_address` INT, `address` INT, `name` INT, `balance` INT, `status` INT, `ip` INT, `pub_key` INT, `port` INT, `called_getBounty_this_epoch` INT, `registration_date` INT, `last_bounty_Call` INT, `node_exit_date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`node_transaction_agg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`node_transaction_agg` (`node_address` INT, `last_bounty_Call` INT, `registration_date` INT, `node_id` INT, `totalGasUsedBYNODE` INT, `bounty` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`rewards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`rewards` (`address` INT, `escrow_address` INT, `validator_id` INT, `claimed_rewards` INT, `unclaimed_rewards` INT, `rewards_to_date` INT, `type` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`validator_delegations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`validator_delegations` (`validator_id` INT, `Total_Amount_In_Delegated_Status` INT, `Total_Amount_In_Un_Delegated_Status` INT, `Total_Amount_In_Canceled_Status` INT, `Total_Amount_In_Accepted_Status` INT, `Total_Amount_In_Proposed_Status` INT, `Total_count_In_Delegated_Status` INT, `Total_count_In_Un_Delegated_Status` INT, `Total_count_In_Canceled_Status` INT, `Total_count_In_Accepted_Status` INT, `Total_count_In_Proposed_Status` INT, `current_unique_delegators` INT, `next_epoch_unique_delegators` INT, `Total_Amount_UnDelegated_Next_Epoch` INT, `Total_count_UnDelegated_Next_Epoch` INT, `Total_Amount_In_Delegated_Activate_CanBeUndelegated` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`validator_nodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`validator_nodes` (`validator_id` INT, `active_nodes_in_network` INT, `totalGasUsedByAllNodes` INT, `expected_earned_rewards_to_date` INT, `expected_rewards_this_epoch` INT, `registered_nodes` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`validator_registration_dates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`validator_registration_dates` (`address` INT, `registration_date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`validator_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`validator_stats` (`id` INT, `name` INT, `address` INT, `mdr` INT, `fee_rate` INT, `trusted` INT, `balance` INT, `node_operator` INT, `Total_Amount_In_Delegated_Status` INT, `Total_Amount_In_Accepted_Status` INT, `Total_Amount_In_Un_Delegated_Status` INT, `Total_Amount_In_Canceled_Status` INT, `Total_Amount_In_Proposed_Status` INT, `Total_count_In_Delegated_Status` INT, `Total_count_In_Un_Delegated_Status` INT, `Total_count_In_Canceled_Status` INT, `Total_count_In_Accepted_Status` INT, `Total_count_In_Proposed_Status` INT, `Total_Amount_UnDelegated_Next_Epoch` INT, `Total_Amount_Current_Delegations` INT, `Total_Amount_Delegated_Next_Epoch` INT, `Total_Count_Delegated_Next_Epoch` INT, `del_needed_for_next_node` INT, `del_needed_for_next_node_with_proposed` INT, `active_nodes_in_network` INT, `active_nodes_needed_current_epoch` INT, `active_nodes_needed_next_epoch` INT, `gastUsedByValidatorAccount` INT, `totalGasUsedByAllNodes` INT, `totalGasUsed` INT, `current_unique_delegators` INT, `next_epoch_unique_delegators` INT, `linked_nodes` INT, `linked_nodes_count` INT, `missing_linked_nodes` INT, `registered_nodes` INT, `missing_registered_nodes` INT, `expected_earned_rewards_to_date` INT, `expected_validator_fee_to_date` INT, `expected_rewards_this_epoch` INT, `expected_validator_fee_this_epoch` INT, `received_validator_fee_to_date` INT, `unclaimed_rewards` INT, `claimed_rewards` INT, `Total_Amount_In_Delegated_Activate_CanBeUndelegated` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`vi_node_checks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`vi_node_checks` (`id` INT, `validator_id` INT, `Name` INT, `IP` INT, `Status` INT, `Address` INT, `BalanceInWei` INT, `BaseContainers` INT, `SgxInfo` INT, `IsNodeActive` INT, `SRW_balance` INT, `BalanceCheck` INT, `ContainerStatuses` INT, `ComponentVersions` INT, `SgxStatus` INT, `SGXVersion` INT, `Endpoint` INT, `Hardware` INT, `Trusted endpoint` INT, `Filebeat logs` INT, `BTRFS` INT, `Val nodes` INT, `Public IP` INT, `Cores` INT, `CoreCheck` INT, `Memory` INT, `MemoryCheck` INT, `Storage` INT, `StorageCheck` INT, `Swap` INT, `SwapCheck` INT, `container_admin` INT, `container_API` INT, `nginx` INT, `container_TransactionManager` INT, `container_Mysql` INT, `container_WatchDog` INT, `container_Bounty` INT, `container_Filebeat` INT, `container_Configs` INT, `container_CLI` INT, `container_sChain` INT, `container_IMA` INT, `container_Lvmpy` INT, `full_health` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`vi_validator_ready`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`vi_validator_ready` (`validator_id` INT, `status` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mainnet`.`vw_addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mainnet`.`vw_addresses` (`NodeOperator` INT, `address` INT, `name` INT, `val_id` INT);

-- -----------------------------------------------------
-- procedure Load_Proxy_Contracts_procedure
-- -----------------------------------------------------

DELIMITER $$
USE `mainnet`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Load_Proxy_Contracts_procedure`()
BEGIN

INSERT INTO `mainnet`.`skale_contract_proxy`
 (`name`,
 `address`,
 `lastblock`,
 `repository`,
 `last_internal_tx_block`,
 `implementation_address`,
 `implementation_name`,
 `holder_address`
 )
 SELECT  distinct
  'proxy_contract' as name,
  tx_contractAddress as address,
  0 high_watemark,
  'Allocator' as repository,
  null,
  contract_implementation_address ,
  sc.name as implementation_name,
  d.holder_address
  FROM mainnet.skale_contract_internal_transactions
  LEFT OUTER JOIN skale_contract sc on sc.address = skale_contract_internal_transactions.tx_contractAddress
  LEFT JOIN address_escrow_match_delegators  d ON tx_contractAddress =  d.escrow_address
  WHERE sc.address is null
ON DUPLICATE KEY UPDATE
`name` = VALUES(name),
`address` = VALUES(address ),
`lastblock` = VALUES(lastblock),
`repository` = VALUES(repository ),
`last_internal_tx_block` = VALUES(last_internal_tx_block ),
`implementation_address` = VALUES(implementation_address ),
`implementation_name` = VALUES(implementation_name ),
`holder_address` = VALUES(holder_address);


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Load_Token_stake_monthly
-- -----------------------------------------------------

DELIMITER $$
USE `mainnet`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Load_Token_stake_monthly`()
BEGIN

INSERT INTO `mainnet`.`skale_validator_monthly`
(`validator_id`,
`YYYYMM`,
`MonthName`,
`epoch`,
`TotalStaked`,
`TotalRewards`,
`TotalValidatorRewards`,
`TotalDelegatorRewards`)

SELECT
	sd.validator_id,
	ct.YYYYMM,
    monthName,
	epoch,
	sum(amt) TotalStaked,
    max(full_reward) TotalRewards,
	max(validator_reward) TotalValidatorRewards,
	max(delegator_rewards) TotalDelegatorRewards
FROM
	(SELECT distinct concat(y,LPAD(m,2,0)) YYYYMM,
    concat(y,'-',m) YYYY_MM,
    monthName,
	epoch from mainnet.calendar_table) ct
JOIN
(
	SELECT 	validator_id,
			sum(amount) amt,
			started as startmonth,
			case when finished = 0 then TIMESTAMPDIFF(MONTH,'2020-01-01',now())+1  else finished-1 end endmonth
		FROM
			mainnet.skale_delegations sd
		WHERE status in ('DELEGATED','COMPLETED','ACCEPTED', 'UNDELEGATION_REQUESTED')
		GROUP BY
			validator_id,started,finished

)sd ON ct.epoch between sd.startmonth and sd.endmonth
LEFT OUTER JOIN
(
	SELECT
		validator_id,
		yyyymm,
		sum(full_reward) full_reward,
		sum(validator_reward) validator_reward,
		sum(full_reward) - sum(validator_reward) as delegator_rewards
	FROM mainnet.monthly_rewards
	GROUP BY
		validator_id,
		yyyymm
	HAVING
		sum(full_reward)>0
)rw ON rw.yyyymm = YYYY_MM and rw.validator_id = sd.validator_id
group by
    sd.validator_id,
	ct.YYYYMM,
    monthName,
	epoch
order by
	sd.validator_id,
	ct.YYYYMM,
    monthName,
	epoch
ON DUPLICATE KEY UPDATE
`validator_id` = VALUES(validator_id),
`YYYYMM` = VALUES(YYYYMM),
`MonthName` = VALUES(MonthName),
`epoch` = VALUES(epoch),
`TotalStaked` = VALUES(TotalStaked),
`TotalRewards` = VALUES(TotalRewards),
`TotalValidatorRewards` = VALUES(`TotalValidatorRewards`),
`TotalDelegatorRewards` = VALUES(`TotalDelegatorRewards`)
;

INSERT INTO `mainnet`.`skale_delegator_monthly`
(`holder_address`,
`validator_id`,
`YYYYMM`,
`MonthName`,
`epoch`,
`TotalStaked`)
SELECT
	holder_address,
	sd.validator_id,
	YYYYMM,
    monthName,
	epoch,
	sum(amt) TotalStaked
FROM
	(SELECT distinct concat(y,LPAD(m,2,0)) YYYYMM,
    monthName,
	epoch from mainnet.calendar_table) ct
JOIN
(
	SELECT 	holder_address,
			validator_id,
			sum(amount) amt,
			started as startmonth,
			case when finished = 0 then TIMESTAMPDIFF(MONTH,'2020-01-01',now())+1  else finished-1 end endmonth
		FROM
			mainnet.skale_delegations sd
		WHERE status in ('DELEGATED','COMPLETED','ACCEPTED', 'UNDELEGATION_REQUESTED')
		GROUP BY
			holder_address,validator_id,started,finished

)sd ON ct.epoch >= sd.startmonth and ct.epoch<=sd.endmonth
group by
	holder_address,
    sd.validator_id,
	YYYYMM,
    monthName,
	epoch
order by
	holder_address,
	sd.validator_id,
	YYYYMM,
    monthName,
	epoch
ON DUPLICATE KEY UPDATE
`holder_address` = VALUES(holder_address),
`validator_id` = VALUES(validator_id),
`YYYYMM` = VALUES(YYYYMM),
`MonthName` = VALUES(MonthName),
`epoch` = VALUES(epoch),
`TotalStaked` = VALUES(`TotalStaked`);


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Load_rewards_table
-- -----------------------------------------------------

DELIMITER $$
USE `mainnet`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Load_rewards_table`()
BEGIN

INSERT INTO `mainnet`.`skale_rewards`
(`address`,
`escrow_address`,
`validator_id`,
`claimed_rewards`,
`unclaimed_rewards`,
`rewards_to_date`,
`type`,
`earned_rewards`)
	SELECT
    `rewards`.`address`,
    MAX(`rewards`.`escrow_address`),
    `rewards`.`validator_id`,
    SUM(`rewards`.`claimed_rewards`),
    SUM(`rewards`.`unclaimed_rewards`),
    SUM(`rewards`.`rewards_to_date`),
    `rewards`.`type`,
    case when SUM(`rewards`.`rewards_to_date`) >0 then 1 else 0 end as `earned_rewards`
FROM `mainnet`.`rewards`
GROUP BY `rewards`.`address` ,  `rewards`.`validator_id`, `rewards`.`type`
ON DUPLICATE KEY UPDATE
`address` = VALUES(address),
`escrow_address` = VALUES(escrow_address),
`validator_id` = VALUES(validator_id),
`claimed_rewards` = VALUES(claimed_rewards),
`unclaimed_rewards` = VALUES(unclaimed_rewards),
`rewards_to_date` = VALUES(rewards_to_date),
`type` = VALUES(`type`),
`earned_rewards` = VALUES(earned_rewards);


END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `mainnet`.`address_escrow_match_delegators`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`address_escrow_match_delegators`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`address_escrow_match_delegators` AS select `it`.`tx_contractAddress` AS `escrow_address`,replace(json_extract(`t`.`contract_parameters`,'$.beneficiary'),'"','') AS `holder_address` from (`mainnet`.`skale_contract_transactions` `t` left join `mainnet`.`skale_contract_internal_transactions` `it` on((`it`.`tx_hash` = `t`.`tx_hash`))) where (`t`.`contract_function_name` = 'connectBeneficiaryToPlan');

-- -----------------------------------------------------
-- View `mainnet`.`check_validator_node_reward_distribution`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`check_validator_node_reward_distribution`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`check_validator_node_reward_distribution` AS select date_format(from_unixtime(`ct`.`tx_timeStamp`),'%Y%m%d') AS `dt`,`n`.`id` AS `id`,`v`.`name` AS `name`,`ct`.`tx_hash` AS `tx_hash`,(`tt`.`tx_value` / 1000000000000000000) AS `amount` from (((`mainnet`.`skale_contract_transactions` `ct` left join `mainnet`.`skale_contract_token_transactions` `tt` on((`ct`.`tx_hash` = `tt`.`tx_hash`))) left join `mainnet`.`skale_nodes` `n` on((`n`.`id` = json_extract(`ct`.`contract_parameters`,'$.nodeIndex')))) left join `mainnet`.`skale_validators` `v` on((`n`.`validator_id` = `v`.`id`))) where ((`ct`.`contract_function_name` = 'getBounty') and (date_format(from_unixtime(`ct`.`tx_timeStamp`),'%Y%m') = 202011) and (`ct`.`tx_isError` <> 1)) order by `v`.`name`;

-- -----------------------------------------------------
-- View `mainnet`.`contract_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`contract_stats`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`contract_stats` AS select `mainnet`.`skale_contract`.`id` AS `id`,`mainnet`.`skale_contract`.`name` AS `name`,`mainnet`.`skale_contract`.`address` AS `address`,`mainnet`.`skale_contract`.`lastblock` AS `lastblock`,`mainnet`.`skale_contract`.`repository` AS `repository`,`svl`.`functions` AS `functions` from (`mainnet`.`skale_contract` left join (select `ca`.`contract_address` AS `contract_address`,json_arrayagg(json_object('gasusedETH',`ca`.`gasusedETH`,'function_name',`ca`.`contract_function_name`)) AS `functions` from (select sum((((`svl`.`tx_gasPrice` / 1000000000) * `svl`.`tx_gasUsed`) / 1000000000)) AS `gasusedETH`,`svl`.`contract_address` AS `contract_address`,`svl`.`contract_function_name` AS `contract_function_name` from `mainnet`.`skale_contract_transactions` `svl` where (coalesce(`svl`.`contract_function_name`,'') <> '') group by `svl`.`contract_address`,`svl`.`contract_function_name`) `ca` group by `ca`.`contract_address`) `svl` on((`mainnet`.`skale_contract`.`address` = `svl`.`contract_address`))) where (`mainnet`.`skale_contract`.`id` is not null);

-- -----------------------------------------------------
-- View `mainnet`.`escrow_holder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`escrow_holder`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`escrow_holder` AS select distinct `t`.`tx_from` AS `holder_address`,(case when (`cp`.`address` is not null) then `t`.`contract_address` else NULL end) AS `escrow_address` from (`mainnet`.`skale_contract_transactions` `t` join `mainnet`.`skale_contract_proxy` `cp` on((`cp`.`address` = `t`.`tx_to`))) where (`t`.`contract_function_name` = 'delegate');

-- -----------------------------------------------------
-- View `mainnet`.`gas_reimbursement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`gas_reimbursement`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`gas_reimbursement` AS select `aaa`.`tx_hash` AS `tx_hash`,`v`.`name` AS `name`,`v`.`NodeOperator` AS `NodeOperator`,`aaa`.`tx_from` AS `tx_from`,`aaa`.`contract` AS `contract`,`aaa`.`contract_function_name` AS `contract_function_name`,`aaa`.`ethcost` AS `ethcost`,`aaa`.`tx_datetime` AS `tx_datetime`,`aaa`.`tx_timeStamp` AS `tx_timeStamp`,`aaa`.`tx_isError` AS `tx_isError`,`aaa`.`contract_parameters` AS `contract_parameters` from ((select `t`.`tx_from` AS `tx_from`,`t`.`tx_isError` AS `tx_isError`,`t`.`tx_timeStamp` AS `tx_timeStamp`,`t`.`tx_hash` AS `tx_hash`,`c`.`name` AS `contract`,from_unixtime(`t`.`tx_timeStamp`) AS `tx_datetime`,`t`.`contract_parameters` AS `contract_parameters`,`t`.`contract_function_name` AS `contract_function_name`,(((`t`.`tx_gasPrice` / 1000000000) * `t`.`tx_gasUsed`) / 1000000000) AS `ethcost` from (`mainnet`.`skale_contract_transactions` `t` left join `mainnet`.`skale_contract` `c` on((`c`.`address` = `t`.`contract_address`))) where ((`c`.`name` in ('delegation_controller','validator_service','skale_manager')) and (`t`.`contract_function_name` in ('acceptPendingDelegation','requestForNewAddress','confirmNewAddress','linkNodeAddress','unlinkNodeAddress','registerValidator','nodeExit','getBounty','createNode','setValidatorDescription','setValidatorMDA','setValidatorName')))) `aaa` left join `mainnet`.`vw_addresses` `v` on((lower(`aaa`.`tx_from`) = lower(`v`.`address`)))) where (`aaa`.`tx_isError` <> 1) order by `v`.`name`;

-- -----------------------------------------------------
-- View `mainnet`.`monthly_cumulative`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`monthly_cumulative`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`monthly_cumulative` AS select `sd`.`holder_address` AS `holder_address`,`sd`.`validator_id` AS `validator_id`,sum(`sd`.`amount`) AS `amt`,date_format(from_unixtime(`sd`.`created`),'%Y%m%d') AS `created`,`sd`.`started` AS `startmonth`,(case when (`sd`.`finished` = 0) then (timestampdiff(MONTH,'2020-01-01',now()) + 1) else (`sd`.`finished` - 1) end) AS `endmonth` from `mainnet`.`skale_delegations` `sd` where ((`sd`.`status` in ('DELEGATED','COMPLETED','ACCEPTED','UNDELEGATION_REQUESTED')) and (`sd`.`finished` <= (timestampdiff(MONTH,'2020-01-01',now()) + 1))) group by `sd`.`holder_address`,`sd`.`validator_id`,`sd`.`created`,`sd`.`started`,`sd`.`finished` union select `sd`.`holder_address` AS `holder_address`,`sd`.`validator_id` AS `validator_id`,-(sum(`sd`.`amount`)) AS `amt`,(last_day(('2020-01-01' + interval `sd`.`finished` month)) - interval (dayofmonth(last_day(('2020-01-01' + interval `sd`.`finished` month))) - 1) day) AS `created`,`sd`.`started` AS `startmonth`,(case when (`sd`.`finished` = 0) then (timestampdiff(MONTH,'2020-01-01',now()) + 1) else (`sd`.`finished` - 1) end) AS `endmonth` from `mainnet`.`skale_delegations` `sd` where ((`sd`.`status` = 'COMPLETED') and (`sd`.`finished` <= (timestampdiff(MONTH,'2020-01-01',now()) + 1))) group by `sd`.`holder_address`,`sd`.`validator_id`,`sd`.`created`,`sd`.`started`,`sd`.`finished`;

-- -----------------------------------------------------
-- View `mainnet`.`monthly_expected_bounty_for_each_node_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`monthly_expected_bounty_for_each_node_address`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`monthly_expected_bounty_for_each_node_address` AS select `nodes`.`year_month` AS `year_month`,`nodes`.`node_address` AS `node_address`,`an`.`inflation_epoch_per_node` AS `inflation_epoch_per_node`,(case when (`nodes`.`year_month` = date_format(curdate(),'%Y-%m')) then 1 else 0 end) AS `this_epoch`,(case when (`nodes`.`year_month` = date_format((curdate() + interval -(1) month),'%Y-%m')) then 1 else 0 end) AS `prev_epoch` from ((select date_format(`c`.`dt`,'%Y-%m') AS `year_month`,`nd`.`node_address` AS `node_address` from (`mainnet`.`calendar_table` `c` left join `mainnet`.`node_dates` `nd` on(((`c`.`dt` >= `nd`.`registration_date`) and (`c`.`dt` <= coalesce(`nd`.`exit_date`,curdate())) and ((case when (`nd`.`exit_date` is not null) then (((to_days(`nd`.`exit_date`) - to_days(`nd`.`registration_date`)) >= 27) and ((to_days(`nd`.`exit_date`) - to_days((`nd`.`exit_date` + interval (-(dayofmonth(`nd`.`exit_date`)) + 1) day))) >= 27)) else 1 end) = 1)))) where ((`c`.`dt` >= '2020-09-01 00:00:00') and (`c`.`dt` <= curdate())) group by date_format(`c`.`dt`,'%Y-%m'),`nd`.`node_address`) `nodes` left join `mainnet`.`montly_active_nodes` `an` on((`an`.`year_month` = `nodes`.`year_month`))) where (`nodes`.`node_address` is not null);

-- -----------------------------------------------------
-- View `mainnet`.`monthly_rewards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`monthly_rewards`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`monthly_rewards` AS select `mainnet`.`skale_contract_transactions`.`tx_from` AS `node_address`,`mainnet`.`skale_nodes`.`validator_id` AS `validator_id`,`mainnet`.`skale_validators`.`fee_rate` AS `fee_rate`,date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m') AS `yyyymm`,coalesce(sum((`st`.`tx_value` / 1000000000000000000)),0) AS `full_reward`,(((coalesce(sum((`st`.`tx_value` / 1000000000000000000)),0) * `mainnet`.`skale_validators`.`fee_rate`) / 10) / 100) AS `validator_reward` from (((`mainnet`.`skale_contract_transactions` left join `mainnet`.`skale_contract_token_transactions` `st` on((`st`.`tx_hash` = `mainnet`.`skale_contract_transactions`.`tx_hash`))) left join `mainnet`.`skale_nodes` on((`mainnet`.`skale_nodes`.`address` = `mainnet`.`skale_contract_transactions`.`tx_from`))) left join `mainnet`.`skale_validators` on((`mainnet`.`skale_nodes`.`validator_id` = `mainnet`.`skale_validators`.`id`))) where ((`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'getBounty') and (`mainnet`.`skale_contract_transactions`.`tx_isError` <> 1)) group by `mainnet`.`skale_contract_transactions`.`tx_from`,`mainnet`.`skale_nodes`.`validator_id`,`mainnet`.`skale_validators`.`fee_rate`,date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m');

-- -----------------------------------------------------
-- View `mainnet`.`monthlycumulative`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`monthlycumulative`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`monthlycumulative` AS select `sd`.`holder_address` AS `holder_address`,`sd`.`validator_id` AS `validator_id`,sum(`sd`.`amount`) AS `amt`,date_format(from_unixtime(`sd`.`created`),'%Y%m%d') AS `created`,`sd`.`started` AS `startmonth`,(case when (`sd`.`finished` = 0) then (timestampdiff(MONTH,'2020-01-01',now()) + 1) else (`sd`.`finished` - 1) end) AS `endmonth` from `mainnet`.`skale_delegations` `sd` where ((`sd`.`status` in ('DELEGATED','COMPLETED','ACCEPTED','UNDELEGATION_REQUESTED')) and (`sd`.`finished` <= (timestampdiff(MONTH,'2020-01-01',now()) + 1))) group by `sd`.`holder_address`,`sd`.`validator_id`,`sd`.`created`,`sd`.`started`,`sd`.`finished`;

-- -----------------------------------------------------
-- View `mainnet`.`montly_active_nodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`montly_active_nodes`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`montly_active_nodes` AS select date_format(`c`.`dt`,'%Y-%m') AS `year_month`,count(distinct `nd`.`node_address`) AS `active_nodes_in_network`,coalesce((min(`ti`.`inflation`) / 12),0) AS `inflation_for_epoch`,coalesce(((min(`ti`.`inflation`) / 12) / count(distinct `nd`.`node_address`)),0) AS `inflation_epoch_per_node`,coalesce(max(`ti`.`inflation`),0) AS `inflation_for_year`,coalesce(max(`ti`.`inflation_percent`),0) AS `inflation_percent` from ((`mainnet`.`calendar_table` `c` left join `mainnet`.`node_dates` `nd` on(((`c`.`dt` >= `nd`.`registration_date`) and (`c`.`dt` <= coalesce(`nd`.`exit_date`,curdate())) and ((case when (`nd`.`exit_date` is not null) then (((to_days(`nd`.`exit_date`) - to_days(`nd`.`registration_date`)) >= 27) and ((to_days(`nd`.`exit_date`) - to_days((`nd`.`exit_date` + interval (-(dayofmonth(`nd`.`exit_date`)) + 1) day))) >= 27)) else 1 end) = 1)))) left join `mainnet`.`skale_token_inflation` `ti` on((`c`.`dt` between `ti`.`start_dt_datetime` and `ti`.`end_dt_datetime`))) where ((`c`.`dt` >= '2020-09-01 00:00:00') and (`c`.`dt` <= curdate())) group by date_format(`c`.`dt`,'%Y-%m');

-- -----------------------------------------------------
-- View `mainnet`.`network_delegation_monthly_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`network_delegation_monthly_stats`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`network_delegation_monthly_stats` AS select sum(`skd`.`amount`) AS `Total_Amount_In_Delegated_Status`,date_format(from_unixtime(`skd`.`created`),'%Y-%m') AS `YearMonth` from `mainnet`.`skale_delegations` `skd` where (`skd`.`status` in ('DELEGATED','COMPLETED','UNDELEGATION_REQUESTED','ACCEPTED')) group by date_format(from_unixtime(`skd`.`created`),'%Y-%m');

-- -----------------------------------------------------
-- View `mainnet`.`network_delegation_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`network_delegation_stats`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`network_delegation_stats` AS select sum((case when (`skd`.`status` = 'DELEGATED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Delegated_Status`,sum((case when (`skd`.`status` = 'UNDELEGATION_REQUESTED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Un_Delegated_Status`,sum((case when (`skd`.`status` = 'CANCELED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Canceled_Status`,sum((case when (`skd`.`status` = 'ACCEPTED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Accepted_Status`,sum((case when (`skd`.`status` = 'PROPOSED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Proposed_Status`,count(distinct (case when (`skd`.`status` = 'DELEGATED') then `skd`.`id` else NULL end)) AS `Total_count_In_Delegated_Status`,count(distinct (case when (`skd`.`status` = 'UNDELEGATION_REQUESTED') then `skd`.`id` else NULL end)) AS `Total_count_In_Un_Delegated_Status`,count(distinct (case when (`skd`.`status` = 'CANCELED') then `skd`.`id` else NULL end)) AS `Total_count_In_Canceled_Status`,count(distinct (case when (`skd`.`status` = 'ACCEPTED') then `skd`.`id` else NULL end)) AS `Total_count_In_Accepted_Status`,count(distinct (case when (`skd`.`status` = 'PROPOSED') then `skd`.`id` else NULL end)) AS `Total_count_In_Proposed_Status`,count(distinct (case when (`skd`.`status` = 'COMPLETED') then `skd`.`id` else NULL end)) AS `Total_count_In_Completed_Status`,count(distinct (case when ((`skd`.`status` = 'DELEGATED') or (`skd`.`status` = 'UNDELEGATION_REQUESTED')) then `skd`.`holder_address` else NULL end)) AS `current_unique_delegators`,count(distinct (case when ((`skd`.`status` = 'DELEGATED') or (((period_diff(month((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day)),month((last_day(curdate()) + interval 1 day))) % `skd`.`delegation_period`) > 0) and (`skd`.`status` = 'UNDELEGATION_REQUESTED')) or (`skd`.`status` = 'ACCEPTED')) then `skd`.`holder_address` else NULL end)) AS `next_epoch_unique_delegators`,sum((case when (((period_diff(month((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day)),month((last_day(curdate()) + interval 1 day))) % `skd`.`delegation_period`) = 0) and (`skd`.`status` = 'UNDELEGATION_REQUESTED')) then `skd`.`amount` else 0 end)) AS `Total_Amount_UnDelegated_Next_Epoch`,count(distinct (case when (((period_diff(month((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day)),month((last_day(curdate()) + interval 1 day))) % `skd`.`delegation_period`) = 0) and (`skd`.`status` = 'UNDELEGATION_REQUESTED')) then `skd`.`id` else NULL end)) AS `Total_count_UnDelegated_Next_Epoch`,sum((case when (((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day) <= ((last_day(curdate()) + interval 1 day) - interval 1 month)) and (`skd`.`status` in ('DELEGATED','UNDELEGATION_REQUESTED'))) then `skd`.`amount` else 0 end)) AS `total_staked_this_epoch`,count(distinct (case when (((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day) <= ((last_day(curdate()) + interval 1 day) - interval 1 month)) and (`skd`.`status` in ('DELEGATED','UNDELEGATION_REQUESTED','COMPLETED'))) then `skd`.`holder_address` else 0 end)) AS `total_staked_cnt_this_epoch` from `mainnet`.`skale_delegations` `skd`;

-- -----------------------------------------------------
-- View `mainnet`.`network_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`network_stats`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`network_stats` AS select `delegation`.`Total_Amount_In_Delegated_Status` AS `Total_Amount_In_Delegated_Status`,`delegation`.`Total_Amount_In_Accepted_Status` AS `Total_Amount_In_Accepted_Status`,`delegation`.`Total_Amount_In_Un_Delegated_Status` AS `Total_Amount_In_Un_Delegated_Status`,`delegation`.`Total_Amount_In_Canceled_Status` AS `Total_Amount_In_Canceled_Status`,`delegation`.`Total_Amount_In_Proposed_Status` AS `Total_Amount_In_Proposed_Status`,`delegation`.`Total_count_In_Delegated_Status` AS `Total_count_In_Delegated_Status`,`delegation`.`Total_count_In_Un_Delegated_Status` AS `Total_count_In_Un_Delegated_Status`,(`delegation`.`Total_count_In_Delegated_Status` + `delegation`.`Total_count_In_Un_Delegated_Status`) AS `CurrentDelegationCount`,`delegation`.`Total_count_In_Canceled_Status` AS `Total_count_In_Canceled_Status`,`delegation`.`Total_count_In_Accepted_Status` AS `Total_count_In_Accepted_Status`,`delegation`.`Total_count_In_Proposed_Status` AS `Total_count_In_Proposed_Status`,`delegation`.`Total_Amount_UnDelegated_Next_Epoch` AS `Total_Amount_UnDelegated_Next_Epoch`,`delegation`.`Total_count_In_Completed_Status` AS `Total_count_In_Completed_Status`,`delegation`.`total_staked_this_epoch` AS `total_staked_this_epoch`,(`delegation`.`Total_Amount_In_Delegated_Status` + `delegation`.`Total_Amount_In_Un_Delegated_Status`) AS `Total_Amount_Current_Delegations`,(((`delegation`.`Total_Amount_In_Delegated_Status` + `delegation`.`Total_Amount_In_Un_Delegated_Status`) + `delegation`.`Total_Amount_In_Accepted_Status`) - `delegation`.`Total_Amount_UnDelegated_Next_Epoch`) AS `Total_Amount_Delegated_Next_Epoch`,(((`delegation`.`Total_count_In_Delegated_Status` + `delegation`.`Total_count_In_Un_Delegated_Status`) + `delegation`.`Total_count_In_Accepted_Status`) - `delegation`.`Total_count_UnDelegated_Next_Epoch`) AS `Total_Count_Delegated_Next_Epoch`,`skale_validators`.`validator_count` AS `validator_count`,`skn`.`active_nodes_in_network` AS `active_nodes_in_network`,floor(((((`delegation`.`Total_Amount_In_Delegated_Status` + `delegation`.`Total_Amount_In_Un_Delegated_Status`) + `delegation`.`Total_Amount_In_Accepted_Status`) - `delegation`.`Total_Amount_UnDelegated_Next_Epoch`) / 20000000)) AS `active_nodes_needed_next_epoch`,`sln`.`linked_nodes_count` AS `linked_nodes_count`,`gas`.`gasusedETH` AS `gasusedETH`,`delegation`.`current_unique_delegators` AS `current_unique_delegators`,`delegation`.`next_epoch_unique_delegators` AS `next_epoch_unique_delegators`,`amount_node`.`amt_and_nodes` AS `amt_and_nodes` from ((((((select count(distinct `mainnet`.`skale_validators`.`id`) AS `validator_count` from `mainnet`.`skale_validators` where (`mainnet`.`skale_validators`.`trusted` = 1)) `skale_validators` left join `mainnet`.`network_delegation_stats` `delegation` on((1 = 1))) left join (select count(distinct (case when (`mainnet`.`skale_nodes`.`status` = 0) then `mainnet`.`skale_nodes`.`id` else NULL end)) AS `active_nodes_in_network` from `mainnet`.`skale_nodes`) `skn` on((1 = 1))) left join (select count(distinct `mainnet`.`skale_linked_nodes`.`address`) AS `linked_nodes_count` from `mainnet`.`skale_linked_nodes`) `sln` on((1 = 1))) left join (select sum((((`ctx`.`tx_gasPrice` / 1000000000) * `ctx`.`tx_gasUsed`) / 1000000000)) AS `gasusedETH` from `mainnet`.`skale_contract_transactions` `ctx`) `gas` on((1 = 1))) left join (select sum(`abc`.`amt_and_nodes`) AS `amt_and_nodes` from (select `v`.`id` AS `id`,`v`.`name` AS `name`,`v`.`address` AS `address`,(sum(`d`.`amount`) * count(distinct `n`.`id`)) AS `amt_and_nodes` from ((`mainnet`.`skale_delegations` `d` join `mainnet`.`skale_validators` `v` on((`v`.`id` = `d`.`validator_id`))) join `mainnet`.`skale_nodes` `n` on((`n`.`validator_id` = `v`.`id`))) where ((`n`.`status` <> 2) and (`d`.`status` in ('DELEGATED','UNDELEGATION_REQUESTED'))) group by `v`.`id`,`v`.`name`,`v`.`address`) `abc`) `amount_node` on((1 = 1)));

-- -----------------------------------------------------
-- View `mainnet`.`node_dates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`node_dates`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`node_dates` AS select `node_dates`.`node_address` AS `node_address`,`node_dates`.`registration_date` AS `registration_date`,`node_dates`.`exit_date` AS `exit_date` from (select `mainnet`.`skale_contract_transactions`.`tx_from` AS `node_address`,min((case when (`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'createNode') then date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m-%d %h:%m:%s') else NULL end)) AS `registration_date`,max((case when (`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'nodeExit') then date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m-%d %h:%m:%s') else NULL end)) AS `exit_date` from `mainnet`.`skale_contract_transactions` where (`mainnet`.`skale_contract_transactions`.`contract_function_name` in ('getBounty','createNode','nodeExit')) group by `mainnet`.`skale_contract_transactions`.`tx_from` having (min((case when (`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'createNode') then date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m-%d %h:%m:%s') else NULL end)) >= '2020-09-01 00:00:00')) `node_dates`;

-- -----------------------------------------------------
-- View `mainnet`.`node_operator_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`node_operator_stats`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`node_operator_stats` AS select `mv`.`Validator Main` AS `node_operator`,`mv`.`validator_addresses` AS `validator_addresses`,`skd`.`Total_Amount_In_Delegated_Status` AS `Total_Amount_In_Delegated_Status`,`skd`.`Total_Amount_In_Accepted_Status` AS `Total_Amount_In_Accepted_Status`,`skd`.`Total_Amount_In_Un_Delegated_Status` AS `Total_Amount_In_Un_Delegated_Status`,`skd`.`Total_Amount_In_Canceled_Status` AS `Total_Amount_In_Canceled_Status`,`skd`.`Total_Amount_In_Proposed_Status` AS `Total_Amount_In_Proposed_Status`,`skd`.`Total_count_In_Delegated_Status` AS `Total_count_In_Delegated_Status`,`skd`.`Total_count_In_Un_Delegated_Status` AS `Total_count_In_Un_Delegated_Status`,`skd`.`Total_count_In_Canceled_Status` AS `Total_count_In_Canceled_Status`,`skd`.`Total_count_In_Accepted_Status` AS `Total_count_In_Accepted_Status`,`skd`.`Total_count_In_Proposed_Status` AS `Total_count_In_Proposed_Status`,`skd`.`Total_Amount_UnDelegated_Next_Epoch` AS `Total_Amount_UnDelegated_Next_Epoch`,(`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) AS `Total_Amount_Current_Delegations`,(((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) + `skd`.`Total_Amount_In_Accepted_Status`) - `skd`.`Total_Amount_UnDelegated_Next_Epoch`) AS `Total_Amount_Delegated_Next_Epoch`,(((`skd`.`Total_count_In_Delegated_Status` + `skd`.`Total_count_In_Un_Delegated_Status`) + `skd`.`Total_count_In_Accepted_Status`) - `skd`.`Total_count_UnDelegated_Next_Epoch`) AS `Total_Count_Delegated_Next_Epoch`,abs((((((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) + `skd`.`Total_Amount_In_Accepted_Status`) - `skd`.`Total_Amount_UnDelegated_Next_Epoch`) % 20000000) - 20000000)) AS `del_needed_for_next_node`,abs(((((((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) + `skd`.`Total_Amount_In_Accepted_Status`) + `skd`.`Total_Amount_In_Proposed_Status`) - `skd`.`Total_Amount_UnDelegated_Next_Epoch`) % 20000000) - 20000000)) AS `del_needed_for_next_node_with_proposed`,`skn`.`active_nodes_in_network` AS `active_nodes_in_network`,floor(((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) / 20000000)) AS `active_nodes_needed_current_epoch`,floor(((((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) + `skd`.`Total_Amount_In_Accepted_Status`) - `skd`.`Total_Amount_UnDelegated_Next_Epoch`) / 20000000)) AS `active_nodes_needed_next_epoch`,`gas`.`gasusedETH` AS `gastUsedByValidatorAccount`,`skn`.`totalGasUsedByAllNodes` AS `totalGasUsedByAllNodes`,(`gas`.`gasusedETH` + `skn`.`totalGasUsedByAllNodes`) AS `totalGasUsed`,`skd`.`current_unique_delegators` AS `current_unique_delegators`,`skd`.`next_epoch_unique_delegators` AS `next_epoch_unique_delegators`,`sln`.`linked_nodes` AS `linked_nodes`,`sln`.`linked_nodes_count` AS `linked_nodes_count`,(floor(((((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) + `skd`.`Total_Amount_In_Accepted_Status`) - `skd`.`Total_Amount_UnDelegated_Next_Epoch`) / 20000000)) - `sln`.`linked_nodes_count`) AS `missing_linked_nodes`,`skn`.`registered_nodes` AS `registered_nodes`,(floor(((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) / 20000000)) - `skn`.`active_nodes_in_network`) AS `missing_registered_nodes`,`skn`.`expected_NodeBounty_NextEpoch` AS `expected_NodeBounty_NextEpoch`,`skn`.`expected_validator_fee` AS `expected_validator_fee` from (((((select `mainnet`.`skale_mastervalidator`.`Validator Main` AS `Validator Main`,group_concat(`mainnet`.`skale_mastervalidator`.`Address` separator ',') AS `validator_addresses` from `mainnet`.`skale_mastervalidator` group by `mainnet`.`skale_mastervalidator`.`Validator Main`) `mv` left join (select `mv`.`Validator Main` AS `Validator Main`,sum((case when (`skd`.`status` = 'DELEGATED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Delegated_Status`,sum((case when (`skd`.`status` = 'UNDELEGATION_REQUESTED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Un_Delegated_Status`,sum((case when (`skd`.`status` = 'CANCELED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Canceled_Status`,sum((case when (`skd`.`status` = 'ACCEPTED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Accepted_Status`,sum((case when (`skd`.`status` = 'PROPOSED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Proposed_Status`,count(distinct (case when (`skd`.`status` = 'DELEGATED') then `skd`.`id` else NULL end)) AS `Total_count_In_Delegated_Status`,count(distinct (case when (`skd`.`status` = 'UNDELEGATION_REQUESTED') then `skd`.`id` else NULL end)) AS `Total_count_In_Un_Delegated_Status`,count(distinct (case when (`skd`.`status` = 'CANCELED') then `skd`.`id` else NULL end)) AS `Total_count_In_Canceled_Status`,count(distinct (case when (`skd`.`status` = 'ACCEPTED') then `skd`.`id` else NULL end)) AS `Total_count_In_Accepted_Status`,count(distinct (case when (`skd`.`status` = 'PROPOSED') then `skd`.`id` else NULL end)) AS `Total_count_In_Proposed_Status`,count(distinct (case when ((`skd`.`status` = 'DELEGATED') or (`skd`.`status` = 'UNDELEGATION_REQUESTED')) then `skd`.`holder_address` else NULL end)) AS `current_unique_delegators`,count(distinct (case when ((`skd`.`status` = 'DELEGATED') or ((((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day) + interval `skd`.`delegation_period` month) > (last_day(curdate()) + interval 1 day)) and (`skd`.`status` = 'UNDELEGATION_REQUESTED')) or (`skd`.`status` = 'ACCEPTED')) then `skd`.`holder_address` else NULL end)) AS `next_epoch_unique_delegators`,sum((case when ((((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day) + interval `skd`.`delegation_period` month) = (last_day(curdate()) + interval 1 day)) and (`skd`.`status` = 'UNDELEGATION_REQUESTED')) then `skd`.`amount` else 0 end)) AS `Total_Amount_UnDelegated_Next_Epoch`,count(distinct (case when ((((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day) + interval `skd`.`delegation_period` month) = (last_day(curdate()) + interval 1 day)) and (`skd`.`status` = 'UNDELEGATION_REQUESTED')) then `skd`.`id` else NULL end)) AS `Total_count_UnDelegated_Next_Epoch` from (`mainnet`.`skale_delegations` `skd` left join `mainnet`.`skale_mastervalidator` `mv` on((`mv`.`Validator ID` = `skd`.`validator_id`))) group by `mv`.`Validator Main`) `skd` on((`skd`.`Validator Main` = `mv`.`Validator Main`))) left join (select `mv`.`Validator Main` AS `Validator Main`,sum(`xb`.`active_nodes_in_network`) AS `active_nodes_in_network`,json_arrayagg(`xb`.`registered_nodes`) AS `registered_nodes`,sum(`xb`.`expected_validator_fee`) AS `expected_validator_fee`,sum(`xb`.`totalGasUsedByAllNodes`) AS `totalGasUsedByAllNodes`,sum(`xb`.`expected_NodeBounty_NextEpoch`) AS `expected_NodeBounty_NextEpoch` from ((select `mainnet`.`skale_nodes`.`validator_id` AS `validator_id`,count(distinct (case when (`mainnet`.`skale_nodes`.`status` <> 2) then `mainnet`.`skale_nodes`.`id` else NULL end)) AS `active_nodes_in_network`,(241228 * count(distinct (case when (`mainnet`.`skale_nodes`.`status` <> 2) then `mainnet`.`skale_nodes`.`id` else NULL end))) AS `expected_NodeBounty_NextEpoch`,((((241228 * count(distinct (case when (`mainnet`.`skale_nodes`.`status` <> 2) then `mainnet`.`skale_nodes`.`id` else NULL end))) * `mainnet`.`skale_validators`.`fee_rate`) / 10) / 100) AS `expected_validator_fee`,json_arrayagg(json_object('address',`mainnet`.`skale_nodes`.`address`,'balance',`mainnet`.`skale_nodes`.`balance`,'status',`mainnet`.`skale_nodes`.`status`,'ip',`mainnet`.`skale_nodes`.`ip`,'pub_key',`mainnet`.`skale_nodes`.`pub_key`,'port',`mainnet`.`skale_nodes`.`port`,'node_registration_date',`sk`.`registration_date`,'called_getBounty_this_epoch',(`sk`.`node_id` is not null),'last_bounty_Call',`sk`.`last_bounty_Call`)) AS `registered_nodes`,sum(`sk`.`totalGasUsedByAllNodes`) AS `totalGasUsedByAllNodes` from ((`mainnet`.`skale_nodes` join `mainnet`.`skale_validators` on((`mainnet`.`skale_validators`.`id` = `mainnet`.`skale_nodes`.`validator_id`))) left join (select `mainnet`.`skale_contract_transactions`.`tx_from` AS `node_address`,max((case when ((`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'getBounty') and (`mainnet`.`skale_contract_transactions`.`tx_isError` <> 1)) then date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m-%d %h:%m:%s') else NULL end)) AS `last_bounty_Call`,min((case when (`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'createNode') then date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m-%d %h:%m:%s') else NULL end)) AS `registration_date`,max((case when ((`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'getBounty') and (month(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`)) = month(utc_timestamp())) and (`mainnet`.`skale_contract_transactions`.`tx_isError` <> 1)) then json_extract(`mainnet`.`skale_contract_transactions`.`contract_parameters`,'$.nodeIndex') else NULL end)) AS `node_id`,sum((((`mainnet`.`skale_contract_transactions`.`tx_gasPrice` / 1000000000) * `mainnet`.`skale_contract_transactions`.`tx_gasUsed`) / 1000000000)) AS `totalGasUsedByAllNodes` from `mainnet`.`skale_contract_transactions` where (`mainnet`.`skale_contract_transactions`.`contract_function_name` in ('getBounty','createNode')) group by `mainnet`.`skale_contract_transactions`.`tx_from`) `sk` on((`sk`.`node_address` = `mainnet`.`skale_nodes`.`address`))) where (`mainnet`.`skale_nodes`.`status` = 0) group by `mainnet`.`skale_nodes`.`validator_id`) `xb` left join `mainnet`.`skale_mastervalidator` `mv` on((`mv`.`Validator ID` = `xb`.`validator_id`))) group by `mv`.`Validator Main`) `skn` on((`skn`.`Validator Main` = `mv`.`Validator Main`))) left join (select `mv`.`Validator Main` AS `Validator Main`,count(distinct `ln`.`address`) AS `linked_nodes_count`,json_arrayagg(json_object('address',`ln`.`address`,'balance',`ln`.`balance`,'status',`ln`.`active`)) AS `linked_nodes` from (`mainnet`.`skale_linked_nodes` `ln` left join `mainnet`.`skale_mastervalidator` `mv` on((`mv`.`Validator ID` = `ln`.`validator_id`))) group by `mv`.`Validator Main`) `sln` on((`sln`.`Validator Main` = `mv`.`Validator Main`))) left join (select `mv`.`Validator Main` AS `Validator Main`,sum((((`ctx`.`tx_gasPrice` / 1000000000) * `ctx`.`tx_gasUsed`) / 1000000000)) AS `gasusedETH` from (`mainnet`.`skale_contract_transactions` `ctx` join `mainnet`.`skale_mastervalidator` `mv` on((`mv`.`Address` = `ctx`.`tx_from`))) group by `mv`.`Validator Main`) `gas` on((`gas`.`Validator Main` = `mv`.`Validator Main`)));

-- -----------------------------------------------------
-- View `mainnet`.`node_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`node_stats`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`node_stats` AS select `mainnet`.`skale_nodes`.`id` AS `id`,`mainnet`.`skale_nodes`.`validator_id` AS `validator_id`,`skv`.`name` AS `validator_name`,`skv`.`address` AS `validator_address`,`mainnet`.`skale_nodes`.`address` AS `address`,`mainnet`.`skale_nodes`.`name` AS `name`,`mainnet`.`skale_nodes`.`balance` AS `balance`,(case when (`mainnet`.`skale_nodes`.`status` = 0) then 'active' else 'inactive' end) AS `status`,`mainnet`.`skale_nodes`.`ip` AS `ip`,`mainnet`.`skale_nodes`.`pub_key` AS `pub_key`,`mainnet`.`skale_nodes`.`port` AS `port`,(case when (`sk`.`node_id` is not null) then 'Yes' else 'No' end) AS `called_getBounty_this_epoch`,`sk`.`registration_date` AS `registration_date`,`sk`.`last_bounty_Call` AS `last_bounty_Call`,`sk`.`node_exit_date` AS `node_exit_date` from ((`mainnet`.`skale_nodes` left join (select `mainnet`.`skale_contract_transactions`.`tx_from` AS `node_address`,max((case when ((`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'getBounty') and (`mainnet`.`skale_contract_transactions`.`tx_isError` <> 1)) then date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m-%d %h:%m:%s') else NULL end)) AS `last_bounty_Call`,min((case when (`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'createNode') then date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m-%d %h:%m:%s') else NULL end)) AS `registration_date`,max((case when ((`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'getBounty') and (month(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`)) = month(utc_timestamp())) and (`mainnet`.`skale_contract_transactions`.`tx_isError` <> 1)) then json_extract(`mainnet`.`skale_contract_transactions`.`contract_parameters`,'$.nodeIndex') else NULL end)) AS `node_id`,max((case when (`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'nodeExit') then date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m-%d %h:%m:%s') else NULL end)) AS `node_exit_date` from `mainnet`.`skale_contract_transactions` where (`mainnet`.`skale_contract_transactions`.`contract_function_name` in ('getBounty','createNode','nodeExit')) group by `mainnet`.`skale_contract_transactions`.`tx_from`) `sk` on((`sk`.`node_address` = `mainnet`.`skale_nodes`.`address`))) left join `mainnet`.`skale_validators` `skv` on((`skv`.`id` = `mainnet`.`skale_nodes`.`validator_id`)));

-- -----------------------------------------------------
-- View `mainnet`.`node_transaction_agg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`node_transaction_agg`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`node_transaction_agg` AS select `mainnet`.`skale_contract_transactions`.`tx_from` AS `node_address`,max((case when ((`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'getBounty') and (`mainnet`.`skale_contract_transactions`.`tx_isError` <> 1)) then date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m-%d %h:%m:%s') else NULL end)) AS `last_bounty_Call`,min((case when (`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'createNode') then date_format(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`),'%Y-%m-%d %h:%m:%s') else NULL end)) AS `registration_date`,max((case when ((`mainnet`.`skale_contract_transactions`.`contract_function_name` = 'getBounty') and (month(from_unixtime(`mainnet`.`skale_contract_transactions`.`tx_timeStamp`)) = month(utc_timestamp())) and (`mainnet`.`skale_contract_transactions`.`tx_isError` <> 1)) then json_extract(`mainnet`.`skale_contract_transactions`.`contract_parameters`,'$.nodeIndex') else NULL end)) AS `node_id`,sum((((`mainnet`.`skale_contract_transactions`.`tx_gasPrice` / 1000000000) * `mainnet`.`skale_contract_transactions`.`tx_gasUsed`) / 1000000000)) AS `totalGasUsedBYNODE`,sum((`st`.`tx_value` / 1000000000000000000)) AS `bounty` from (`mainnet`.`skale_contract_transactions` left join `mainnet`.`skale_contract_token_transactions` `st` on((`st`.`tx_hash` = `mainnet`.`skale_contract_transactions`.`tx_hash`))) where (`mainnet`.`skale_contract_transactions`.`contract_function_name` in ('getBounty','createNode')) group by `mainnet`.`skale_contract_transactions`.`tx_from`;

-- -----------------------------------------------------
-- View `mainnet`.`rewards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`rewards`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`rewards` AS select (case when ((`em`.`address` is not null) and (`em`.`holder_address` is not null)) then `em`.`holder_address` else `r`.`address` end) AS `address`,`em`.`address` AS `escrow_address`,`r`.`validator_id` AS `validator_id`,`r`.`claimed_rewards` AS `claimed_rewards`,`r`.`unclaimed_rewards` AS `unclaimed_rewards`,`r`.`rewards_to_date` AS `rewards_to_date`,`r`.`type` AS `type` from ((select `a`.`address` AS `address`,`a`.`validator_id` AS `validator_id`,sum(`a`.`unclaimed_rewards`) AS `unclaimed_rewards`,sum(`a`.`claimed_rewards`) AS `claimed_rewards`,(sum(`a`.`unclaimed_rewards`) + sum(`a`.`claimed_rewards`)) AS `rewards_to_date`,`a`.`type` AS `type` from (select `mainnet`.`skale_bounty`.`address` AS `address`,`mainnet`.`skale_bounty`.`validator_id` AS `validator_id`,`mainnet`.`skale_bounty`.`earned_bounty` AS `unclaimed_rewards`,0 AS `claimed_rewards`,`mainnet`.`skale_bounty`.`type` AS `type` from `mainnet`.`skale_bounty` union select `t`.`tx_from` AS `address`,coalesce(json_extract(`t`.`contract_parameters`,'$.validatorId'),`v`.`id`) AS `validator_id`,0 AS `unclaimed_rewards`,(`tt`.`tx_value` / 1000000000000000000) AS `claimed_rewards`,(case when (`t`.`contract_function_name` = 'withdrawBounty') then 'DELEGATOR' when (`t`.`contract_function_name` = 'withdrawfee') then 'VALIDATOR' end) AS `type` from (((`mainnet`.`skale_contract_transactions` `t` join `mainnet`.`skale_contract_token_transactions` `tt` on((`tt`.`tx_hash` = `t`.`tx_hash`))) left join `mainnet`.`skale_validators` `v` on((`t`.`tx_from` = `v`.`address`))) left join `mainnet`.`skale_contract_proxy` `p` on((`t`.`tx_to` = `p`.`address`))) where ((`t`.`contract_function_name` in ('withdrawBounty','withdrawfee')) and (`t`.`tx_isError` = 0) and (`p`.`address` is null)) union select `t`.`tx_to` AS `address`,coalesce(json_extract(`t`.`contract_parameters`,'$.validatorId'),`v`.`id`) AS `validator_id`,0 AS `unclaimed_rewards`,(`tt`.`tx_value` / 1000000000000000000) AS `claimed_rewards`,(case when (`t`.`contract_function_name` = 'withdrawBounty') then 'DELEGATOR' when (`t`.`contract_function_name` = 'withdrawfee') then 'VALIDATOR' end) AS `type` from (((`mainnet`.`skale_contract_transactions` `t` join `mainnet`.`skale_contract_token_transactions` `tt` on((`tt`.`tx_hash` = `t`.`tx_hash`))) join `mainnet`.`skale_contract_proxy` `p` on((`t`.`tx_to` = `p`.`address`))) left join `mainnet`.`skale_validators` `v` on((`t`.`tx_to` = `v`.`address`))) where ((`t`.`contract_function_name` in ('withdrawBounty','withdrawfee')) and (`t`.`tx_isError` = 0))) `a` group by `a`.`address`,`a`.`validator_id`,`a`.`type`) `R` left join `mainnet`.`skale_contract_proxy` `em` on((`em`.`address` = `r`.`address`)));

-- -----------------------------------------------------
-- View `mainnet`.`validator_delegations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`validator_delegations`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`validator_delegations` AS select `skd`.`validator_id` AS `validator_id`,sum((case when (`skd`.`status` = 'DELEGATED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Delegated_Status`,sum((case when (`skd`.`status` = 'UNDELEGATION_REQUESTED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Un_Delegated_Status`,sum((case when (`skd`.`status` = 'CANCELED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Canceled_Status`,sum((case when (`skd`.`status` = 'ACCEPTED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Accepted_Status`,sum((case when (`skd`.`status` = 'PROPOSED') then coalesce(`skd`.`amount`,0) else 0 end)) AS `Total_Amount_In_Proposed_Status`,count(distinct (case when (`skd`.`status` = 'DELEGATED') then `skd`.`id` else NULL end)) AS `Total_count_In_Delegated_Status`,count(distinct (case when (`skd`.`status` = 'UNDELEGATION_REQUESTED') then `skd`.`id` else NULL end)) AS `Total_count_In_Un_Delegated_Status`,count(distinct (case when (`skd`.`status` = 'CANCELED') then `skd`.`id` else NULL end)) AS `Total_count_In_Canceled_Status`,count(distinct (case when (`skd`.`status` = 'ACCEPTED') then `skd`.`id` else NULL end)) AS `Total_count_In_Accepted_Status`,count(distinct (case when (`skd`.`status` = 'PROPOSED') then `skd`.`id` else NULL end)) AS `Total_count_In_Proposed_Status`,count(distinct (case when ((`skd`.`status` = 'DELEGATED') or (`skd`.`status` = 'UNDELEGATION_REQUESTED')) then `skd`.`holder_address` else NULL end)) AS `current_unique_delegators`,count(distinct (case when ((`skd`.`status` = 'DELEGATED') or (((period_diff(month((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day)),month((last_day(curdate()) + interval 1 day))) % `skd`.`delegation_period`) > 0) and (`skd`.`status` = 'UNDELEGATION_REQUESTED')) or (`skd`.`status` = 'ACCEPTED')) then `skd`.`holder_address` else NULL end)) AS `next_epoch_unique_delegators`,sum((case when ((`skd`.`status` = 'UNDELEGATION_REQUESTED') and ((period_diff(month((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day)),month((last_day(curdate()) + interval 1 day))) % `skd`.`delegation_period`) = 0)) then `skd`.`amount` else 0 end)) AS `Total_Amount_UnDelegated_Next_Epoch`,count(distinct (case when ((`skd`.`status` = 'UNDELEGATION_REQUESTED') and ((period_diff(month((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day)),month((last_day(curdate()) + interval 1 day))) % `skd`.`delegation_period`) = 0)) then `skd`.`id` else NULL end)) AS `Total_count_UnDelegated_Next_Epoch`,sum((case when ((`skd`.`status` = 'DELEGATED') and (`skd`.`info` = 'Activate') and ((period_diff(month((last_day(cast(date_format(from_unixtime(`skd`.`created`),'%Y-%m-%d %h:%i:%s') as datetime)) + interval 1 day)),month((last_day(curdate()) + interval 1 day))) % `skd`.`delegation_period`) = 0)) then `skd`.`amount` else 0 end)) AS `Total_Amount_In_Delegated_Activate_CanBeUndelegated` from `mainnet`.`skale_delegations` `skd` group by `skd`.`validator_id`;

-- -----------------------------------------------------
-- View `mainnet`.`validator_nodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`validator_nodes`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`validator_nodes` AS select `mainnet`.`skale_nodes`.`validator_id` AS `validator_id`,count(distinct (case when (`mainnet`.`skale_nodes`.`status` <> 2) then `mainnet`.`skale_nodes`.`id` else NULL end)) AS `active_nodes_in_network`,sum(`sk`.`totalGasUsedBYNODE`) AS `totalGasUsedByAllNodes`,sum((case when (`eb`.`year_month` <= date_format(`sk`.`last_bounty_Call`,'%Y-%m')) then `eb`.`inflation_epoch_per_node` else 0 end)) AS `expected_earned_rewards_to_date`,sum((case when (`eb`.`year_month` > date_format(coalesce(`sk`.`last_bounty_Call`,(curdate() + interval -(1) month)),'%Y-%m')) then `eb`.`inflation_epoch_per_node` else 0 end)) AS `expected_rewards_this_epoch`,json_arrayagg(json_object('address',`mainnet`.`skale_nodes`.`address`,'balance',`mainnet`.`skale_nodes`.`balance`,'status',`mainnet`.`skale_nodes`.`status`,'ip',`mainnet`.`skale_nodes`.`ip`,'pub_key',`mainnet`.`skale_nodes`.`pub_key`,'port',`mainnet`.`skale_nodes`.`port`,'node_registration_date',`sk`.`registration_date`,'called_getBounty_this_epoch',(`sk`.`node_id` is not null),'last_bounty_Call',`sk`.`last_bounty_Call`)) AS `registered_nodes` from ((`mainnet`.`skale_nodes` left join `mainnet`.`node_transaction_agg` `sk` on((`sk`.`node_address` = `mainnet`.`skale_nodes`.`address`))) left join `mainnet`.`monthly_expected_bounty_for_each_node_address` `eb` on((`eb`.`node_address` = `mainnet`.`skale_nodes`.`address`))) where (`mainnet`.`skale_nodes`.`status` = 0) group by `mainnet`.`skale_nodes`.`validator_id`;

-- -----------------------------------------------------
-- View `mainnet`.`validator_registration_dates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`validator_registration_dates`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`validator_registration_dates` AS select `SV`.`address` AS `address`,min(date_format(from_unixtime(`ct`.`tx_timeStamp`),'%Y-%m-%d')) AS `registration_date` from (`mainnet`.`skale_contract_transactions` `ct` join `mainnet`.`skale_validators` `SV` on((`SV`.`id` = json_extract(`ct`.`contract_parameters`,'$.validatorId')))) where ((`ct`.`contract_function_name` = 'enableValidator') and (`ct`.`tx_isError` <> 1) and (`ct`.`tx_isError` <> 1)) group by `SV`.`address`;

-- -----------------------------------------------------
-- View `mainnet`.`validator_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`validator_stats`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`validator_stats` AS select `mainnet`.`skale_validators`.`id` AS `id`,`mainnet`.`skale_validators`.`name` AS `name`,`mainnet`.`skale_validators`.`address` AS `address`,`mainnet`.`skale_validators`.`mdr` AS `mdr`,`mainnet`.`skale_validators`.`fee_rate` AS `fee_rate`,`mainnet`.`skale_validators`.`trusted` AS `trusted`,`mainnet`.`skale_validators`.`balance` AS `balance`,`mv`.`Validator Main` AS `node_operator`,`skd`.`Total_Amount_In_Delegated_Status` AS `Total_Amount_In_Delegated_Status`,`skd`.`Total_Amount_In_Accepted_Status` AS `Total_Amount_In_Accepted_Status`,`skd`.`Total_Amount_In_Un_Delegated_Status` AS `Total_Amount_In_Un_Delegated_Status`,`skd`.`Total_Amount_In_Canceled_Status` AS `Total_Amount_In_Canceled_Status`,`skd`.`Total_Amount_In_Proposed_Status` AS `Total_Amount_In_Proposed_Status`,`skd`.`Total_count_In_Delegated_Status` AS `Total_count_In_Delegated_Status`,`skd`.`Total_count_In_Un_Delegated_Status` AS `Total_count_In_Un_Delegated_Status`,`skd`.`Total_count_In_Canceled_Status` AS `Total_count_In_Canceled_Status`,`skd`.`Total_count_In_Accepted_Status` AS `Total_count_In_Accepted_Status`,`skd`.`Total_count_In_Proposed_Status` AS `Total_count_In_Proposed_Status`,`skd`.`Total_Amount_UnDelegated_Next_Epoch` AS `Total_Amount_UnDelegated_Next_Epoch`,(`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) AS `Total_Amount_Current_Delegations`,(((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) + `skd`.`Total_Amount_In_Accepted_Status`) - `skd`.`Total_Amount_UnDelegated_Next_Epoch`) AS `Total_Amount_Delegated_Next_Epoch`,(((`skd`.`Total_count_In_Delegated_Status` + `skd`.`Total_count_In_Un_Delegated_Status`) + `skd`.`Total_count_In_Accepted_Status`) - `skd`.`Total_count_UnDelegated_Next_Epoch`) AS `Total_Count_Delegated_Next_Epoch`,abs((((((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) + `skd`.`Total_Amount_In_Accepted_Status`) - `skd`.`Total_Amount_UnDelegated_Next_Epoch`) % 20000000) - 20000000)) AS `del_needed_for_next_node`,abs(((((((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) + `skd`.`Total_Amount_In_Accepted_Status`) + `skd`.`Total_Amount_In_Proposed_Status`) - `skd`.`Total_Amount_UnDelegated_Next_Epoch`) % 20000000) - 20000000)) AS `del_needed_for_next_node_with_proposed`,`skn`.`active_nodes_in_network` AS `active_nodes_in_network`,floor(((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) / 20000000)) AS `active_nodes_needed_current_epoch`,floor(((((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) + `skd`.`Total_Amount_In_Accepted_Status`) - `skd`.`Total_Amount_UnDelegated_Next_Epoch`) / 20000000)) AS `active_nodes_needed_next_epoch`,`gas`.`gasusedETH` AS `gastUsedByValidatorAccount`,`skn`.`totalGasUsedByAllNodes` AS `totalGasUsedByAllNodes`,(`gas`.`gasusedETH` + `skn`.`totalGasUsedByAllNodes`) AS `totalGasUsed`,`skd`.`current_unique_delegators` AS `current_unique_delegators`,`skd`.`next_epoch_unique_delegators` AS `next_epoch_unique_delegators`,`sln`.`linked_nodes` AS `linked_nodes`,`sln`.`linked_nodes_count` AS `linked_nodes_count`,(floor(((((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) + `skd`.`Total_Amount_In_Accepted_Status`) - `skd`.`Total_Amount_UnDelegated_Next_Epoch`) / 20000000)) - `sln`.`linked_nodes_count`) AS `missing_linked_nodes`,`skn`.`registered_nodes` AS `registered_nodes`,(floor(((`skd`.`Total_Amount_In_Delegated_Status` + `skd`.`Total_Amount_In_Un_Delegated_Status`) / 20000000)) - `skn`.`active_nodes_in_network`) AS `missing_registered_nodes`,`skn`.`expected_earned_rewards_to_date` AS `expected_earned_rewards_to_date`,(((`skn`.`expected_earned_rewards_to_date` * `mainnet`.`skale_validators`.`fee_rate`) / 10) / 100) AS `expected_validator_fee_to_date`,`skn`.`expected_rewards_this_epoch` AS `expected_rewards_this_epoch`,(((`skn`.`expected_rewards_this_epoch` * `mainnet`.`skale_validators`.`fee_rate`) / 10) / 100) AS `expected_validator_fee_this_epoch`,`earned_bounty`.`rewards_to_date` AS `received_validator_fee_to_date`,`earned_bounty`.`unclaimed_rewards` AS `unclaimed_rewards`,`earned_bounty`.`claimed_rewards` AS `claimed_rewards`,`skd`.`Total_Amount_In_Delegated_Activate_CanBeUndelegated` AS `Total_Amount_In_Delegated_Activate_CanBeUndelegated` from ((((((`mainnet`.`skale_validators` left join `mainnet`.`skale_mastervalidator` `mv` on((`mv`.`Validator ID` = `mainnet`.`skale_validators`.`id`))) left join `mainnet`.`validator_delegations` `skd` on((`skd`.`validator_id` = `mainnet`.`skale_validators`.`id`))) left join `mainnet`.`validator_nodes` `skn` on((`skn`.`validator_id` = `mainnet`.`skale_validators`.`id`))) left join (select count(distinct `mainnet`.`skale_linked_nodes`.`address`) AS `linked_nodes_count`,`mainnet`.`skale_linked_nodes`.`validator_id` AS `validator_id`,json_arrayagg(json_object('address',`mainnet`.`skale_linked_nodes`.`address`,'balance',`mainnet`.`skale_linked_nodes`.`balance`,'status',`mainnet`.`skale_linked_nodes`.`active`)) AS `linked_nodes` from `mainnet`.`skale_linked_nodes` group by `mainnet`.`skale_linked_nodes`.`validator_id`) `sln` on((`sln`.`validator_id` = `mainnet`.`skale_validators`.`id`))) left join (select sum((((`ctx`.`tx_gasPrice` / 1000000000) * `ctx`.`tx_gasUsed`) / 1000000000)) AS `gasusedETH`,`svl`.`id` AS `validator_id` from (`mainnet`.`skale_contract_transactions` `ctx` join `mainnet`.`skale_validators` `svl` on((`ctx`.`tx_from` = `svl`.`address`))) group by `svl`.`id`) `gas` on((`gas`.`validator_id` = `mainnet`.`skale_validators`.`id`))) left join `mainnet`.`rewards` `earned_bounty` on(((`earned_bounty`.`address` = `mainnet`.`skale_validators`.`address`) and (`earned_bounty`.`type` = 'VALIDATOR')))) where (`mainnet`.`skale_validators`.`trusted` = 1);

-- -----------------------------------------------------
-- View `mainnet`.`vi_node_checks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`vi_node_checks`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`vi_node_checks` AS select `node_checks`.`id` AS `id`,`node_checks`.`validator_id` AS `validator_id`,`node_checks`.`Name` AS `Name`,`node_checks`.`IP` AS `IP`,`node_checks`.`Status` AS `Status`,`node_checks`.`Address` AS `Address`,`node_checks`.`BalanceInWei` AS `BalanceInWei`,`node_checks`.`BaseContainers` AS `BaseContainers`,`node_checks`.`SgxInfo` AS `SgxInfo`,`node_checks`.`IsNodeActive` AS `IsNodeActive`,`node_checks`.`SRW_balance` AS `SRW_balance`,`node_checks`.`BalanceCheck` AS `BalanceCheck`,`node_checks`.`ContainerStatuses` AS `ContainerStatuses`,`node_checks`.`ComponentVersions` AS `ComponentVersions`,`node_checks`.`SgxStatus` AS `SgxStatus`,`node_checks`.`SGXVersion` AS `SGXVersion`,`node_checks`.`Endpoint` AS `Endpoint`,`node_checks`.`Hardware` AS `Hardware`,`node_checks`.`Trusted endpoint` AS `Trusted endpoint`,`node_checks`.`Filebeat logs` AS `Filebeat logs`,`node_checks`.`BTRFS` AS `BTRFS`,`node_checks`.`Val nodes` AS `Val nodes`,`node_checks`.`Public IP` AS `Public IP`,`node_checks`.`Cores` AS `Cores`,`node_checks`.`CoreCheck` AS `CoreCheck`,`node_checks`.`Memory` AS `Memory`,`node_checks`.`MemoryCheck` AS `MemoryCheck`,`node_checks`.`Storage` AS `Storage`,`node_checks`.`StorageCheck` AS `StorageCheck`,`node_checks`.`Swap` AS `Swap`,`node_checks`.`SwapCheck` AS `SwapCheck`,`node_checks`.`container_admin` AS `container_admin`,`node_checks`.`container_API` AS `container_API`,`node_checks`.`nginx` AS `nginx`,`node_checks`.`container_TransactionManager` AS `container_TransactionManager`,`node_checks`.`container_Mysql` AS `container_Mysql`,`node_checks`.`container_WatchDog` AS `container_WatchDog`,`node_checks`.`container_Bounty` AS `container_Bounty`,`node_checks`.`container_Filebeat` AS `container_Filebeat`,`node_checks`.`container_Configs` AS `container_Configs`,`node_checks`.`container_CLI` AS `container_CLI`,`node_checks`.`container_sChain` AS `container_sChain`,`node_checks`.`container_IMA` AS `container_IMA`,`node_checks`.`container_Lvmpy` AS `container_Lvmpy`,(case when ((`node_checks`.`BalanceCheck` <> 'Pass') or (`node_checks`.`ContainerStatuses` <> 'Pass') or (`node_checks`.`ComponentVersions` <> 'Pass') or (`node_checks`.`SgxStatus` <> 'Pass') or (`node_checks`.`SGXVersion` <> 'Pass') or (`node_checks`.`Endpoint` <> 'Pass') or (`node_checks`.`CoreCheck` <> 'Pass') or (`node_checks`.`Hardware` <> 'Pass') or (`node_checks`.`Endpoint` <> 'Pass') or (`node_checks`.`Filebeat logs` <> 'Pass') or (`node_checks`.`BTRFS` <> 'Pass') or (`node_checks`.`Val nodes` <> 'Pass') or (`node_checks`.`Public IP` <> 'Pass')) then 'Not ready' else 'SKALE chain Ready' end) AS `full_health` from (select `n`.`id` AS `id`,`n`.`validator_id` AS `validator_id`,`n`.`name` AS `Name`,`n`.`ip` AS `IP`,(case when (`n`.`status` = 0) then 'ACTIVE' when (`n`.`status` = 1) then 'LEAVING' when (`n`.`status` = 2) then 'FROZEN' when (`n`.`status` = 3) then 'IN MAINTENANCE' when (`n`.`status` = 4) then 'LEFT' when (`n`.`status` = 5) then 'NOT_CREATED' end) AS `Status`,`n`.`address` AS `Address`,`ni`.`Balance (Wei)` AS `BalanceInWei`,(case when (`ni`.`Base containers` >= '8/8') then 'Pass' when (`ni`.`Base containers` = '?') then 'Unknown' else `ni`.`Base containers` end) AS `BaseContainers`,(case when (`ni`.`SGX` = 'True') then 'Pass' when (`ni`.`SGX` = '?') then 'Unknown' when (`nhc`.`SGX` is null) then 'No Pass' else 'No Pass' end) AS `SgxInfo`,(case when (`nhc`.`Is node active` = '✔') then true when (`nhc`.`Is node active` is null) then false else false end) AS `IsNodeActive`,(case when (`nhc`.`Validator SRW balance` = '✔') then 'Pass' when (`nhc`.`Validator SRW balance` is null) then 'No Pass' else 'No Pass' end) AS `SRW_balance`,(case when (`nhc`.`Node balance` = '✔') then 'Pass' when (`nhc`.`Node balance` is null) then 'No Pass' else 'No Pass' end) AS `BalanceCheck`,(case when (`nhc`.`Container statuses` = '✔') then 'Pass' when (`nhc`.`Container statuses` is null) then 'No Pass' else 'No Pass' end) AS `ContainerStatuses`,(case when (`nhc`.`Component versions` = '✔') then 'Pass' when (`nhc`.`Component versions` is null) then 'No Pass' else 'No Pass' end) AS `ComponentVersions`,(case when (`nhc`.`SGX` = '✔') then 'Pass' when (`nhc`.`SGX` is null) then 'No Pass' else 'No Pass' end) AS `SgxStatus`,(case when (`nhc`.`SGX version` = '✔') then 'Pass' when (`nhc`.`SGX version` is null) then 'No Pass' else 'No Pass' end) AS `SGXVersion`,(case when (`nhc`.`Endpoint` = '✔') then 'Pass' when (`nhc`.`Endpoint` is null) then 'No Pass' else 'No Pass' end) AS `Endpoint`,(case when (`nhc`.`Hardware` = '✔') then 'Pass' when (`nhc`.`Hardware` is null) then 'No Pass' else 'No Pass' end) AS `Hardware`,(case when (`nhc`.`Trusted endpoint` = '✔') then 'Pass' when (`nhc`.`Trusted endpoint` is null) then 'No Pass' else 'No Pass' end) AS `Trusted endpoint`,(case when (`nhc`.`Filebeat logs` = '✔') then 'Pass' when (`nhc`.`Filebeat logs` is null) then 'No Pass' else 'No Pass' end) AS `Filebeat logs`,(case when (`nhc`.`BTRFS` = '✔') then 'Pass' when (`nhc`.`BTRFS` is null) then 'No Pass' else 'No Pass' end) AS `BTRFS`,(case when (`nhc`.`Val nodes` = '✔') then 'Pass' when (`nhc`.`Val nodes` is null) then 'No Pass' else 'No Pass' end) AS `Val nodes`,(case when (`nhc`.`Public IP` = '✔') then 'Pass' when (`nhc`.`Public IP` is null) then 'No Pass' else 'No Pass' end) AS `Public IP`,`nh`.`Cores` AS `Cores`,(case when (`nh`.`Cores` < 8) then 'No Pass' when (`nh`.`Cores` is null) then 'No Pass' else 'Pass' end) AS `CoreCheck`,`nh`.`Memory` AS `Memory`,(case when (`nh`.`Memory` < 32000000000) then 'No Pass' when (`nh`.`Memory` is null) then 'No Pass' else 'Pass' end) AS `MemoryCheck`,`nh`.`Storage` AS `Storage`,(case when (`nh`.`Storage` < 200000000) then 'No Pass' when (`nh`.`Storage` is null) then 'No Pass' else 'Pass' end) AS `StorageCheck`,`nh`.`Swap` AS `Swap`,(case when (`nh`.`Swap` < 15000000000) then 'No Pass' when (`nh`.`Swap` is null) then 'No Pass' else 'Pass' end) AS `SwapCheck`,`nc`.`Admin` AS `container_admin`,`nc`.`API` AS `container_API`,`nc`.`Nginx` AS `nginx`,`nc`.`TM` AS `container_TransactionManager`,`nc`.`MySql` AS `container_Mysql`,`nc`.`Watchdog` AS `container_WatchDog`,`nc`.`Bounty` AS `container_Bounty`,`nc`.`Filebeat` AS `container_Filebeat`,`nc`.`Configs` AS `container_Configs`,`nc`.`CLI` AS `container_CLI`,`nc`.`sChain` AS `container_sChain`,`nc`.`IMA` AS `container_IMA`,`nc`.`Lvmpy` AS `container_Lvmpy` from ((((`mainnet`.`skale_nodes` `n` left join `mainnet`.`nodes_info` `ni` on((`n`.`id` = `ni`.`# ID`))) left join `mainnet`.`node_hardware` `nh` on((`nh`.`# ID` = `ni`.`# ID`))) left join `mainnet`.`node_health_check` `nhc` on((`nhc`.`# Node ID` = `ni`.`# ID`))) left join `mainnet`.`node_containers` `nc` on((`nc`.`# Node ID` = `ni`.`# ID`))) where (`n`.`status` <> 2)) `node_checks`;

-- -----------------------------------------------------
-- View `mainnet`.`vi_validator_ready`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`vi_validator_ready`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`vi_validator_ready` AS select `vi_node_checks`.`validator_id` AS `validator_id`,min((case when ((`vi_node_checks`.`BalanceCheck` <> 'Pass') or (`vi_node_checks`.`ContainerStatuses` <> 'Pass') or (`vi_node_checks`.`ComponentVersions` <> 'Pass') or (`vi_node_checks`.`SgxStatus` <> 'Pass') or (`vi_node_checks`.`SGXVersion` <> 'Pass') or (`vi_node_checks`.`Endpoint` <> 'Pass') or (`vi_node_checks`.`CoreCheck` <> 'Pass') or (`vi_node_checks`.`Hardware` <> 'Pass') or (`vi_node_checks`.`Endpoint` <> 'Pass') or (`vi_node_checks`.`Filebeat logs` <> 'Pass') or (`vi_node_checks`.`BTRFS` <> 'Pass') or (`vi_node_checks`.`Val nodes` <> 'Pass') or (`vi_node_checks`.`Public IP` <> 'Pass')) then 'Not ready' else 'SKALE chain Ready' end)) AS `status` from `mainnet`.`vi_node_checks` group by `vi_node_checks`.`validator_id`;

-- -----------------------------------------------------
-- View `mainnet`.`vw_addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mainnet`.`vw_addresses`;
USE `mainnet`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mainnet`.`vw_addresses` AS select `m`.`Validator Main` AS `NodeOperator`,`val`.`address` AS `address`,`val`.`name` AS `name`,`val`.`val_id` AS `val_id` from ((select `v`.`address` AS `address`,`v`.`name` AS `name`,`v`.`id` AS `val_id` from `mainnet`.`skale_validators` `v` union select distinct replace(json_extract(`t`.`contract_parameters`,'$.newValidatorAddress[0]'),'"','') AS `Name_exp_3`,`v`.`name` AS `name`,`v`.`id` AS `val_id` from (`mainnet`.`skale_contract_transactions` `t` left join `mainnet`.`skale_validators` `v` on(((`t`.`tx_from` = `v`.`address`) or (replace(json_extract(`t`.`contract_parameters`,'$.newValidatorAddress[0]'),'"','') = `v`.`address`)))) where (`t`.`contract_function_name` = 'requestForNewAddress') union select distinct `n`.`address` AS `address`,`v`.`name` AS `name`,`v`.`id` AS `val_id` from (`mainnet`.`skale_nodes` `n` join `mainnet`.`skale_validators` `v` on((`n`.`validator_id` = `v`.`id`)))) `val` left join `mainnet`.`skale_mastervalidator` `m` on((`val`.`val_id` = `m`.`Validator ID`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Procedure `mainnet`.`Load_Proxy_Contracts_procedure`
-- -----------------------------------------------------
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Load_Proxy_Contracts_procedure`()
BEGIN

INSERT INTO `mainnet`.`skale_contract_proxy`
 (`name`,
 `address`,
 `lastblock`,
 `repository`,
 `last_internal_tx_block`,
 `implementation_address`,
 `implementation_name`,
 `holder_address`
 )
 SELECT  distinct
  'proxy_contract' as name,
  tx_contractAddress as address,
  0 high_watemark,
  'Allocator' as repository,
  null,
  contract_implementation_address ,
  sc.name as implementation_name,
  d.holder_address
  FROM mainnet.skale_contract_internal_transactions
  LEFT OUTER JOIN skale_contract sc on sc.address = skale_contract_internal_transactions.tx_contractAddress
  LEFT JOIN address_escrow_match_delegators  d ON tx_contractAddress =  d.escrow_address
  WHERE sc.address is null
ON DUPLICATE KEY UPDATE
`name` = VALUES(name),
`address` = VALUES(address ),
`lastblock` = VALUES(lastblock),
`repository` = VALUES(repository ),
`last_internal_tx_block` = VALUES(last_internal_tx_block ),
`implementation_address` = VALUES(implementation_address ),
`implementation_name` = VALUES(implementation_name ),
`holder_address` = VALUES(holder_address);


END$$
DELIMITER ;
-- -----------------------------------------------------
-- Procedure `mainnet`.`Load_rewards_table`
-- -----------------------------------------------------
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Load_rewards_table`()
BEGIN

INSERT INTO `mainnet`.`skale_rewards`
(`address`,
`escrow_address`,
`validator_id`,
`claimed_rewards`,
`unclaimed_rewards`,
`rewards_to_date`,
`type`,
`earned_rewards`)
	SELECT
    `rewards`.`address`,
    MAX(`rewards`.`escrow_address`),
    `rewards`.`validator_id`,
    SUM(`rewards`.`claimed_rewards`),
    SUM(`rewards`.`unclaimed_rewards`),
    SUM(`rewards`.`rewards_to_date`),
    `rewards`.`type`,
    case when SUM(`rewards`.`rewards_to_date`) >0 then 1 else 0 end as `earned_rewards`
FROM `mainnet`.`rewards`
GROUP BY `rewards`.`address` ,  `rewards`.`validator_id`, `rewards`.`type`
ON DUPLICATE KEY UPDATE
`address` = VALUES(address),
`escrow_address` = VALUES(escrow_address),
`validator_id` = VALUES(validator_id),
`claimed_rewards` = VALUES(claimed_rewards),
`unclaimed_rewards` = VALUES(unclaimed_rewards),
`rewards_to_date` = VALUES(rewards_to_date),
`type` = VALUES(`type`),
`earned_rewards` = VALUES(earned_rewards);


END$$
DELIMITER ;

-- -----------------------------------------------------
-- Procedure `mainnet`.`Load_Token_stake_monthly`
-- -----------------------------------------------------
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Load_Token_stake_monthly`()
BEGIN

INSERT INTO `mainnet`.`skale_validator_monthly`
(`validator_id`,
`YYYYMM`,
`MonthName`,
`epoch`,
`TotalStaked`,
`TotalRewards`,
`TotalValidatorRewards`,
`TotalDelegatorRewards`)

SELECT
	sd.validator_id,
	ct.YYYYMM,
    monthName,
	epoch,
	sum(amt) TotalStaked,
    max(full_reward) TotalRewards,
	max(validator_reward) TotalValidatorRewards,
	max(delegator_rewards) TotalDelegatorRewards
FROM
	(SELECT distinct concat(y,LPAD(m,2,0)) YYYYMM,
    concat(y,'-',m) YYYY_MM,
    monthName,
	epoch from mainnet.calendar_table) ct
JOIN
(
	SELECT 	validator_id,
			sum(amount) amt,
			started as startmonth,
			case when finished = 0 then TIMESTAMPDIFF(MONTH,'2020-01-01',now())+1  else finished-1 end endmonth
		FROM
			mainnet.skale_delegations sd
		WHERE status in ('DELEGATED','COMPLETED','ACCEPTED', 'UNDELEGATION_REQUESTED')
		GROUP BY
			validator_id,started,finished

)sd ON ct.epoch between sd.startmonth and sd.endmonth
LEFT OUTER JOIN
(
	SELECT
		validator_id,
		yyyymm,
		sum(full_reward) full_reward,
		sum(validator_reward) validator_reward,
		sum(full_reward) - sum(validator_reward) as delegator_rewards
	FROM mainnet.monthly_rewards
	GROUP BY
		validator_id,
		yyyymm
	HAVING
		sum(full_reward)>0
)rw ON rw.yyyymm = YYYY_MM and rw.validator_id = sd.validator_id
group by
    sd.validator_id,
	ct.YYYYMM,
    monthName,
	epoch
order by
	sd.validator_id,
	ct.YYYYMM,
    monthName,
	epoch
ON DUPLICATE KEY UPDATE
`validator_id` = VALUES(validator_id),
`YYYYMM` = VALUES(YYYYMM),
`MonthName` = VALUES(MonthName),
`epoch` = VALUES(epoch),
`TotalStaked` = VALUES(TotalStaked),
`TotalRewards` = VALUES(TotalRewards),
`TotalValidatorRewards` = VALUES(`TotalValidatorRewards`),
`TotalDelegatorRewards` = VALUES(`TotalDelegatorRewards`)
;

INSERT INTO `mainnet`.`skale_delegator_monthly`
(`holder_address`,
`validator_id`,
`YYYYMM`,
`MonthName`,
`epoch`,
`TotalStaked`)
SELECT
	holder_address,
	sd.validator_id,
	YYYYMM,
    monthName,
	epoch,
	sum(amt) TotalStaked
FROM
	(SELECT distinct concat(y,LPAD(m,2,0)) YYYYMM,
    monthName,
	epoch from mainnet.calendar_table) ct
JOIN
(
	SELECT 	holder_address,
			validator_id,
			sum(amount) amt,
			started as startmonth,
			case when finished = 0 then TIMESTAMPDIFF(MONTH,'2020-01-01',now())+1  else finished-1 end endmonth
		FROM
			mainnet.skale_delegations sd
		WHERE status in ('DELEGATED','COMPLETED','ACCEPTED', 'UNDELEGATION_REQUESTED')
		GROUP BY
			holder_address,validator_id,started,finished

)sd ON ct.epoch >= sd.startmonth and ct.epoch<=sd.endmonth
group by
	holder_address,
    sd.validator_id,
	YYYYMM,
    monthName,
	epoch
order by
	holder_address,
	sd.validator_id,
	YYYYMM,
    monthName,
	epoch
ON DUPLICATE KEY UPDATE
`holder_address` = VALUES(holder_address),
`validator_id` = VALUES(validator_id),
`YYYYMM` = VALUES(YYYYMM),
`MonthName` = VALUES(MonthName),
`epoch` = VALUES(epoch),
`TotalStaked` = VALUES(`TotalStaked`);


END$$
DELIMITER ;
