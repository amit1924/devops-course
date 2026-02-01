import express from 'express';
import mongoose from 'mongoose';

const app = express();
app.use(express.json());

mongoose.connect('mongodb://mongo-db:27017/demoDB');

const User = mongoose.model(
  'User',
  new mongoose.Schema({
    name: String,
  }),
);

app.get('/', (req, res) => res.send('🚀 Hello Amit, Live Bind Mount Test!'));

app.post('/users', async (req, res) => {
  res.send(await User.create(req.body));
});

app.get('/users', async (req, res) => {
  res.send(await User.find());
});

app.listen(3000, () => console.log('API running on 3000'));
