/*
  Warnings:

  - You are about to drop the `Dish` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DishItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DishItemOnDish` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Order` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `OrderDish` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "DishItemOnDish" DROP CONSTRAINT "DishItemOnDish_dishId_fkey";

-- DropForeignKey
ALTER TABLE "DishItemOnDish" DROP CONSTRAINT "DishItemOnDish_itemId_fkey";

-- DropForeignKey
ALTER TABLE "OrderDish" DROP CONSTRAINT "OrderDish_dishId_fkey";

-- DropForeignKey
ALTER TABLE "OrderDish" DROP CONSTRAINT "OrderDish_orderId_fkey";

-- DropTable
DROP TABLE "Dish";

-- DropTable
DROP TABLE "DishItem";

-- DropTable
DROP TABLE "DishItemOnDish";

-- DropTable
DROP TABLE "Order";

-- DropTable
DROP TABLE "OrderDish";

-- CreateTable
CREATE TABLE "orders" (
    "id" TEXT NOT NULL,
    "table" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dishes" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "image" TEXT,

    CONSTRAINT "dishes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dish_items" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "dish_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_dishes" (
    "id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "orderId" TEXT NOT NULL,
    "dishId" TEXT NOT NULL,

    CONSTRAINT "order_dishes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dish_item_on_dishes" (
    "dishId" TEXT NOT NULL,
    "itemId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "dish_item_on_dishes_pkey" PRIMARY KEY ("dishId","itemId")
);

-- CreateIndex
CREATE UNIQUE INDEX "order_dishes_orderId_dishId_key" ON "order_dishes"("orderId", "dishId");

-- AddForeignKey
ALTER TABLE "order_dishes" ADD CONSTRAINT "order_dishes_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_dishes" ADD CONSTRAINT "order_dishes_dishId_fkey" FOREIGN KEY ("dishId") REFERENCES "dishes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dish_item_on_dishes" ADD CONSTRAINT "dish_item_on_dishes_dishId_fkey" FOREIGN KEY ("dishId") REFERENCES "dishes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dish_item_on_dishes" ADD CONSTRAINT "dish_item_on_dishes_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "dish_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
