import { prisma } from "@/lib/prisma";
import FeePaymentTable from "@/components/fee-payments/FeePaymentTable";
import AddFeePaymentForm from "@/components/fee-payments/AddFeePaymentForm";

export default async function FeePaymentsPage() {
  const payments = await prisma.fee_payment.findMany({
    orderBy: {
      payment_id: "asc",
    },
  });

  const formattedPayments = payments.map((payment) => ({
    ...payment,
    amount_paid: payment.amount_paid.toString(),
  }));

  return (
    <main className="p-8 bg-slate-100 min-h-screen">
      <h1 className="text-4xl font-bold text-blue-700 mb-8">
        Fee Payments
      </h1>

      <AddFeePaymentForm />

      <FeePaymentTable payments={formattedPayments} />
    </main>
  );
}