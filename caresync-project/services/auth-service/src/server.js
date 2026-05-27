require('dotenv').config();
const express = require('express');
const cors = require('cors');
const connectDB = require('./config/db');
const seedDoctorAccounts = require('./config/seed');
const authRoutes = require('./routes/authRoutes');

const app = express();
const PORT = process.env.PORT || 4001;

// ── CORS ──────────────────────────────────────────────────────────────────────
// ALLOWED_ORIGINS is a comma-separated list of allowed origins.
// Set via docker-compose environment or EC2 User Data / ASG Launch Template.
// Example: ALLOWED_ORIGINS=http://internal-caresync-alb-xyz.us-east-1.elb.amazonaws.com
const allowedOrigins = process.env.ALLOWED_ORIGINS
  ? process.env.ALLOWED_ORIGINS.split(',').map((o) => o.trim())
  : ['http://localhost:8080'];

app.use(cors({
  origin: (origin, callback) => {
    // Allow requests with no origin (server-to-server calls, health checks)
    if (!origin) return callback(null, true);
    if (allowedOrigins.includes(origin)) return callback(null, true);
    return callback(new Error(`CORS: origin '${origin}' not allowed`));
  },
  credentials: true,
}));
app.use(express.json());

// ── Routes ────────────────────────────────────────────────────────────────
app.use('/api/auth', authRoutes);

// ── Health Check ──────────────────────────────────────────────────────────
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok', service: 'auth-service' });
});

// ── 404 Handler ───────────────────────────────────────────────────────────
app.use((req, res) => {
  res.status(404).json({ success: false, message: 'Route not found' });
});

// ── Global Error Handler ──────────────────────────────────────────────────
app.use((err, req, res, next) => {
  console.error('[Auth] Unhandled error:', err.message);
  res.status(500).json({ success: false, message: 'Internal server error' });
});

// ── Start Server ──────────────────────────────────────────────────────────
const start = async () => {
  await connectDB();
  await seedDoctorAccounts();
  app.listen(PORT, () => {
    console.log(`[Auth Service] Running on port ${PORT}`);
  });
};

start();
