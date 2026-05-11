# 1 - Build
FROM python:3.12-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --prefix=/install --no-cache-dir -r requirements.txt

# 2 - Production
FROM python:3.12-slim AS production

RUN adduser --system appuser

WORKDIR /app

COPY --from=builder /install /usr/local
COPY . .

USER appuser

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
