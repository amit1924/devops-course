import mongoose from 'mongoose';

async function run() {
  await mongoose.connect('mongodb://localhost:27017/indexDemo');

  const Address = mongoose.model(
    'Address',
    new mongoose.Schema({}, { strict: false }),
  );

  const page = 1;
  const limit = 10;
  const skip = (page - 1) * limit;

  const result = await Address.find({})
    .sort({ total: -1 }) // highest total first
    .skip(skip)
    .limit(limit);

  console.log(result);

  mongoose.disconnect();
}

run();




// [
//   {
//     _id: new ObjectId('69515a97e799930fcf511ee0'),
//     userId: 103,
//     city: 'Chicago',
//     total: 550.75,
//     createdAt: 2024-01-23T12:20:00.000Z,
//     __v: 0
//   },
//   {
//     _id: new ObjectId('69515a97e799930fcf511edb'),
//     userId: 101,
//     city: 'New York',
//     total: 450,
//     createdAt: 2024-01-18T16:45:00.000Z,
//     __v: 0
//   },
//   {
//     _id: new ObjectId('69515a97e799930fcf511ede'),
//     userId: 105,
//     city: 'Seattle',
//     total: 320,
//     createdAt: 2024-01-21T15:00:00.000Z,
//     __v: 0
//   },
//   {
//     _id: new ObjectId('69515a97e799930fcf511ed8'),
//     userId: 101,
//     city: 'New York',
//     total: 299.99,
//     createdAt: 2024-01-15T10:30:00.000Z,
//     __v: 0
//   },
//   {
//     _id: new ObjectId('69515a97e799930fcf511edc'),
//     userId: 104,
//     city: 'Miami',
//     total: 199.99,
//     createdAt: 2024-01-19T11:10:00.000Z,
//     __v: 0
//   },
//   {
//     _id: new ObjectId('69515a97e799930fcf511ed9'),
//     userId: 102,
//     city: 'Los Angeles',
//     total: 149.5,
//     createdAt: 2024-01-16T14:20:00.000Z,
//     __v: 0
//   },
//   {
//     _id: new ObjectId('69515a97e799930fcf511edf'),
//     userId: 101,
//     city: 'New York',
//     total: 120.5,
//     createdAt: 2024-01-22T10:00:00.000Z,
//     __v: 0
//   },
//   {
//     _id: new ObjectId('69515a97e799930fcf511eda'),
//     userId: 103,
//     city: 'Chicago',
//     total: 89.99,
//     createdAt: 2024-01-17T09:15:00.000Z,
//     __v: 0
//   },
//   {
//     _id: new ObjectId('69515a97e799930fcf511edd'),
//     userId: 102,
//     city: 'Los Angeles',
//     total: 75.25,
//     createdAt: 2024-01-20T13:30:00.000Z,
//     __v: 0
//   },
//   {
//     _id: new ObjectId('69515a97e799930fcf511ee1'),
//     userId: 106,
//     city: 'Boston',
//     total: 65.99,
//     createdAt: 2024-01-24T14:45:00.000Z,
//     __v: 0
//   }
// ]