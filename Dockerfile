# Pré-requisito: Python 3.9 (ou superior)
FROM python:3.9-slim

WORKDIR /app

# Passo extra de S.O.: Instalar libs para o PostgreSQL rodar liso
RUN apt-get update && \
    apt-get install -y --no-install-recommends libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Passo: Instale as Dependências
# Copiamos o requirements primeiro para ser rápido
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o resto do código (app.py, pasta db, etc)
COPY . .

# Expõe a porta definida no roteiro
EXPOSE 8002

# Passo: Inicie o Serviço
# Exatamente como no texto: gunicorn bindando na porta 8002 e chamando app:app
CMD ["gunicorn", "--bind", "0.0.0.0:8002", "app:app"]