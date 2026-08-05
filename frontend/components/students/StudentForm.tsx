"use client";

import { addStudent, updateStudent } from "@/app/students/actions";

type Student = {
  student_id: string;
  first_name: string;
  last_name: string;
  gender: string | null;
  email: string | null;
  phone: string | null;
  programme: string | null;
  level: number | null;
  total_fees: string;
};

type Props = {
  student?: Student;
};

export default function StudentForm({ student }: Props) {
  const action = student ? updateStudent : addStudent;

  return (
    <form action={action} className="grid grid-cols-2 gap-4">

      <input
        name="student_id"
        defaultValue={student?.student_id}
        placeholder="Student ID"
        className="border rounded-lg p-3"
        readOnly={!!student}
        required
      />

      <input
        name="first_name"
        defaultValue={student?.first_name}
        placeholder="First Name"
        className="border rounded-lg p-3"
        required
      />

      <input
        name="last_name"
        defaultValue={student?.last_name}
        placeholder="Last Name"
        className="border rounded-lg p-3"
        required
      />

      <select
        name="gender"
        defaultValue={student?.gender ?? ""}
        className="border rounded-lg p-3"
      >
        <option value="">Gender</option>
        <option value="Male">Male</option>
        <option value="Female">Female</option>
      </select>

      <input
        name="email"
        type="email"
        defaultValue={student?.email ?? ""}
        placeholder="Email"
        className="border rounded-lg p-3"
      />

      <input
        name="phone"
        defaultValue={student?.phone ?? ""}
        placeholder="Phone"
        className="border rounded-lg p-3"
      />

      <input
        name="programme"
        defaultValue={student?.programme ?? ""}
        placeholder="Programme"
        className="border rounded-lg p-3"
      />

      <input
        name="level"
        type="number"
        defaultValue={student?.level ?? undefined}
        placeholder="Level"
        className="border rounded-lg p-3"
      />

      <input
        name="total_fees"
        type="number"
        step="0.01"
        defaultValue={student?.total_fees}
        placeholder="Total Fees"
        className="border rounded-lg p-3 col-span-2"
        required
      />

      <button
        type="submit"
        className="col-span-2 bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg"
      >
        {student ? "Update Student" : "Save Student"}
      </button>

    </form>
  );
}