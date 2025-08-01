# Web Hosting Script - HTML ke Domain Otomatis

Script ini digunakan untuk meng-hosting website HTML statis ke domain Anda menggunakan NGINX dan SSL otomatis (Let's Encrypt).

## Fitur

- Install NGINX dan Certbot otomatis
- Buat direktori berdasarkan nama domain
- Salin file HTML ke direktori web
- Buat konfigurasi NGINX
- Pasang SSL otomatis menggunakan Let's Encrypt

## Cara Pakai

1. Upload file `host-html.sh` ke server kamu
2. Upload file HTML kamu (misalnya `Web Utama.html`) ke `/root` di VPS kamu
3. Jalankan script:

```bash
bash host-html.sh agasoffc.my.id
```

> Ganti `agasoffc.my.id` dengan domain kamu sendiri

## Catatan

- Pastikan domain sudah diarahkan ke IP VPS via A record
- Cloudflare: pastikan menggunakan DNS Only (disable proxy)

## Author

Agas
