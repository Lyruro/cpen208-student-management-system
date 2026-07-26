import { prisma } from "@/lib/prisma";
import CourseTable from "@/components/courses/CourseTable";
import AddCourseForm from "@/components/courses/AddCourseForm";

export default async function CoursesPage() {
  const courses = await prisma.course.findMany({
    orderBy: {
      course_code: "asc",
    },
  });

  return (
    <main className="p-8 bg-slate-100 min-h-screen">

      <h1 className="text-4xl font-bold text-blue-700 mb-8">
        Courses
      </h1>

      <AddCourseForm />

      <CourseTable courses={courses} />

    </main>
  );
}