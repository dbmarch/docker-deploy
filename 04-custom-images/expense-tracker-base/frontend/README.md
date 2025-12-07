docker build -t expense-frontend .
docker container  run -it -p 80:80  --rm expense-frontend 



# Dashboards

http://localhost:8080/dashboard/#/



To store images in docker hub

docker build -t expense-tracker-frontend --build-arg VITE_API_BASE_URL=/api .
docker image tag expense-tracker-frontend dbmarch/expense-tracker:latest
docker push dbmarch/expense-tracker:latest

