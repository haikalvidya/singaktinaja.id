-- migrate:up
CREATE TABLE `payments` (
    `id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `amount_total` DECIMAL(10,2) NOT NULL,
    `status` VARCHAR(10) NOT NULL,
    `expired_date` TIMESTAMP NULL,
    `paid_at` TIMESTAMP NULL,
    `xendit_ref_id` VARCHAR(255) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NULL,
    `deleted_at` TIMESTAMP NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- migrate:down
DROP TABLE `payments`;