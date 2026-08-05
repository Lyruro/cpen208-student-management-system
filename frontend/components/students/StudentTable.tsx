"use client";

import { useState } from "react";
import SearchBar from "./SearchBar";
import DeleteButton from "./DeleteButton";
import StudentForm from "./StudentForm";

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
  students: Student[];
};

export default function StudentTable({ students }: Props) {
  const [search, setSearch] = useState("");
  const [editingStudent, setEditingStudent] = useState<Student | null>(null);

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
              <th className="p-4">Fees</th>
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

                <td className="p-4">GH₵ {student.total_fees}</td>

                <td className="p-4">

                  <button
                    onClick={() => {
                      console.log(student);
                      setEditingStudent(student);
                    }}
                    className="bg-green-600 hover:bg-green-700 text-white px-3 py-1 rounded mr-2"
                  >
                    Edit
                  </button>

                  <DeleteButton studentId={student.student_id} />

                </td>

              </tr>

            ))}

          </tbody>

        </table>
      </div>
                  {editingStudent && (
        <div
          className="fixed inset-0 bg-black/40 flex items-center justify-center z-50"
          onClick={() => setEditingStudent(null)}
        >
          <div
            className="bg-white rounded-xl shadow-2xl p-8 w-full max-w-3xl mx-4 max-h-[90vh] overflow-y-auto"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-3xl font-bold text-blue-700">
                Edit Student
              </h2>

              <button
                onClick={() => setEditingStudent(null)}
                className="text-2xl font-bold text-gray-500 hover:text-red-600"
              >
                ✕
              </button>
            </div>

            <StudentForm student={editingStudent} />
          </div>
        </div>
      )}
    </>
  );
}