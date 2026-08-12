/*
  Warnings:

  - You are about to drop the `Dishe` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DisheItem` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "DisheItem" DROP CONSTRAINT "DisheItem_disheId_fkey";

-- DropTable
DROP TABLE "Dishe";

-- DropTable
DROP TABLE "DisheItem";

-- CreateTable
CREATE TABLE "Dish" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "image" TEXT,

    CONSTRAINT "Dish_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrderDish" (
    "id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "orderId" TEXT NOT NULL,
    "dishId" TEXT NOT NULL,

    CONSTRAINT "OrderDish_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DishItem" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "image" TEXT,

    CONSTRAINT "DishItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DishItemOnDish" (
    "dishId" TEXT NOT NULL,
    "itemId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "DishItemOnDish_pkey" PRIMARY KEY ("dishId","itemId")
);

-- CreateIndex
CREATE UNIQUE INDEX "OrderDish_orderId_dishId_key" ON "OrderDish"("orderId", "dishId");

-- AddForeignKey
ALTER TABLE "OrderDish" ADD CONSTRAINT "OrderDish_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderDish" ADD CONSTRAINT "OrderDish_dishId_fkey" FOREIGN KEY ("dishId") REFERENCES "Dish"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DishItemOnDish" ADD CONSTRAINT "DishItemOnDish_dishId_fkey" FOREIGN KEY ("dishId") REFERENCES "Dish"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DishItemOnDish" ADD CONSTRAINT "DishItemOnDish_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "DishItem"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
