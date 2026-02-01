import mongoose from 'mongoose';

async function run() {
  await mongoose.connect('mongodb://localhost:27017/updatedatabase');

  const User = mongoose.model(
    'User',
    new mongoose.Schema({
      userId: Number,
      name: String,
      city: String,
      age: Number,
      isActive: Boolean,
    }),
  );

  const users = [
    { userId: 101, name: 'Amit', city: 'Delhi', age: 25, isActive: true },
    { userId: 102, name: 'Rohit', city: 'Mumbai', age: 30, isActive: true },
    { userId: 103, name: 'Neha', city: 'Kolkata', age: 22, isActive: false },
    { userId: 104, name: 'Sneha', city: 'Delhi', age: 29, isActive: true },
    { userId: 105, name: 'Arun', city: 'Patna', age: 35, isActive: false },
  ];
  await User.deleteMany({});
  await User.insertMany(users);

  console.log('Database seeded successfully');
  await mongoose.disconnect();
}

run();
