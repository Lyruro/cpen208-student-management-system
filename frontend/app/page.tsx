export default function Home() {
  return (
    <main className="min-h-screen flex items-center justify-center bg-gray-100">
      <div className="text-center">
        <h1 className="text-5xl font-bold text-blue-700">
          Student Management System
        </h1>

        <p className="mt-4 text-gray-600">
          CPEN 208 Software Engineering Project
        </p>

        <div className="mt-8 space-x-4">
          <a
            href="/login"
            className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700"
          >
            Login
          </a>

          <a
            href="/register"
            className="bg-green-600 text-white px-6 py-3 rounded-lg hover:bg-green-700"
          >
            Register
          </a>
        </div>
      </div>
    </main>
  );
}