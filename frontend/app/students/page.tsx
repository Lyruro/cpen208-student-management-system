import { prisma } from "@/lib/prisma";
import StudentTable from "@/components/students/StudentTable";
import AddStudentForm from "@/components/students/AddStudentForm";

export default async function StudentsPage() {
  const students = await prisma.student.findMany({
    orderBy: {
      student_id: "asc",
    },
  });

  const formattedStudents = students.map((student) => ({
  ...student,
  total_fees: student.total_fees.toString(),
  }));

  return (
    <main className="p-8 bg-slate-100 min-h-screen">
      <div className="mb-8">
        <h1 className="text-4xl font-bold text-blue-700">
          Students
        </h1>

        <AddStudentForm />
      </div>

      <StudentTable students= {formattedStudents} />
    </main>
  );
}