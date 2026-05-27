# ── Stage 1: Build ────────────────────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# CI=false prevents react-scripts from treating warnings as errors.
# REACT_APP_* build-time vars are no longer needed: API calls use relative
# paths (/api/*) which nginx proxies to the Internal ALB at runtime.
ENV CI=false

RUN npm run build

# ── Stage 2: Serve as non-root via unprivileged nginx ─────────────────────────
# nginxinc/nginx-unprivileged runs as uid 101 (non-root) on port 8080 by default
FROM nginxinc/nginx-unprivileged:1.25-alpine

COPY --from=builder /app/build /usr/share/nginx/html

# Copy nginx config as a TEMPLATE (not directly as default.conf).
# The CMD below runs envsubst at container startup to inject INTERNAL_ALB_DNS,
# producing the final /etc/nginx/conf.d/default.conf before nginx starts.
#
# envsubst '${INTERNAL_ALB_DNS}' only substitutes that one variable.
# All nginx built-in variables ($uri, $host, $remote_addr, etc.) are preserved.
COPY nginx.conf /etc/nginx/conf.d/default.conf.template

EXPOSE 8080

# At runtime:
# 1. envsubst reads the template and substitutes ${INTERNAL_ALB_DNS}
# 2. The result is written to the live nginx config location
# 3. nginx starts with the fully-rendered config
#
# INTERNAL_ALB_DNS must be set in docker-compose environment: or EC2 User Data.
CMD ["/bin/sh", "-c", \
     "envsubst '${INTERNAL_ALB_DNS}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]
