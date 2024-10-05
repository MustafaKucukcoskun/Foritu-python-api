# Temel imaj olarak Debian'ı kullan
FROM debian:stable-slim

# Python ve pip'i yükle
RUN apt-get update && \
  apt-get install -y python3 python3-pip python3-venv && \
  apt-get clean

# Çalışma dizinini ayarla
WORKDIR /app

# requirements.txt dosyasını kopyala
COPY requirements.txt .

# .env dosyasını kopyala
COPY .env .

# Sanal ortam oluştur ve etkinleştir
RUN python3 -m venv venv

# Sanal ortamda pip'i kullanarak paketleri yükle
RUN ./venv/bin/pip install --no-cache-dir -r requirements.txt

# Uygulama dosyalarını kopyala
COPY . .

# Environment değişkenlerini ayarla
ENV SUPABASE_URL=https://kjoenbrfqxljeklnmbev.supabase.co
ENV SUPABASE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtqb2VuYnJmcXhsamVrbG5tYmV2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjUxMTIxMzAsImV4cCI6MjA0MDY4ODEzMH0.nHwB5kF4CybdoidcPTQZWd-vCHVgq4QTgXVPpRsC5Bo
ENV SUPABASE_BUCKET=qr_pdf

# Uygulamayı çalıştır
EXPOSE 8080
CMD ["./venv/bin/uvicorn", "main:app", "--host=0.0.0.0", "--port=8080"]
