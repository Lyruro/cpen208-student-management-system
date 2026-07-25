import Link from "next/link";

export default function RegisterPage() {
  return (
    <main className="min-h-screen flex items-center justify-center bg-slate-100">
      <div className="bg-white shadow-xl rounded-xl p-8 w-[450px]">

        <h1 className="text-3xl font-bold text-center text-green-700">
          Register
        </h1>

        <form className="space-y-4 mt-8">

          <input
            className="border rounded-lg w-full p-3"
            placeholder="Full Name"
          />

          <input
            className="border rounded-lg w-full p-3"
            placeholder="Email"
            type="email"
          />

          <input
            className="border rounded-lg w-full p-3"
            placeholder="Password"
            type="password"
          />

          <input
            className="border rounded-lg w-full p-3"
            placeholder="Confirm Password"
            type="password"
          />

          <button
            type="button"
            className="w-full bg-green-600 text-white py-3 rounded-lg hover:bg-green-700"
          >
            Register
          </button>

        </form>

        <p className="text-center mt-6">
          Already have an account?{" "}
          <Link
            href="/login"
            className="text-green-700 font-semibold"
          >
            Login
          </Link>
        </p>

      </div>
    </main>
  );
}