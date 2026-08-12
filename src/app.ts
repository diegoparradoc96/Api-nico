import express from 'express';
import ordersRouter from './routes/orders.route';
import dishesRouter from './routes/dishes.route';

const app = express();

app.use(express.json());
app.use('/api/orders', ordersRouter);
app.use('/api/dishes', dishesRouter);

export default app;