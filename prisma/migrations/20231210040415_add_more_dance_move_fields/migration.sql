-- CreateEnum
CREATE TYPE "Era" AS ENUM ('OLD_SCHOOL', 'NEW_SCHOOL');

-- AlterTable
ALTER TABLE "DanceMove" ADD COLUMN     "aliases" TEXT[],
ADD COLUMN     "countryOfOrigin" TEXT,
ADD COLUMN     "dateCreated" TIMESTAMP(3),
ADD COLUMN     "dateLearned" TIMESTAMP(3),
ADD COLUMN     "datesReviewed" TIMESTAMP(3)[],
ADD COLUMN     "era" "Era",
ADD COLUMN     "officialSong" TEXT,
ADD COLUMN     "tutorials" TEXT[];
