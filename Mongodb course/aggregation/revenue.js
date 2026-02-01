import mongoose from 'mongoose';
import { run } from 'node:test';

async function runAggregation() {
  await mongoose.connect('mongodb://localhost:27017/test');
  const Order = mongoose.model(
    'Order',
    new mongoose.Schema({}, { strict: false }),
  );
  const result = await Order.aggregate([
    { $unwind: '$items' },
    {
      $group: {
        _id: '$items.product',
        revenue: { $sum: '$items.price' },
      },
    },
  ]);
  console.log(result);

  //   [
  //   { _id: 'Phone', revenue: 800 },
  //   { _id: 'Laptop', revenue: 1500 },
  //   { _id: 'Cover', revenue: 100 },
  //   { _id: 'Earphones', revenue: 500 }
  // ]

  mongoose.disconnect();
}
runAggregation();
