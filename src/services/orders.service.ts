import prisma from '../db/prisma';
import { Order } from "@prisma/client"

export const getOrderService = (id: string) => {
    return prisma.order.findUnique({
        where: { id },
        include: {
            destination: true,
            dishes: {
                include: {
                    dish: {
                        include: {
                            items: {
                                include: {
                                    item: true
                                }
                            }
                        }
                    }
                }
            }
        }
    });
};

export const getOrdersService = () => {
    return prisma.order.findMany({
        orderBy: { createdAt: 'desc' },

        include: {
            destination: true,
        },
    });
};

export const getOrdersWithDishesService = () => {
    return prisma.order.findMany({
        orderBy: { createdAt: 'desc' },

        include: {
            destination: true,
            dishes: {
                include: {
                    dish: true
                }
            }
        }
    });
};

export const postOrderService = (order: Order) => {
    return prisma.order.create({
        data: {
            salesValue: order.salesValue,
            createdAt: order.createdAt,

            updatedAt: order.updatedAt,

            destinationId: order.destinationId,
        },
    });
};

export const putOrderService = (id: string, order: Order) => {
    return prisma.order.update({
        where: { id },
        data: {
            salesValue: order.salesValue,
            updatedAt: order.updatedAt,
            destinationId: order.destinationId,
        },
    });
}

export const deleteOrderService = (id: string) => {
    return prisma.order.delete({
        where: { id },
    });
}