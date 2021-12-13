CREATE TYPE "products_status" AS ENUM (
  'out_of_stock',
  'in_stock',
  'running_low'
);

CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar UNIQUE,
  "password" varchar NOT NULL,
  "phone" varchar UNIQUE,
  "active" boolean,
  "image" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "userfavort" (
  "id" SERIAL PRIMARY KEY,
  "product_id" int,
  "user_id" int NOT NULL,
  "created_at" timestamp,
  "updated_at" timestamp,
  "status" boolean
);

CREATE TABLE "order_items" (
  "id" SERIAL PRIMARY KEY,
  "order_id" int NOT NULL,
  "product_id" int,
  "price" float,
  "quantity" int DEFAULT 1,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "orders" (
  "id" SERIAL PRIMARY KEY,
  "user_id" int NOT NULL,
  "total_amount" float,
  "discount" float,
  "net" float,
  "address" text,
  "status" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "categroy" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "desc" text,
  "image" varchar,
  "created_at" varchar,
  "updated_at" timestamp
);

CREATE TABLE "products" (
  "id" SERIAL PRIMARY KEY,
  "ar_name" varchar,
  "categroy_id" int NOT NULL,
  "en_name" varchar,
  "rate" float,
  "merchant_id" int NOT NULL,
  "price" float,
  "size" varchar,
  "color" varchar,
  "tags" text,
  "percent_discount" varchar,
  "status" products_status,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp,
  "describ" text,
  "cover" text
);

CREATE TABLE "images" (
  "id" SERIAL PRIMARY KEY,
  "product_id" int NOT NULL,
  "created at" varchar,
  "arrange" int,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "admins" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "password" varchar,
  "phone" varchar UNIQUE,
  "email" varchar UNIQUE,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "merchants" (
  "id" SERIAL PRIMARY KEY,
  "merchant_name" varchar,
  "phone" varchar,
  "email" varchar,
  "created_at" timestamp,
  "admin_id" int
);

CREATE TABLE "reviews" (
  "id" SERIAL PRIMARY KEY,
  "user_id" int NOT NULL,
  "product_id" int NOT NULL,
  "rate" int,
  "comment" text,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "about" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "address" text,
  "desc" text,
  "tel" text,
  "mail" text,
  "privacy_policy" text,
  "terms_conditions" text
);

ALTER TABLE "userfavort" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "userfavort" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "order_items" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "order_items" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "orders" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("categroy_id") REFERENCES "categroy" ("id");

ALTER TABLE "images" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "merchants" ADD FOREIGN KEY ("admin_id") REFERENCES "admins" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("merchant_id") REFERENCES "merchants" ("id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("ar_name") REFERENCES "products" ("id");

CREATE INDEX "product_status" ON "products" ("merchant_id", "status");

CREATE UNIQUE INDEX ON "products" ("id");

COMMENT ON COLUMN "orders"."created_at" IS 'When order created';

COMMENT ON COLUMN "categroy"."created_at" IS 'When order created';