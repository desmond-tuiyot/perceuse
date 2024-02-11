/*
  Warnings:

  - You are about to drop the `TransitionsAndMoves` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "LearningStage" AS ENUM ('NOT_STARTED', 'LEARNING', 'REVIEWING', 'PROFICIENT', 'MASTERED');

-- DropForeignKey
ALTER TABLE "TransitionsAndMoves" DROP CONSTRAINT "TransitionsAndMoves_danceMoveId_fkey";

-- DropForeignKey
ALTER TABLE "TransitionsAndMoves" DROP CONSTRAINT "TransitionsAndMoves_transitionId_fkey";

-- AlterTable
ALTER TABLE "Transition" ADD COLUMN     "danceMove1Id" INTEGER,
ADD COLUMN     "danceMove2Id" INTEGER;

-- DropTable
DROP TABLE "TransitionsAndMoves";

-- CreateTable
CREATE TABLE "LearningProgress" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "stage" "LearningStage" NOT NULL,
    "danceMoveId" INTEGER,
    "transitionId" INTEGER,

    CONSTRAINT "LearningProgress_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Transition" ADD CONSTRAINT "Transition_danceMove1Id_fkey" FOREIGN KEY ("danceMove1Id") REFERENCES "DanceMove"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transition" ADD CONSTRAINT "Transition_danceMove2Id_fkey" FOREIGN KEY ("danceMove2Id") REFERENCES "DanceMove"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LearningProgress" ADD CONSTRAINT "LearningProgress_danceMoveId_fkey" FOREIGN KEY ("danceMoveId") REFERENCES "DanceMove"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LearningProgress" ADD CONSTRAINT "LearningProgress_transitionId_fkey" FOREIGN KEY ("transitionId") REFERENCES "Transition"("id") ON DELETE SET NULL ON UPDATE CASCADE;
