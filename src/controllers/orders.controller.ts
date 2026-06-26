import { Request, Response } from 'express';
import { listOrders, saveOrder } from '../services/orders.service';

const getCurrentDateTime = () => {
    const now = new Date();
    const date = now;
    const time = now.toTimeString().slice(0, 5);
    return { date, time };
};

export const getOrders = async (req: Request, res: Response) => {
    const orders = await listOrders();
    res.json(orders);
};

export const createOrder = async (req: Request, res: Response) => {
    const { table, total } = req.body;

    if (table == null || total == null) {
        return res.status(400).json({
            error: 'Missing fields: table, total',
        });
    }

    const { date, time } = getCurrentDateTime();
    const newOrder = await saveOrder({ date, time, table, total });

    res.status(201).json(newOrder);
};