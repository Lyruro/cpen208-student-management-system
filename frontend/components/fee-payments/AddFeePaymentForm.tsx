"use client";

import { useState } from "react";
import FeePaymentForm from "./FeePaymentForm";

export default function AddFeePaymentForm() {
  const [showForm, setShowForm] = useState(false);

  return (
    <div className="mb-8">
      <button
        onClick={() => setShowForm(!showForm)}
        className="bg-blue-600 hover:bg-blue-700 text-white px-5 py-3 rounded-lg"
      >
        {showForm ? "Close Form" : "+ Add Payment"}
      </button>

      {showForm && (
        <div className="mt-6 bg-white rounded-xl shadow-lg p-6">
          <h2 className="text-2xl font-bold mb-6">
            Add New Payment
          </h2>

          <FeePaymentForm />
        </div>
      )}
    </div>
  );
}