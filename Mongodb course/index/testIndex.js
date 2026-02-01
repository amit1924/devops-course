import mongoose from 'mongoose';

async function run() {
  await mongoose.connect('mongodb://localhost:27017/indexDemo');

  const Address = mongoose.model(
    'Address',
    new mongoose.Schema({}, { strict: false }), // allow all fields
  );

  console.time('query-time');

  const result = await Address.find({ userId: 101 }).explain('executionStats');

  console.timeEnd('query-time');

  console.log(result.executionStats);

  mongoose.disconnect();
}

run();
