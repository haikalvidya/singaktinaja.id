-- migrate:up
CREATE TABLE `subscription` (
    `id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `payment_id` CHAR(36) NOT NULL,
    `jenis_paket_id` CHAR(36) NOT NULL,
    `status` VARCHAR(10) NOT NULL,
    `start_date` TIMESTAMP NULL,
    `end_date` TIMESTAMP NULL,
    `url_payment` VARCHAR(255) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NULL,
    `deleted_at` TIMESTAMP NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`payment_id`) REFERENCES `payments`(`id`),
    FOREIGN KEY (`jenis_paket_id`) REFERENCES `jenis_paket`(`id`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- migrate:down
DROP TABLE `subscription`;