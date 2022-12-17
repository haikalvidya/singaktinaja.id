-- migrate:up
CREATE TABLE `users` ( 
    `id` CHAR(36) NOT NULL ,
    `email` VARCHAR(255) NOT NULL,
    `first_name` VARCHAR(100) NOT NULL,
    `last_name` VARCHAR(100) NOT NULL,
    `username` VARCHAR(100) NOT NULL,
    `password` VARCHAR(190) NOT NULL,
    `phone` VARCHAR(25) NULL DEFAULT "",
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NULL,
    `deleted_at` TIMESTAMP NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- migrate:down
DROP TABLE `users`

