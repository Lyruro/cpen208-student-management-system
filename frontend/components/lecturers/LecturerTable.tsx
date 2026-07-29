"use client";

import { useState } from "react";

type Lecturer = {
  lecturer_id: number;
  first_name: string | null;
  last_name: string | null;
  email: string | null;
  office: string | null;
};

type Props = {
  lecturers: Lecturer[];
};

export default function LecturerTable({ lecturers }: Props) {
  const [search, setSearch] = useState("");

  const filteredLecturers = lecturers.filter((lecturer) => {
    const text = search.toLowerCase();

    return (
      lecturer.first_name?.toLowerCase().includes(text) ||
      lecturer.last_name?.toLowerCase().includes(text) ||
      lecturer.email?.toLowerCase().includes(text) ||
      lecturer.office?.toLowerCase().includes(text)
    );
  });

  return (
    <>
      <input
        type="text"
        placeholder="Search lecturer..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        className="w-full border rounded-lg p-3 mb-6"
      />

      <div className="bg-white rounded-xl shadow-lg overflow-hidden">
        <table className="w-full">
          <thead className="bg-blue-700 text-white">
            <tr>
              <th className="p-4 text-left">ID</th>
              <th className="p-4 text-left">First Name</th>
              <th className="p-4 text-left">Last Name</th>
              <th className="p-4 text-left">Email</th>
              <th className="p-4 text-left">Office</th>
              <th className="p-4 text-center">Actions</th>
            </tr>
          </thead>

          <tbody>
            {filteredLecturers.length > 0 ? (
              filteredLecturers.map((lecturer) => (
                <tr
                  key={lecturer.lecturer_id}
                  className="border-b hover:bg-slate-50"
                >
                  <td className="p-4">{lecturer.lecturer_id}</td>
                  <td className="p-4">{lecturer.first_name}</td>
                  <td className="p-4">{lecturer.last_name}</td>
                  <td className="p-4">{lecturer.email}</td>
                  <td className="p-4">{lecturer.office}</td>

                  <td className="p-4 text-center">
                    <button className="bg-green-600 hover:bg-green-700 text-white px-3 py-1 rounded mr-2">
                      Edit
                    </button>

                    <button className="bg-red-600 hover:bg-red-700 text-white px-3 py-1 rounded">
                      Delete
                    </button>
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td
                  colSpan={6}
                  className="text-center p-6 text-gray-500"
                >
                  No lecturers found.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </>
  );
}