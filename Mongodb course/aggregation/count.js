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
        ordersCount: { $sum: 1 },
      },
    },
  ]);
  console.log(result);
  //  [ { _id: 101, ordersCount: 2 }, { _id: 102, ordersCount: 1 } ]

  //   📌 $sum: 1
  // Means counting documents

  mongoose.disconnect();
}
runAggregation();
