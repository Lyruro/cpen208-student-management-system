import Link from "next/link";

export default function Home() {
  return (
    <main className="min-h-screen flex items-center justify-center bg-slate-100">
      <div className="bg-white shadow-xl rounded-xl p-10 text-center w-[500px]">

        <h1 className="text-4xl font-bold text-blue-700">
          Student Management System
        </h1>

        <p className="mt-4 text-gray-600">
          CPEN 208 Database Project
        </p>

        <div className="mt-10 flex justify-center gap-4">

          <Link
            href="/login"
            className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition"
          >
            Login
          </Link>

          <Link
            href="/register"
            className="bg-green-600 text-white px-6 py-3 rounded-lg hover:bg-green-700 transition"
          >
            Register
          </Link>

        </div>

      </div>
    </main>
  );
}