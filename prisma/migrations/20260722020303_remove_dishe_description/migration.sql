/*
  Warnings:

  - You are about to drop the column `description` on the `Dishe` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Dishe" DROP COLUMN "description";

-- CreateTable
CREATE TABLE "DisheItem" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "image" TEXT,
    "disheId" TEXT NOT NULL,

    CONSTRAINT "DisheItem_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "DisheItem" ADD CONSTRAINT "DisheItem_disheId_fkey" FOREIGN KEY ("disheId") REFERENCES "Dishe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
