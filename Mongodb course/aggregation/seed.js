import mongoose from 'mongoose';
import fs from 'fs';

async function run() {
  await mongoose.connect('mongodb://localhost:27017/test');
  const Order = mongoose.model(
    'Order',
    new mongoose.Schema({}, { strict: false }),
  );

  const jsonData = fs.readFileSync('./aggregate.json', 'utf8');
  const orders = JSON.parse(jsonData);

  // Remove _id from each document so MongoDB generates new ObjectIds
  const ordersWithoutId = orders.map((order) => {
    const { _id, ...rest } = order;
    return rest;
  });

  await Order.deleteMany({});
  await Order.insertMany(ordersWithoutId);
  console.log('JSON inserted into MongoDB ✔️');
  mongoose.disconnect();
  //   [ { _id: 101, totalSpent: 1400 } ]
}
run();

// User 101 -> spent 1400
// User 102 -> spent 1500
