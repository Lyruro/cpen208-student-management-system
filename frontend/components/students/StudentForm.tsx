"use client";

import { addStudent } from "@/app/students/actions";

export default function StudentForm() {
  return (
    <form action={addStudent} className="grid grid-cols-2 gap-4">

      <input
        name="student_id"
        placeholder="Student ID"
        className="border rounded-lg p-3"
        required
      />

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

      <select
        name="gender"
        className="border rounded-lg p-3"
      >
        <option value="">Gender</option>
        <option>Male</option>
        <option>Female</option>
      </select>

      <input
        name="email"
        type="email"
        placeholder="Email"
        className="border rounded-lg p-3"
      />

      <input
        name="phone"
        placeholder="Phone"
        className="border rounded-lg p-3"
      />

      <input
        name="programme"
        placeholder="Programme"
        className="border rounded-lg p-3"
      />

      <input
        name="level"
        type="number"
        placeholder="Level"
        className="border rounded-lg p-3"
      />

      <input
        name="total_fees"
        type="number"
        step="0.01"
        placeholder="Total Fees"
        className="border rounded-lg p-3 col-span-2"
        required
      />

      <button
        type="submit"
        className="col-span-2 bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg"
      >
        Save Student
      </button>

    </form>
  );
}