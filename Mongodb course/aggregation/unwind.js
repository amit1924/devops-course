import mongoose from 'mongoose';

async function runAggregation() {
  await mongoose.connect('mongodb://localhost:27017/test');
  const Order = mongoose.model(
    'Order',
    new mongoose.Schema({}, { strict: false }),
  );
  const result = await Order.aggregate([{ $unwind: '$items' }]);
  console.log(result);

  mongoose.disconnect();
}
runAggregation();

// [
//   {
//     _id: new ObjectId('6951520b9c94892a520490b2'),
//     userId: 101,
//     total: 900,
//     items: { product: 'Phone', price: 800 },
//     __v: 0
//   },
//   {
//     _id: new ObjectId('6951520b9c94892a520490b2'),
//     userId: 101,
//     total: 900,
//     items: { product: 'Cover', price: 100 },
//     __v: 0
//   },
//   {
//     _id: new ObjectId('6951520b9c94892a520490b3'),
//     userId: 102,
//     total: 1500,
//     items: { product: 'Laptop', price: 1500 },
//     __v: 0
//   },
//   {
//     _id: new ObjectId('6951520b9c94892a520490b4'),
//     userId: 101,
//     total: 500,
//     items: { product: 'Earphones', price: 500 },
//     __v: 0
//   }
// ]
