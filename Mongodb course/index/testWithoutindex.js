import mongoose from 'mongoose';

async function run() {
  await mongoose.connect('mongodb://localhost:27017/indexDemo');

  const Address = mongoose.model(
    'Address',
    new mongoose.Schema({}, { strict: false }), // accept all fields
  );

  // 🔥 Make sure NO index exists on userId
  await Address.collection.dropIndexes().catch(() => {});

  console.time('query-time');

  const result = await Address.find({ userId: 101 }).explain('executionStats');

  console.timeEnd('query-time');

  console.log(result.executionStats);

  mongoose.disconnect();
}

run();

// ❌ Without Index

// stage: 'COLLSCAN'

// docsExamined: 10

// took ~13ms

// 🧠 Rule of MongoDB

// ✔️ For small collections → index doesn’t matter much
// ✔️ For large collections → index becomes life saver
