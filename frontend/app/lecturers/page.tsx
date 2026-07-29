import { prisma } from "@/lib/prisma";
import LecturerTable from "@/components/lecturers/LecturerTable";
import AddLecturerForm from "@/components/lecturers/AddLecturerForm";

export default async function LecturersPage() {
  const lecturers = await prisma.lecturer.findMany({
    orderBy: {
      lecturer_id: "asc",
    },
  });

  return (
    <main className="p-8 bg-slate-100 min-h-screen">
      <h1 className="text-4xl font-bold text-blue-700 mb-8">
        Lecturers
      </h1>

      <AddLecturerForm />

      <LecturerTable lecturers={lecturers} />
    </main>
  );
}