"use server";

import { prisma } from "@/lib/prisma";
import { Prisma } from "@prisma/client";
import { revalidatePath } from "next/cache";

export async function addStudent(formData: FormData) {
  await prisma.student.create({
    data: {
      student_id: formData.get("student_id") as string,
      first_name: formData.get("first_name") as string,
      last_name: formData.get("last_name") as string,
      gender: formData.get("gender") as string,
      email: formData.get("email") as string,
      phone: formData.get("phone") as string,
      programme: formData.get("programme") as string,
      level: Number(formData.get("level")),
      total_fees: new Prisma.Decimal(
        formData.get("total_fees") as string
      ),
    },
  });

  revalidatePath("/students");
}

export async function deleteStudent(studentId: string) {
  "use server";

  await prisma.student.delete({
    where: {
      student_id: studentId,
    },
  });

  revalidatePath("/students");
}