import mongoose from 'mongoose';

async function run() {
  await mongoose.connect('mongodb://localhost:27017/indexDemo');

  const Address = mongoose.model(
    'Address',
    new mongoose.Schema({
      userId: Number,
    }),
  );

  await Address.collection.createIndex({ userId: 1 });

  console.log('Index created ✔️');
  mongoose.disconnect();
}

run();
