import { Request, Response } from 'express';
import { listDishes, saveDishe } from '../services/dishes.service';

export const getDishes = async (req: Request, res: Response) => {
    const dishes = await listDishes();
    res.json(dishes);
}

export const createDishe = async (req: Request, res: Response) => {
    const { name, price, image } = req.body;
    
    if (!name || !price) {
        return res.status(400).json({
            error: 'Missing fields: name, price',
        });
    }
    
    const newDishe = await saveDishe({ name, price, image });
    res.status(201).json(newDishe);
}
