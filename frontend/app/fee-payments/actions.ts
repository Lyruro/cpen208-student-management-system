"use server";

import { prisma } from "@/lib/prisma";
import { revalidatePath } from "next/cache";

export async function addFeePayment(formData: FormData) {
  await prisma.fee_payment.create({
    data: {
      student_id: formData.get("student_id") as string,
      amount_paid: Number(formData.get("amount_paid")),
      payment_date: new Date(formData.get("payment_date") as string),
      semester: Number(formData.get("semester")),
      academic_year: formData.get("academic_year") as string,
    },
  });

  revalidatePath("/fee-payments");
}