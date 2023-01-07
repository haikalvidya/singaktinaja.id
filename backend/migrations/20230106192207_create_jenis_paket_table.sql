-- migrate:up
CREATE TABLE `jenis_paket` ( 
    `id` CHAR(36) NOT NULL ,
    `nama` VARCHAR(255) NOT NULL,
    `amount` DECIMAL(10,2) NOT NULL,
    `disc` INT NULL DEFAULT 0,
    `custom_url_amount` INT NULL DEFAULT 0,
    `microsite_amount` INT NULL DEFAULT 0,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NULL,
    `deleted_at` TIMESTAMP NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;