-- migrate:up
CREATE TABLE `short_urls` (
    `id` CHAR(36) NOT NULL ,
    `short_url` VARCHAR(500) NOT NULL,
    `original_url` VARCHAR(1000) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `exp_date` TIMESTAMP NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NULL,
    `deleted_at` TIMESTAMP NULL,
    PRIMARY KEY (`id`)
    -- FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE = InnoDB;

-- migrate:down
DROP TABLE `short_urls`

