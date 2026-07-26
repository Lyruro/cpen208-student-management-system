"use server";

import { prisma } from "@/lib/prisma";
import { revalidatePath } from "next/cache";

export async function addCourse(formData: FormData) {
  await prisma.course.create({
    data: {
      course_code: formData.get("course_code") as string,
      course_name: formData.get("course_name") as string,
      credit_hours: Number(formData.get("credit_hours")),
      semester: Number(formData.get("semester")),
    },
  });

  revalidatePath("/courses");
}