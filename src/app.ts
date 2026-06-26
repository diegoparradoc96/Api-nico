import express from 'express';
import ordersRouter from './routes/orders.route';

const app = express();

app.use(express.json());
app.use('/api/orders', ordersRouter);

export default app;