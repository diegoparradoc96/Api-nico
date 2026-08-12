/*
  Warnings:

  - The primary key for the `dish_item_on_dishes` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `dishId` on the `dish_item_on_dishes` table. All the data in the column will be lost.
  - You are about to drop the column `itemId` on the `dish_item_on_dishes` table. All the data in the column will be lost.
  - You are about to alter the column `quantity` on the `dish_item_on_dishes` table. The data in that column could be lost. The data in that column will be cast from `Integer` to `SmallInt`.
  - You are about to alter the column `name` on the `dish_items` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - You are about to alter the column `name` on the `dishes` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(150)`.
  - You are about to alter the column `price` on the `dishes` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Decimal(10,2)`.
  - The primary key for the `order_dishes` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `dishId` on the `order_dishes` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `order_dishes` table. All the data in the column will be lost.
  - You are about to drop the column `orderId` on the `order_dishes` table. All the data in the column will be lost.
  - You are about to drop the column `quantity` on the `order_dishes` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `orders` table. All the data in the column will be lost.
  - You are about to drop the column `table` on the `orders` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `orders` table. All the data in the column will be lost.
  - You are about to alter the column `salesValue` on the `orders` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Decimal(10,2)`.
  - Added the required column `dish_id` to the `dish_item_on_dishes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `item_id` to the `dish_item_on_dishes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dish_id` to the `order_dishes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dish_price` to the `order_dishes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `order_id` to the `order_dishes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `destination_id` to the `orders` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `orders` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "dish_item_on_dishes" DROP CONSTRAINT "dish_item_on_dishes_dishId_fkey";

-- DropForeignKey
ALTER TABLE "dish_item_on_dishes" DROP CONSTRAINT "dish_item_on_dishes_itemId_fkey";

-- DropForeignKey
ALTER TABLE "order_dishes" DROP CONSTRAINT "order_dishes_dishId_fkey";

-- DropForeignKey
ALTER TABLE "order_dishes" DROP CONSTRAINT "order_dishes_orderId_fkey";

-- DropIndex
DROP INDEX "order_dishes_orderId_dishId_key";

-- AlterTable
ALTER TABLE "dish_item_on_dishes" DROP CONSTRAINT "dish_item_on_dishes_pkey",
DROP COLUMN "dishId",
DROP COLUMN "itemId",
ADD COLUMN     "dish_id" TEXT NOT NULL,
ADD COLUMN     "item_id" TEXT NOT NULL,
ALTER COLUMN "quantity" SET DATA TYPE SMALLINT,
ADD CONSTRAINT "dish_item_on_dishes_pkey" PRIMARY KEY ("dish_id", "item_id");

-- AlterTable
ALTER TABLE "dish_items" ALTER COLUMN "name" SET DATA TYPE VARCHAR(100);

-- AlterTable
ALTER TABLE "dishes" ALTER COLUMN "name" SET DATA TYPE VARCHAR(150),
ALTER COLUMN "price" SET DATA TYPE DECIMAL(10,2);

-- AlterTable
ALTER TABLE "order_dishes" DROP CONSTRAINT "order_dishes_pkey",
DROP COLUMN "dishId",
DROP COLUMN "id",
DROP COLUMN "orderId",
DROP COLUMN "quantity",
ADD COLUMN     "dish_id" TEXT NOT NULL,
ADD COLUMN     "dish_price" DECIMAL(10,2) NOT NULL,
ADD COLUMN     "dish_quantity" SMALLINT NOT NULL DEFAULT 1,
ADD COLUMN     "order_id" TEXT NOT NULL,
ADD CONSTRAINT "order_dishes_pkey" PRIMARY KEY ("order_id", "dish_id");

-- AlterTable
ALTER TABLE "orders" DROP COLUMN "createdAt",
DROP COLUMN "table",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "destination_id" TEXT NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "salesValue" SET DATA TYPE DECIMAL(10,2);

-- CreateTable
CREATE TABLE "destinations" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT "destinations_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_destination_id_fkey" FOREIGN KEY ("destination_id") REFERENCES "destinations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_dishes" ADD CONSTRAINT "order_dishes_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_dishes" ADD CONSTRAINT "order_dishes_dish_id_fkey" FOREIGN KEY ("dish_id") REFERENCES "dishes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dish_item_on_dishes" ADD CONSTRAINT "dish_item_on_dishes_dish_id_fkey" FOREIGN KEY ("dish_id") REFERENCES "dishes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dish_item_on_dishes" ADD CONSTRAINT "dish_item_on_dishes_item_id_fkey" FOREIGN KEY ("item_id") REFERENCES "dish_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
