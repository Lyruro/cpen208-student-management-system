"use client";

import { useState } from "react";

type Course = {
  course_id: number;
  course_code: string;
  course_name: string;
  credit_hours: number;
  semester: number;
};

type Props = {
  courses: Course[];
};

export default function CourseTable({ courses }: Props) {
  const [search, setSearch] = useState("");

  const filteredCourses = courses.filter((course) => {
    const text = search.toLowerCase();

    return (
      course.course_code.toLowerCase().includes(text) ||
      course.course_name.toLowerCase().includes(text)
    );
  });

  return (
    <>
      <input
        type="text"
        placeholder="Search course..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        className="w-full border rounded-lg p-3 mb-6"
      />

      <div className="bg-white rounded-xl shadow-lg overflow-hidden">
        <table className="w-full">
          <thead className="bg-blue-700 text-white">
            <tr>
              <th className="p-4">Code</th>
              <th className="p-4">Course Name</th>
              <th className="p-4">Credit Hours</th>
              <th className="p-4">Semester</th>
              <th className="p-4">Actions</th>
            </tr>
          </thead>

          <tbody>
            {filteredCourses.map((course) => (
              <tr
                key={course.course_id}
                className="border-b hover:bg-slate-50"
              >
                <td className="p-4">{course.course_code}</td>
                <td className="p-4">{course.course_name}</td>
                <td className="p-4">{course.credit_hours}</td>
                <td className="p-4">{course.semester}</td>

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