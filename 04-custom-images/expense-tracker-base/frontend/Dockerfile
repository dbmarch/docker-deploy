FROM node:23 AS builder
WORKDIR /app
COPY package.json package-lock.json .
RUN npm install --frozen-lockfile
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

