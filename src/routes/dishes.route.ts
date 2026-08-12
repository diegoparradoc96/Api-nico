import { Router } from 'express';
import { getDishes, createDishe } from '../controllers/dishes.controller';

const router = Router();

router.get('/', getDishes);
router.post('/', createDishe);

export default router;