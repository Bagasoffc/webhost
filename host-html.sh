#!/bin/bash

DOMAIN=$1

if [ -z "$DOMAIN" ]; then
  echo "Contoh: bash host-html-online.sh agasoffc.my.id"
  exit 1
fi

echo "[1/5] Install NGINX & Certbot..."
apt update -y && apt install nginx certbot python3-certbot-nginx wget -y

echo "[2/5] Siapkan direktori /var/www/$DOMAIN ..."
mkdir -p /var/www/$DOMAIN

echo "[3/5] Ambil HTML dari GitHub..."
wget -O /var/www/$DOMAIN/index.html https://raw.githubusercontent.com/agasidp/webhost/main/index.html

chown -R www-data:www-data /var/www/$DOMAIN
chmod -R 755 /var/www/$DOMAIN

echo "[4/5] Buat konfigurasi NGINX..."
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

echo "[5/5] Pasang SSL dari Let's Encrypt..."
certbot --nginx -d $DOMAIN --non-interactive --agree-tos -m admin@$DOMAIN --redirect

echo "✅ Website kamu aktif di: https://$DOMAIN"
