require('dotenv').config();
const express = require('express');
const cors = require('cors');
const connectDB = require('./config/db');
const patientRoutes = require('./routes/patientRoutes');

const app = express();
const PORT = process.env.PORT || 4002;

// ── CORS ──────────────────────────────────────────────────────────────────────
// ALLOWED_ORIGINS is a comma-separated list of allowed origins.
// Set via docker-compose environment or EC2 User Data / ASG Launch Template.
const allowedOrigins = process.env.ALLOWED_ORIGINS
  ? process.env.ALLOWED_ORIGINS.split(',').map((o) => o.trim())
  : ['http://localhost:8080'];

app.use(cors({
  origin: (origin, callback) => {
    if (!origin) return callback(null, true);
    if (allowedOrigins.includes(origin)) return callback(null, true);
    return callback(new Error(`CORS: origin '${origin}' not allowed`));
  },
  credentials: true,
}));
app.use(express.json());

app.use('/api/patients', patientRoutes);

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok', service: 'patient-service' });
});

app.use((req, res) => {
  res.status(404).json({ success: false, message: 'Route not found' });
});

app.use((err, req, res, next) => {
  console.error('[Patient] Unhandled error:', err.message);
  res.status(500).json({ success: false, message: 'Internal server error' });
});

const start = async () => {
  await connectDB();
  app.listen(PORT, () => {
    console.log(`[Patient Service] Running on port ${PORT}`);
  });
};

start();
//add
