
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .


FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app .


RUN mkdir -p /etc/todos && chown -R node:node /etc/todos /app

USER node

EXPOSE 3000

CMD ["node", "src/index.js"]