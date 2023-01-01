-- migrate:up
CREATE TABLE `microsite` (
    `id` CHAR(36) NOT NULL ,
    `name` varchar(255) NOT NULL DEFAULT '',
    `user_id` CHAR(36) NOT NULL,
    `short_url_id` CHAR(36) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NULL,
    `deleted_at` TIMESTAMP NULL,
    PRIMARY KEY (`id`)
    -- FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    -- FOREIGN KEY (`short_url_id`) REFERENCES `short_url`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- migrate:down
DROP TABLE `microsite`;