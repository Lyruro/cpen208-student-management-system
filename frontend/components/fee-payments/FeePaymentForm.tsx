import { addFeePayment } from "@/app/fee-payments/actions";

export default function FeePaymentForm() {
  return (
    <form action={addFeePayment} className="grid grid-cols-2 gap-4">

      <input
        name="student_id"
        placeholder="Student ID"
        className="border rounded-lg p-3"
        required
      />

      <input
        name="amount_paid"
        type="number"
        step="0.01"
        placeholder="Amount Paid"
        className="border rounded-lg p-3"
        required
      />

      <input
        name="payment_date"
        type="date"
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

      <input
        name="academic_year"
        placeholder="Academic Year"
        className="border rounded-lg p-3"
        required
      />

      <button
        type="submit"
        className="col-span-2 bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg"
      >
        Save Payment
      </button>

    </form>
  );
}