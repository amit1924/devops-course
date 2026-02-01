import mongoose from 'mongoose';
import fs from 'fs';

async function run() {
  await mongoose.connect('mongodb://localhost:27017/indexDemo');
  const Address = mongoose.model(
    'Address',
    new mongoose.Schema({
      userId: Number,
      city: String,
      total: Number,
      createdAt: Date,
    }),
  );

  const jsonData = fs.readFileSync('./address.json', 'utf8');
  const addresses = JSON.parse(jsonData);

  const addressWithoutId = addresses.map((address) => {
    const { _id, ...rest } = address;
    return rest;
  });

  await Address.deleteMany(); // clear old data

  await Address.insertMany(addressWithoutId);
}

run().then(() => {
  console.log('Address data inserted into MongoDB ✔️');
  mongoose.disconnect();
});
