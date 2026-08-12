import { Router } from 'express';
import { getOrderController, getOrdersController, postOrderController, getOrdersWithDishesController, putOrderController } from '../controllers/orders.controller';

const router = Router();


router.get('/:id', getOrderController);
router.get('/', getOrdersController);
router.get('/with-dishes', getOrdersWithDishesController);

router.post('/', postOrderController);

router.put('/:id', putOrderController);

export default router;