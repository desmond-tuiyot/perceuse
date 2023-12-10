-- CreateTable
CREATE TABLE "Difficulty" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "rating" INTEGER NOT NULL,
    "danceMoveId" INTEGER NOT NULL,

    CONSTRAINT "Difficulty_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Difficulty" ADD CONSTRAINT "Difficulty_danceMoveId_fkey" FOREIGN KEY ("danceMoveId") REFERENCES "DanceMove"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
