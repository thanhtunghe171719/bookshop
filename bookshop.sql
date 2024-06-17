
create database bookshop;
use bookshop;

CREATE TABLE `cart`(
    `cart_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT unsigned NULL,
    `promotion_id` VARCHAR(255) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `note` VARCHAR(255) NOT NULL
);
CREATE TABLE `slider`(
    `slider_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT unsigned NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `image` VARCHAR(255) NOT NULL,
    `status` ENUM('Show', 'Hide') NOT NULL,
    `description` VARCHAR(255) NOT NULL
);
CREATE TABLE `posts`(
    `post_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `image` VARCHAR(255) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `post_type` VARCHAR(255) NOT NULL,
    `user_id` INT unsigned NOT NULL,
    `description` TEXT NOT NULL,
    `status` ENUM('Show', 'Hide') NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE `sale_management`(
    `order_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT unsigned NOT NULL,
    `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE `roles`(
    `role_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `role_name` VARCHAR(255) NOT NULL,
    `status_id` INT unsigned NOT NULL,
    `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE `promotions`(
    `promotion_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `discount_percentage` DECIMAL(8, 2) NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`promotion_id`)
);
CREATE TABLE `feedback`(
    `feedback_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `order_item_id` INT unsigned NOT NULL,
    `rating` INT NULL COMMENT 'CHECK (rating >= 1 AND rating <= 5)',
    `comment` TEXT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE `cart_items`(
    `cart_item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cart_id` INT unsigned NOT NULL,
    `book_id` INT unsigned NULL,
    `quantity` INT NOT NULL
);
CREATE TABLE `categories`(
    `category_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `category_name` VARCHAR(255) NOT NULL,
    `image` varchar(255) NOT NULL,
    `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE `books`(
    `book_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `author` VARCHAR(255) NOT NULL,
    `image` VARCHAR(255) NULL,
    `category_id` INT unsigned NOT NULL,
    `publishing_house` VARCHAR(255) NOT NULL,
    `published_year` INT NOT NULL,
    `size` VARCHAR(255) NOT NULL,
    `weight` VARCHAR(255) NOT NULL,
    `summary` TEXT NULL,
    `price` DECIMAL(8, 2) NOT NULL,
    `rating` INT NULL,
    `discount` INT NULL,
    `stock` INT NOT NULL DEFAULT '0',
    `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `format` VARCHAR(255) NOT NULL,
    `pages` INT NOT NULL
);
CREATE TABLE `order_status`(
    `order_status_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `order_status` VARCHAR(255) NOT NULL,
    `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE `order_items`(
    `order_item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `order_id` INT unsigned NOT NULL,
    `book_id` INT unsigned NOT NULL,
    `quantity` INT NOT NULL
);
CREATE TABLE `orders`(
    `order_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cart_id` INT unsigned NOT NULL,
    `total` DECIMAL(8, 2) NOT NULL,
    `order_status_id` INT unsigned NOT NULL,
    `order_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE `users`(
    `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `role_id` INT unsigned NOT NULL,
    `fullname` VARCHAR(255) NOT NULL,
    `gender` VARCHAR(255) NULL,
    `image` VARCHAR(255) NULL,
    `address` VARCHAR(255) NULL,
    `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    `users` ADD UNIQUE `users_email_unique`(`email`);
ALTER TABLE
    `users` ADD UNIQUE `users_phone_unique`(`phone`);
ALTER TABLE
    `orders` ADD CONSTRAINT `orders_order_id_foreign` FOREIGN KEY(`order_id`) REFERENCES `sale_management`(`order_id`);
ALTER TABLE
    `cart` ADD CONSTRAINT `cart_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`user_id`);
ALTER TABLE
    `orders` ADD CONSTRAINT `orders_cart_id_foreign` FOREIGN KEY(`cart_id`) REFERENCES `cart`(`cart_id`);
ALTER TABLE
    `sale_management` ADD CONSTRAINT `sale_management_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`user_id`);
ALTER TABLE
    `feedback` ADD CONSTRAINT `feedback_order_item_id_foreign` FOREIGN KEY(`order_item_id`) REFERENCES `order_items`(`order_item_id`);
ALTER TABLE
    `slider` ADD CONSTRAINT `slider_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`user_id`);
ALTER TABLE
    `cart_items` ADD CONSTRAINT `cart_items_cart_id_foreign` FOREIGN KEY(`cart_id`) REFERENCES `cart`(`cart_id`);
ALTER TABLE
    `posts` ADD CONSTRAINT `posts_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`user_id`);
ALTER TABLE
    `cart` ADD CONSTRAINT `cart_promotion_id_foreign` FOREIGN KEY(`promotion_id`) REFERENCES `promotions`(`promotion_id`);
ALTER TABLE
    `books` ADD CONSTRAINT `books_category_id_foreign` FOREIGN KEY(`category_id`) REFERENCES `categories`(`category_id`);
ALTER TABLE
    `cart_items` ADD CONSTRAINT `cart_items_book_id_foreign` FOREIGN KEY(`book_id`) REFERENCES `books`(`book_id`);
ALTER TABLE
    `users` ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY(`role_id`) REFERENCES `roles`(`role_id`);
ALTER TABLE
    `order_items` ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY(`order_id`) REFERENCES `orders`(`order_id`);
ALTER TABLE
    `orders` ADD CONSTRAINT `orders_order_status_id_foreign` FOREIGN KEY(`order_status_id`) REFERENCES `order_status`(`order_status_id`);
