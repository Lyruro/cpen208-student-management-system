import Link from "next/link";

export default function LoginPage() {
  return (
    <main className="min-h-screen flex items-center justify-center bg-slate-100">
      <div className="bg-white shadow-xl rounded-xl p-8 w-[420px]">

        <h1 className="text-3xl font-bold text-center text-blue-700">
          Login
        </h1>

        <form className="space-y-5 mt-8">

          <div>
            <label className="font-medium">Email</label>

            <input
              type="email"
              className="border rounded-lg w-full p-3 mt-2"
              placeholder="Enter email"
            />
          </div>

          <div>
            <label className="font-medium">Password</label>

            <input
              type="password"
              className="border rounded-lg w-full p-3 mt-2"
              placeholder="Enter password"
            />
          </div>

          <Link
            href="/dashboard"
            className="block w-full bg-blue-600 text-white text-center py-3 rounded-lg hover:bg-blue-700"
          >
            Login
          </Link>

        </form>

        <p className="mt-6 text-center">
          Don't have an account?{" "}
          <Link
            href="/register"
            className="text-blue-600 font-semibold"
          >
            Register
          </Link>
        </p>

      </div>
    </main>
  );
}