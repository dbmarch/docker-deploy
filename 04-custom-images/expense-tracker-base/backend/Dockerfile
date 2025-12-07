FROM python:3.12-slim
#install curl for debugging 
RUN apt update && apt install -y curl && rm -rf /var/lib/apt/lists/*
LABEL app.expense.part="backend"
LABEL app.expense.version="1.0.0"
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
# CMD uvicorn app.main:app --host 0.0.0.0 --port 5001
EXPOSE 5001
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "5001"]

