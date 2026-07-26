

import { addCourse } from "@/app/courses/actions";

export default function CourseForm() {
  return (
    <form action={addCourse} className="grid grid-cols-2 gap-4">

      <input
        name="course_code"
        placeholder="Course Code"
        className="border rounded-lg p-3"
        required
      />

      <input
        name="course_name"
        placeholder="Course Name"
        className="border rounded-lg p-3"
        required
      />

      <input
        name="credit_hours"
        type="number"
        placeholder="Credit Hours"
        className="border rounded-lg p-3"
        required
      />

      <input
        name="semester"
        type="number"
        placeholder="Semester"
        className="border rounded-lg p-3"
        required
      />

      <button
        type="submit"
        className="col-span-2 bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg"
      >
        Save Course
      </button>

    </form>
  );
}