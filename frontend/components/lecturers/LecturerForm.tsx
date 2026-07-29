import { addLecturer } from "@/app/lecturers/actions";

export default function LecturerForm() {
  return (
    <form action={addLecturer} className="grid grid-cols-2 gap-4">

      <input
        name="first_name"
        placeholder="First Name"
        className="border rounded-lg p-3"
        required
      />

      <input
        name="last_name"
        placeholder="Last Name"
        className="border rounded-lg p-3"
        required
      />

      <input
        name="email"
        type="email"
        placeholder="Email"
        className="border rounded-lg p-3"
      />

      <input
        name="office"
        placeholder="Office"
        className="border rounded-lg p-3"
      />

      <button
        type="submit"
        className="col-span-2 bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg"
      >
        Save Lecturer
      </button>

    </form>
  );
}