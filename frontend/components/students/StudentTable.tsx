"use client";

import { useState } from "react";
import SearchBar from "./SearchBar";

type Student = {
  student_id: string;
  first_name: string;
  last_name: string;
  programme: string | null;
  level: number | null;
  email: string | null;
};

type Props = {
  students: Student[];
};

export default function StudentTable({ students }: Props) {
  const [search, setSearch] = useState("");

  const filteredStudents = students.filter((student) => {
    const text = search.toLowerCase();

    return (
      student.student_id.toLowerCase().includes(text) ||
      `${student.first_name} ${student.last_name}`
        .toLowerCase()
        .includes(text)
    );
  });

  return (
    <>
      <SearchBar value={search} onChange={setSearch} />

      <div className="bg-white rounded-xl shadow-lg overflow-hidden">
        <table className="w-full">

          <thead className="bg-blue-700 text-white">

            <tr>
              <th className="p-4">Student ID</th>
              <th className="p-4">Name</th>
              <th className="p-4">Programme</th>
              <th className="p-4">Level</th>
              <th className="p-4">Email</th>
              <th className="p-4">Actions</th>
            </tr>

          </thead>

          <tbody>

            {filteredStudents.map((student) => (

              <tr
                key={student.student_id}
                className="border-b hover:bg-slate-50"
              >

                <td className="p-4">{student.student_id}</td>

                <td className="p-4">
                  {student.first_name} {student.last_name}
                </td>

                <td className="p-4">{student.programme}</td>

                <td className="p-4">{student.level}</td>

                <td className="p-4">{student.email}</td>

                <td className="p-4">

                  <button className="bg-green-600 text-white px-3 py-1 rounded mr-2">
                    Edit
                  </button>

                  <button className="bg-red-600 text-white px-3 py-1 rounded">
                    Delete
                  </button>

                </td>

              </tr>

            ))}

          </tbody>

        </table>
      </div>
    </>
  );
}