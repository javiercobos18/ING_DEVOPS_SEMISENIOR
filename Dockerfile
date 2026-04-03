# Etapa 1: build
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Etapa 2: runtime
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY src/ ./src
ENV PATH=/root/.local/bin:$PATH
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "80"]
