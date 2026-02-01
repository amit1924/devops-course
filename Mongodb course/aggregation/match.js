import mongoose from 'mongoose';
import { run } from 'node:test';

async function runAggregation() {
  await mongoose.connect('mongodb://localhost:27017/test');
  const Order = mongoose.model(
    'Order',
    new mongoose.Schema({}, { strict: false }),
  );
  const result = await Order.aggregate([
    { $match: { userId: 101 } },
    {
      $group: {
        _id: '$userId',
        totalSpent: { $sum: '$total' },
      },
    },
  ]);
  console.log(result);
  mongoose.disconnect();
}
runAggregation();
