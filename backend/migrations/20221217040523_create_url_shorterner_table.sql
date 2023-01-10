-- migrate:up
CREATE TABLE `short_urls` (
    `id` CHAR(36) NOT NULL ,
    `short_url` VARCHAR(500) NOT NULL,
    `original_url` VARCHAR(1000) NOT NULL,
    `name` VARCHAR(100) NOT NULL DEFAULT "",
    `user_id` CHAR(36) NOT NULL,
    `clicks` INT NOT NULL DEFAULT 0,
    `is_costum` bool NOT NULL DEFAULT FALSE,
    `exp_date` TIMESTAMP NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NULL,
    `deleted_at` TIMESTAMP NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- migrate:down
DROP TABLE `short_urls`

