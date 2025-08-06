const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Replace with your MongoDB connection string
const mongoUri = 'mongodb+srv://<username>:<password>@cluster0.mongodb.net/<dbname>?retryWrites=true&w=majority';

mongoose.connect(mongoUri, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB connected!'))
  .catch(err => console.error('MongoDB connection error:', err));

// Example schema and model
const SaleSchema = new mongoose.Schema({
  name: String,
  amount: Number,
});
const Sale = mongoose.model('Sale', SaleSchema);

// Example API endpoint
app.get('/sales', async (req, res) => {
  const sales = await Sale.find();
  res.json(sales);
});

app.post('/sales', async (req, res) => {
  const sale = new Sale(req.body);
  await sale.save();
  res.json(sale);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));