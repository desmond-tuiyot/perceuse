-- AlterTable
ALTER TABLE "Difficulty" ADD COLUMN     "transitionId" INTEGER;

-- AlterTable
ALTER TABLE "Note" ADD COLUMN     "transitionId" INTEGER;

-- CreateTable
CREATE TABLE "Transition" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT,
    "description" TEXT,
    "dateLearned" TIMESTAMP(3),
    "datesReviewed" TIMESTAMP(3)[],

    CONSTRAINT "Transition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TransitionsAndMoves" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "danceMoveId" INTEGER NOT NULL,
    "transitionId" INTEGER NOT NULL,

    CONSTRAINT "TransitionsAndMoves_pkey" PRIMARY KEY ("danceMoveId","transitionId")
);

-- AddForeignKey
ALTER TABLE "Difficulty" ADD CONSTRAINT "Difficulty_transitionId_fkey" FOREIGN KEY ("transitionId") REFERENCES "Transition"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Note" ADD CONSTRAINT "Note_transitionId_fkey" FOREIGN KEY ("transitionId") REFERENCES "Transition"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransitionsAndMoves" ADD CONSTRAINT "TransitionsAndMoves_danceMoveId_fkey" FOREIGN KEY ("danceMoveId") REFERENCES "DanceMove"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransitionsAndMoves" ADD CONSTRAINT "TransitionsAndMoves_transitionId_fkey" FOREIGN KEY ("transitionId") REFERENCES "Transition"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
