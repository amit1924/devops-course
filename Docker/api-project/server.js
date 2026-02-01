import express from 'express';
import mongoose from 'mongoose';

const app = express();
app.use(express.json());

mongoose.connect('mongodb://mongo-db:27017/demoDB', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const UserSchema = new mongoose.Schema({
  name: String,
  skill: String,
});

const User = mongoose.model('User', UserSchema);

app.get('/', (req, res) => {
  res.send('🚀 API is running inside Docker!');
});

app.post('/users', async (req, res) => {
  const user = await User.create(req.body);
  res.json(user);
});

app.get('/users', async (req, res) => {
  const users = await User.find();
  res.json(users);
});

app.listen(3000, () => console.log('API running on port 3000'));
