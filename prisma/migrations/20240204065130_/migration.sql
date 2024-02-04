/*
  Warnings:

  - A unique constraint covering the columns `[danceMove1Id,danceMove2Id]` on the table `Transition` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Transition_danceMove1Id_danceMove2Id_key" ON "Transition"("danceMove1Id", "danceMove2Id");
