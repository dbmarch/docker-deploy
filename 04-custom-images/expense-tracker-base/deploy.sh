#!/usr/bin/env bash

# Create Docker network
docker network create expense-tracker

# Run PostgreSQL container
docker container run \
   --mount type=volume,source=expense-tracker-db-vol,target=/var/lib/postgresql/data \
   -d \
   -e POSTGRES_PASSWORD=top-secret \
   -e POSTGRES_DB=expense_tracker \
   -e POSTGRES_USER=expense_tracker \
   -v"$(pwd)/db":/docker-entrypoint-initdb.d:ro \
   --name expense-db \
   --network expense-tracker \
   postgres:17

# Build and run backend container
docker build -t expense-backend ./backend
docker container run \
   -d \
   --name expense-backend \
   --network expense-tracker \
   -p 8080:5001 \
   -e DATABASE_HOST=expense-db \
   expense-backend

# Build and run frontend container
docker build \
   -t expense-frontend \
   --build-arg VITE_API_BASE_URL=http://localhost:8080/api \
   ./frontend

docker container run \
   -d \
   --name expense-frontend \
   --network expense-tracker \
   -p 8081:80 \
   expense-frontend

echo "Expense Tracker deployed!"
