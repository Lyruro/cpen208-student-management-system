"use client";

import { deleteStudent } from "@/app/students/actions";

type Props = {
  studentId: string;
};

export default function DeleteButton({ studentId }: Props) {
  async function handleDelete() {
    const confirmed = confirm(
      "Are you sure you want to delete this student?"
    );

    if (!confirmed) return;

    await deleteStudent(studentId);
  }

  return (
    <button
      onClick={handleDelete}
      className="bg-red-600 hover:bg-red-700 text-white px-3 py-1 rounded"
    >
      Delete
    </button>
  );
}