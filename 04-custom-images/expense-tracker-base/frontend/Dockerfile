FROM node:23 AS builder
WORKDIR /app
ARG VITE_API_BASE_URL=http://api.example.com/api
COPY package.json package-lock.json .
RUN npm install --frozen-lockfile
COPY . .
RUN npm run build

FROM nginx:alpine
LABEL app.expense.part="frontend"
LABEL app.expense.version="1.0.0"
EXPOSE 80
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

