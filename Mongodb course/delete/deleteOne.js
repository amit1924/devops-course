import mongoose from 'mongoose';

async function run() {
  await mongoose.connect('mongodb://localhost:27017/updatedatabase');

  const User = mongoose.model(
    'User',
    new mongoose.Schema({}, { strict: false }),
  );

  const result = await User.deleteOne(
    { userId: 103 }, // condition
  );
  console.log(result);
}

run().catch((error) => {
  console.error('Error deleting document:', error);
  mongoose.disconnect();
});
