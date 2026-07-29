"use server";

import { prisma } from "@/lib/prisma";
import { revalidatePath } from "next/cache";

export async function addLecturer(formData: FormData) {
  await prisma.lecturer.create({
    data: {
      first_name: formData.get("first_name") as string,
      last_name: formData.get("last_name") as string,
      email: formData.get("email") as string,
      office: formData.get("office") as string,
    },
  });

  revalidatePath("/lecturers");
}