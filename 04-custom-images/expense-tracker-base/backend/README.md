docker build -t expense-backend .
docker run -it expense-backend bash


Bind Mount for local development
docker container run -it --rm -v "${PWD}:/app:ro" python:3.12 sh -c "cd /app && pip install -r requirements.txt"


docker container run -it --rm -v "${PWD}:/app:ro" python:3.12 sh -c "cd /app && pip install -r requirements.txt && uvicorn app.main:app --host 0.0.0.0 --port 5001 --reload"