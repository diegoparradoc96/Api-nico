import prisma from "../db/prisma";
import { Dish } from "@prisma/client";

export const listDishes = () => {
  return prisma.dish.findMany({
    orderBy: { name: "asc" },
  });
}

export const saveDish = (dish: Dish) => {
  return prisma.dish.create({
    data: dish
  });
}

export const putDish = (id: string, dish: Dish) => {
  return prisma.dish.update({
    where: { id },
    data: dish
  });
}