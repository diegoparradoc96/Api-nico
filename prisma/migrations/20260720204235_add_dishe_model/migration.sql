-- CreateTable
CREATE TABLE "Dishe" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "image" TEXT,

    CONSTRAINT "Dishe_pkey" PRIMARY KEY ("id")
);
