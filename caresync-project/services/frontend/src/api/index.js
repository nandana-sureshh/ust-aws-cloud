import axios from 'axios';

// ── API Base Paths ────────────────────────────────────────────────────────────
// All API calls use RELATIVE paths so they route through the nginx reverse proxy
// running inside the frontend container. nginx then proxies /api/* to the
// Internal ALB, which routes to the correct backend microservice.
//
// No build-time environment variables needed. The React bundle is now
// fully environment-agnostic and works behind any ALB/domain.
//
// Proxy targets (configured in nginx.conf via INTERNAL_ALB_DNS):
//   /api/auth/*         → Internal ALB → auth-service:4001
//   /api/patients/*     → Internal ALB → patient-service:4002
//   /api/doctors/*      → Internal ALB → doctor-service:4003
//   /api/appointments/* → Internal ALB → appointment-service:4004
// ─────────────────────────────────────────────────────────────────────────────

// ── Auth helper ───────────────────────────────────────────────────────────────
const withAuth = (config = {}) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers = { ...config.headers, Authorization: `Bearer ${token}` };
  }
  return config;
};

// ── Auth ──────────────────────────────────────────────────────────────────────
export const authApi = {
  register: (data) => axios.post('/api/auth/register', data),
  login:    (data) => axios.post('/api/auth/login', data),
};

// ── Patient ───────────────────────────────────────────────────────────────────
export const patientApi = {
  create: (data) => axios.post('/api/patients', data, withAuth()),
  getMe:  ()     => axios.get('/api/patients/me', withAuth()),
};

// ── Doctor ────────────────────────────────────────────────────────────────────
export const doctorApi = {
  add:     (data)   => axios.post('/api/doctors/', data, withAuth()),
  getAll:  (params) => axios.get('/api/doctors/', { params }),
  getById: (id)     => axios.get(`/api/doctors/${id}/`),
};

// ── Appointment ───────────────────────────────────────────────────────────────
export const appointmentApi = {
  // Patient
  book:    (data) => axios.post('/api/appointments/', data, withAuth()),
  getMine: ()     => axios.get('/api/appointments/me/', withAuth()),
  cancel:  (id)   => axios.patch(`/api/appointments/${id}/cancel/`, {}, withAuth()),
  // Doctor
  getDoctorAppointments: () => axios.get('/api/appointments/doctor/mine', withAuth()),
  accept:  (id)  => axios.patch(`/api/appointments/${id}/accept/`, {}, withAuth()),
  reject:  (id)  => axios.patch(`/api/appointments/${id}/reject/`, {}, withAuth()),
};
