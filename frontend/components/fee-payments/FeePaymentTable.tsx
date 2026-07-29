"use client";

import { useState } from "react";

type Payment = {
  payment_id: number;
  student_id: string | null;
  amount_paid: string;
  payment_date: Date | string | null;
  semester: number | null;
  academic_year: string | null;
};

type Props = {
  payments: Payment[];
};

export default function FeePaymentTable({ payments }: Props) {
  const [search, setSearch] = useState("");

  const filteredPayments = payments.filter((payment) => {
    const text = search.toLowerCase();

    return (
      payment.student_id?.toLowerCase().includes(text) ||
      payment.academic_year?.toLowerCase().includes(text)
    );
  });

  return (
    <>
      <input
        type="text"
        placeholder="Search by Student ID or Academic Year..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        className="w-full border rounded-lg p-3 mb-6"
      />

      <div className="bg-white rounded-xl shadow-lg overflow-hidden">
        <table className="w-full">
          <thead className="bg-blue-700 text-white">
            <tr>
              <th className="p-4 text-left">Payment ID</th>
              <th className="p-4 text-left">Student ID</th>
              <th className="p-4 text-left">Amount Paid</th>
              <th className="p-4 text-left">Payment Date</th>
              <th className="p-4 text-left">Semester</th>
              <th className="p-4 text-left">Academic Year</th>
              <th className="p-4 text-center">Actions</th>
            </tr>
          </thead>

          <tbody>
            {filteredPayments.length > 0 ? (
              filteredPayments.map((payment) => (
                <tr
                  key={payment.payment_id}
                  className="border-b hover:bg-slate-50"
                >
                  <td className="p-4">{payment.payment_id}</td>

                  <td className="p-4">
                    {payment.student_id ?? "-"}
                  </td>

                  <td className="p-4">
                    GH₵ {Number(payment.amount_paid).toLocaleString(undefined, {
                      minimumFractionDigits: 2,
                      maximumFractionDigits: 2,
                    })}
                  </td>

                  <td className="p-4">
                    {payment.payment_date
                      ? new Date(payment.payment_date).toLocaleDateString()
                      : "-"}
                  </td>

                  <td className="p-4">
                    {payment.semester ?? "-"}
                  </td>

                  <td className="p-4">
                    {payment.academic_year ?? "-"}
                  </td>

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
                  colSpan={7}
                  className="text-center p-6 text-gray-500"
                >
                  No fee payments found.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </>
  );
}