import mongoose from 'mongoose';
import { run } from 'node:test';

async function runAggregation() {
  await mongoose.connect('mongodb://localhost:27017/test');
  const Order = mongoose.model(
    'Order',
    new mongoose.Schema({}, { strict: false }),
  );
  const result = await Order.aggregate([
    {
      $group: {
        _id: '$userId',
        totalSpent: { $sum: '$total' },
      },
    },
    { $sort: { totalSpent: -1 } },
    { $limit: 1 },
  ]);
  console.log(result);
  //   [ { _id: 102, totalSpent: 1500 } ]

  mongoose.disconnect();
}
runAggregation();
