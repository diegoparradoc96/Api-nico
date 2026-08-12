import { Request, Response } from 'express';
import { getOrderService, getOrdersService, getOrdersWithDishesService, postOrderService, putOrderService, deleteOrderService } from '../services/orders.service';

import { Order } from "@prisma/client"

export const getOrderController = async (req: Request, res: Response) => {
    const { id } = req.params as { id: string };

    const order = await getOrderService(id);

    if (!order) {
        return res.status(404).json({ error: 'Order not found' });
    }

    res.json(order);
};

export const getOrdersController = async (req: Request, res: Response) => {
    const orders = await getOrdersService();
    res.json(orders);
};

export const getOrdersWithDishesController = async (req: Request, res: Response) => {
    const orders = await getOrdersWithDishesService();
    res.json(orders);
}

export const postOrderController = async (req: Request, res: Response) => {
    const order = req.body as Order

    if (order.destinationId == null || order.salesValue == null) {
        return res.status(400).json({
            error: 'Missing fields: destinationId, salesValue',
        });
    }

    const date = new Date();

    const newOrder = await postOrderService({ ...order, createdAt: date });

    res.status(201).json(newOrder);
};

export const putOrderController = async (req: Request<{ id: string }>, res: Response) => {
    const { id } = req.params;
    const order = req.body as Order;

    if (order.destinationId == null || order.salesValue == null) {
        return res.status(400).json({
            error: 'Missing fields: destinationId, salesValue',
        });
    }

    const date = new Date();

    const updatedOrder = await putOrderService(id, { ...order, updatedAt: date });

    res.json(updatedOrder);
}

export const deleteOrderController = async (req: Request<{ id: string }>, res: Response) => {
    const { id } = req.params;

    await deleteOrderService(id);

    res.status(204).send();
}