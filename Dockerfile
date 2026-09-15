# Temel imaj olarak Debian'ı kullan
FROM debian:stable-slim

# Python ve pip'i yükle
RUN apt-get update && \
  apt-get install -y python3 python3-pip python3-venv && \
  apt-get clean

# Çalışma dizinini ayarla
WORKDIR /app

# Sanal ortam oluştur
RUN python3 -m venv venv

# requirements.txt dosyasını kopyala
COPY requirements.txt .

# Sanal ortamda pip'i kullanarak paketleri yükle
RUN ./venv/bin/pip install --no-cache-dir -r requirements.txt

# .env dosyasını kopyala
COPY .env .

# Uygulama dosyalarını kopyala
COPY . .

# Uygulamayı çalıştır
EXPOSE 8080
CMD ["./venv/bin/uvicorn", "main:app", "--host=0.0.0.0", "--port=8080"]
