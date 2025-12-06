
Complete docker command to create the docker container and start it up:

docker container run --mount type=volume,source=db-vol,target=/var/lib/postgresql/data -it -e POSTGRES_PASSWORD=top-secret -e POSTGRES_DB=expense_tracker -e POSTGRES_USER=expense_tracker -v"$(pwd)":/docker-entrypoint-initdb.d:ro --name expense-db postgres:17


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




In the expense-tracker project directory, navigate into the /db subdirectory.

Then run the following command to start a PostgreSQL container, using the configuration and seed data from the files in /db:

docker container run \
  --mount type=volume,source=db-vol,target=/var/lib/postgresql/data \
  -v "$(pwd)":/docker-entrypoint-initdb.d:ro \
  -e POSTGRES_PASSWORD=top-secret \
  -e POSTGRES_DB=expense_tracker \
  -e POSTGRES_USER=expense_tracker \
  --name expense-db \
  -d \
  postgres
docker container run:
Starts a new container from an image.

--mount type=volume,source=db-vol,target=/var/lib/postgresql/data:
Mounts a named volume (db-vol) at the location where PostgreSQL stores data (/var/lib/postgresql/data). This ensures that data persists even if the container is removed and recreated. Without it, the data would be lost when the container is deleted.

-v "$(pwd)":/docker-entrypoint-initdb.d:ro:
Mounts the current working directory ($(pwd)) as read-only (ro) into the container at the path /docker-entrypoint-initdb.d. ➡️ PostgreSQL will automatically execute any .sql or .sh scripts found here on first-time database initialization.

⚠️ Make sure you run this command from within the /db directory, so the setup .sql files are correctly mounted into the container.

Use %cd% in the Windows CMD instead of $(pwd).

In Unix Shells (Linux, macOS, Git Bash, WSL), you can also use ${PWD} instead of $(pwd).

-e POSTGRES_PASSWORD=top-secret:
Sets the superuser password for the default PostgreSQL user (postgres or custom user).

-e POSTGRES_DB=expense_tracker:
Creates a database named expense_tracker on container startup.

-e POSTGRES_USER=expense_tracker:
Creates a user named expense_tracker with the specified password, and grants ownership of the new database to that user.

--name expense-db:
Assigns a custom name to the container (expense-db) so you can easily refer to it later (e.g., docker start expense-db).

-d:

Runs the container in the background (detached mode), so it doesn't block your terminal session.

postgres:
The image being used. This pulls and runs the official PostgreSQL image from Docker Hub.