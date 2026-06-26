import prisma from '../db/prisma';

export type CreateOrderInput = {
    table: number;
    total: number;
    date: Date;
    time: string;
};

export const listOrders = () => {
    return prisma.order.findMany({
        orderBy: { date: 'desc' },
    });
};

export const saveOrder = (data: CreateOrderInput) => {
    return prisma.order.create({
        data: {
            date: data.date,
            time: data.time,
            table: data.table,
            total: data.total,
        },
    });
};