FROM node:20-alpine AS base

FROM base AS builder
WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm install
COPY . .

RUN npm run build

FROM base AS runner
WORKDIR /app

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./

CMD ["npm", "start"]
