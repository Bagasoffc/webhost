#!/bin/bash

DOMAIN=$1

if [ -z "$DOMAIN" ]; then
  echo "Contoh: bash host-html.sh agasoffc.my.id"
  exit 1
fi

echo "[1/5] Update dan install NGINX + Certbot..."
apt update -y && apt install nginx certbot python3-certbot-nginx -y

echo "[2/5] Siapkan direktori web untuk $DOMAIN..."
mkdir -p /var/www/$DOMAIN

# Cek apakah file HTML ada di /root
if [ ! -f "/root/Web Utama.html" ]; then
  echo "ERROR: File 'Web Utama.html' tidak ditemukan di /root"
  echo "Silakan upload file HTML ke /root terlebih dahulu."
  exit 1
fi

cp "/root/Web Utama.html" /var/www/$DOMAIN/index.html
chown -R www-data:www-data /var/www/$DOMAIN
chmod -R 755 /var/www/$DOMAIN

echo "[3/5] Buat konfigurasi NGINX untuk $DOMAIN..."
cat > /etc/nginx/sites-available/$DOMAIN <<EOF
server {
    listen 80;
    server_name $DOMAIN;

    root /var/www/$DOMAIN;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx

echo "[4/5] Pasang SSL dari Let's Encrypt..."
certbot --nginx -d $DOMAIN --non-interactive --agree-tos -m admin@$DOMAIN --redirect

echo "[5/5] Selesai! Website kamu sudah online di: https://$DOMAIN"
