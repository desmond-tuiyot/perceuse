/*
  Warnings:

  - You are about to drop the column `countryOfOrigin` on the `DanceMove` table. All the data in the column will be lost.
  - You are about to drop the column `officialSong` on the `DanceStyle` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "DanceMove" DROP COLUMN "countryOfOrigin",
ADD COLUMN     "origin" TEXT;

-- AlterTable
ALTER TABLE "DanceStyle" DROP COLUMN "officialSong",
ADD COLUMN     "creatorId" INTEGER,
ADD COLUMN     "dateCreated" TIMESTAMP(3);

-- AddForeignKey
ALTER TABLE "DanceStyle" ADD CONSTRAINT "DanceStyle_creatorId_fkey" FOREIGN KEY ("creatorId") REFERENCES "Creator"("id") ON DELETE SET NULL ON UPDATE CASCADE;
