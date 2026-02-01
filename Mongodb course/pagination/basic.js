import mongoose from 'mongoose';

async function run() {
  await mongoose.connect('mongodb://localhost:27017/indexDemo');
  const Address = mongoose.model(
    'Address',
    new mongoose.Schema({}, { strict: false }),
    // { strict: false } = MongoDB accepts any fields (no strict structure)
  );

  const page = 2; //which page
  const limit = 5; //how many items per page
  // page = 2
  // Means → user wants page 2

  // limit = 5
  // Means → each page should show 5 documents
  //   Page 1 → records 1 to 5

  // Page 2 → records 6 to 10

  // Page 3 → records 11 to 15
  const skip = (page - 1) * limit;

  //   page = 2
  // limit = 5

  // skip = (2 - 1) * 5
  // skip = 1 * 5
  // skip = 5

  //   👉 Skip first 5 documents
  // 👉 Show next 5

  //   Why?
  // Because page 1 already used first 5
  // So page 2 starts after that

  //trick
  //   page 1 → skip 0
  // page 2 → skip 5
  // page 3 → skip 10

  console.log('pagination');

  const result = await Address.find({}).skip(skip).limit(limit);
  console.log(result);
  mongoose.disconnect();
}
run();
