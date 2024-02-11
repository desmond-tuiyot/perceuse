-- AlterTable
ALTER TABLE "DanceMove" ADD COLUMN     "danceStyleId" INTEGER;

-- CreateTable
CREATE TABLE "DanceStyle" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "aliases" TEXT[],
    "origin" TEXT,
    "officialSong" TEXT,

    CONSTRAINT "DanceStyle_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "DanceMove" ADD CONSTRAINT "DanceMove_danceStyleId_fkey" FOREIGN KEY ("danceStyleId") REFERENCES "DanceStyle"("id") ON DELETE SET NULL ON UPDATE CASCADE;
