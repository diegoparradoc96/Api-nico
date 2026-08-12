import "dotenv/config";
import prisma from "../src/db/prisma";

async function main() {
    // Limpiar en orden para evitar restricciones FK (cuidado en producción)
    await prisma.orderDish.deleteMany();
    await prisma.dishItemOnDish.deleteMany();
    await prisma.order.deleteMany();
    await prisma.dishItem.deleteMany();
    await prisma.dish.deleteMany();
    await prisma.destination.deleteMany();

    // Destinos
    const dest = await prisma.destination.create({
        data: { name: "Domicilios" },
    });

    // Platos
    const pizza = await prisma.dish.create({
        data: { name: "Pizza Margherita", price: "9.99", image: null },
    });
    const ensalada = await prisma.dish.create({
        data: { name: "Ensalada César", price: "6.50" },
    });

    // Items
    const tomate = await prisma.dishItem.create({ data: { name: "Tomate" } });
    const lechuga = await prisma.dishItem.create({ data: { name: "Lechuga" } });

    // Relacionar items con platos
    await prisma.dishItemOnDish.create({
        data: {
            dish: { connect: { id: pizza.id } },
            item: { connect: { id: tomate.id } },
            quantity: 2,
        },
    });
    await prisma.dishItemOnDish.create({
        data: {
            dish: { connect: { id: ensalada.id } },
            item: { connect: { id: lechuga.id } },
            quantity: 1,
        },
    });

    // Crear una orden con platos (crea filas en order_dishes)
    const order = await prisma.order.create({
        data: {
            salesValue: "26.48",
            destination: { connect: { id: dest.id } },
            dishes: {
                create: [
                    { dish: { connect: { id: pizza.id } }, dishQuantity: 2, dishPrice: "9.99" },
                    { dish: { connect: { id: ensalada.id } }, dishQuantity: 1, dishPrice: "6.50" },
                ],
            },
        },
        include: { dishes: true },
    });

    console.log("Seed realizado:", { dest, pizza, ensalada, tomate, lechuga, order });
}

main()
    .catch((e) => {
        console.error(e);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });