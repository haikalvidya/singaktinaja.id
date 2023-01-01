-- migrate:up
CREATE TABLE `track_click` (
    `id` CHAR(36) NOT NULL ,
    `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `short_url_id` CHAR(36) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NULL,
    `deleted_at` TIMESTAMP NULL,
    PRIMARY KEY (`id`)
    -- FOREIGN KEY (`short_url_id`) REFERENCES `short_url` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- migrate:down
DROP TABLE `track_click`;