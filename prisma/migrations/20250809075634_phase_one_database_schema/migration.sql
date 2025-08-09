-- CreateEnum
CREATE TYPE "public"."ProgramType" AS ENUM ('GRADUATE', 'UNDERGRADUATE');

-- CreateEnum
CREATE TYPE "public"."RoomType" AS ENUM ('LECTURE', 'LABORATORY');

-- CreateEnum
CREATE TYPE "public"."RoomStatus" AS ENUM ('AVAILABLE', 'UNAVAILABLE');

-- CreateTable
CREATE TABLE "public"."Program" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "department" TEXT NOT NULL,
    "accreditationLevel" TEXT,
    "type" "public"."ProgramType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Program_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Section" (
    "id" SERIAL NOT NULL,
    "programId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Section_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Prospectus" (
    "id" SERIAL NOT NULL,
    "programId" INTEGER NOT NULL,
    "startYear" INTEGER NOT NULL,
    "endYear" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Prospectus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Subject" (
    "id" SERIAL NOT NULL,
    "prospectusId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "semester" INTEGER NOT NULL,
    "units" INTEGER NOT NULL,
    "lecUnits" INTEGER NOT NULL,
    "labUnits" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Subject_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."SubjectOffering" (
    "id" SERIAL NOT NULL,
    "sectionId" INTEGER NOT NULL,
    "subjectId" INTEGER NOT NULL,
    "instructorId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SubjectOffering_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Room" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "type" "public"."RoomType" NOT NULL,
    "capacity" INTEGER NOT NULL,
    "status" "public"."RoomStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Room_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ClassSchedule" (
    "id" SERIAL NOT NULL,
    "subjectOfferingId" INTEGER NOT NULL,
    "roomId" INTEGER NOT NULL,
    "dayOfWeek" INTEGER NOT NULL,
    "startMins" INTEGER NOT NULL,
    "endMins" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClassSchedule_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Prospectus_startYear_endYear_key" ON "public"."Prospectus"("startYear", "endYear");

-- CreateIndex
CREATE UNIQUE INDEX "Subject_name_key" ON "public"."Subject"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Room_name_key" ON "public"."Room"("name");

-- AddForeignKey
ALTER TABLE "public"."Section" ADD CONSTRAINT "Section_programId_fkey" FOREIGN KEY ("programId") REFERENCES "public"."Program"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Prospectus" ADD CONSTRAINT "Prospectus_programId_fkey" FOREIGN KEY ("programId") REFERENCES "public"."Program"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Subject" ADD CONSTRAINT "Subject_prospectusId_fkey" FOREIGN KEY ("prospectusId") REFERENCES "public"."Prospectus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SubjectOffering" ADD CONSTRAINT "SubjectOffering_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "public"."Section"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SubjectOffering" ADD CONSTRAINT "SubjectOffering_subjectId_fkey" FOREIGN KEY ("subjectId") REFERENCES "public"."Subject"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SubjectOffering" ADD CONSTRAINT "SubjectOffering_instructorId_fkey" FOREIGN KEY ("instructorId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ClassSchedule" ADD CONSTRAINT "ClassSchedule_subjectOfferingId_fkey" FOREIGN KEY ("subjectOfferingId") REFERENCES "public"."SubjectOffering"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ClassSchedule" ADD CONSTRAINT "ClassSchedule_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "public"."Room"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
