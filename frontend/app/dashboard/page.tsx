import Link from "next/link";
import { prisma } from "@/lib/prisma";
import DashboardCard from "@/components/DashboardCard";

export default async function Dashboard() {
  const studentCount = await prisma.student.count();
  const courseCount = await prisma.course.count();
  const lecturerCount = await prisma.lecturer.count();
  const paymentCount = await prisma.fee_payment.count();

  return (
    <main className="min-h-screen bg-slate-100 p-10">
      <h1 className="text-4xl font-bold text-blue-700 mb-8">
        Dashboard
      </h1>

      <div className="grid md:grid-cols-4 gap-6">
        <DashboardCard
          title="Students"
          value={studentCount}
        />

        <DashboardCard
          title="Courses"
          value={courseCount}
        />

        <DashboardCard
          title="Lecturers"
          value={lecturerCount}
        />

        <DashboardCard
          title="Payments"
          value={paymentCount}
        />
      </div>

      <div className="bg-white rounded-xl shadow-md mt-10 p-6">
        <h2 className="text-2xl font-semibold mb-5">
          Quick Actions
        </h2>

        <div className="flex flex-wrap gap-4">
          <Link
            href="/students"
            className="bg-blue-600 text-white px-5 py-3 rounded-lg"
          >
            View Students
          </Link>

          <Link
            href="/courses"
            className="bg-green-600 text-white px-5 py-3 rounded-lg"
          >
            View Courses
          </Link>

          <Link
            href="/lecturers"
            className="bg-purple-600 text-white px-5 py-3 rounded-lg"
          >
            View Lecturers
          </Link>

          <Link
            href="/fee-payments"
            className="bg-orange-600 text-white px-5 py-3 rounded-lg"
          >
            Fee Payments
          </Link>
        </div>
      </div>
    </main>
  );
}