-- DropForeignKey
ALTER TABLE "Difficulty" DROP CONSTRAINT "Difficulty_danceMoveId_fkey";

-- AlterTable
ALTER TABLE "Difficulty" ALTER COLUMN "danceMoveId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Difficulty" ADD CONSTRAINT "Difficulty_danceMoveId_fkey" FOREIGN KEY ("danceMoveId") REFERENCES "DanceMove"("id") ON DELETE SET NULL ON UPDATE CASCADE;
