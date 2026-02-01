import mongoose from 'mongoose';

async function run() {
  await mongoose.connect('mongodb://localhost:27017/updatedatabase');

  const User = mongoose.model(
    'User',
    new mongoose.Schema({}, { strict: false }),
  );

  const result = await User.updateOne(
    { userId: 101 }, // condition
    { $set: { name: 'Arsh' } }, // update
  );
  console.log(result);
}

run().catch((error) => {
  console.error('Error updating document:', error);
  mongoose.disconnect();
});
