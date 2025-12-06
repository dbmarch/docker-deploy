docker build -t expense-backend .
docker run -it expense-backend bash


Bind Mount for local development
docker container run -it --rm -v "${PWD}:/app:ro" python:3.12 sh -c "cd /app && pip install -r requirements.txt"


docker container run -it --rm -v "${PWD}:/app:ro" python:3.12 sh -c "cd /app && pip install -r requirements.txt && uvicorn app.main:app --host 0.0.0.0 --port 5001 --reload"

docker container run -it --rm -p5001:5001 -v "${PWD}:/app:ro" python:3.12 sh -c "cd /app && pip install -r requirements.txt && uvicorn app.main:app --host 0.0.0.0 --port 5001 --reload"


Complete docker command to create the docker container and start it up:

dbmarch@Sparky-Paradise:~/workspace/docker-deploy/04-custom-images/expense-tracker-base/db$ docker container run --mount type=volume,source=db-vol,target=/var/lib/postgresql/data -it -e POSTGRES_PASSWORD=top-secret -e POSTGRES_DB=expense_tracker -e POSTGRES_USER=expense_tracker -v"$(pwd)":/docker-entrypoint-initdb.d:ro --name expense-db postgres:17


To start up a postgres container:
docker container run --mount type=volume,source=db-vol,target=/var/lib/postgresql/data -it -e POSTGRES_PASSWORD=top-secret -e POSTGRES_DB=expense_tracker -e POSTGRES_USER=expense_tracker postgres:17



To attach to a running container:
dbmarch@Sparky-Paradise:~/workspace/docker-deploy$ docker container ls
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS      NAMES
c242ff3e9cc3   postgres:17   "docker-entrypoint.s…"   23 seconds ago   Up 23 seconds   5432/tcp   hopeful_edison
dbmarch@Sparky-Paradise:~/workspace/docker-deploy$ docker container exec -it c2 bash
root@c242ff3e9cc3:/# psql -U expense_tracker
psql (17.7 (Debian 17.7-3.pgdg13+1))
Type "help" for help.

expense_tracker=# \c expense_tracker
You are now connected to database "expense_tracker" as user "expense_tracker".
expense_tracker=# \dt
Did not find any relations.
expense_tracker=# exit
root@c242ff3e9cc3:/# exit
exit