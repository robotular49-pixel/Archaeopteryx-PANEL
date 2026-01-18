# 🚀 Quick Start Guide

Panduan cepat untuk menjalankan Portal Aplikasi Terpadu dalam 5 menit!

## ⚡ Cara Tercepat

### Opsi 1: Jalankan Fish Quiz Saja (Tanpa Docker)

Jika Anda hanya ingin main quiz:

```bash
# Buka file langsung di browser
cd www
open indonesian-fish-quiz.html
```

Atau double-click file `www/indonesian-fish-quiz.html` di file explorer.

### Opsi 2: Jalankan Semua (Dengan Docker)

Untuk menjalankan Pterodactyl Panel + Fish Quiz:

```bash
# 1. Edit konfigurasi
nano docker-compose.yml
# Ubah MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD, dan APP_URL

# 2. Jalankan deployment script
./deploy.sh

# Atau manual:
docker-compose up -d
```

**Selesai!** Akses di browser:
- `http://localhost` - Portal utama
- `http://localhost/panel` - Pterodactyl Panel
- Klik card "Tebak Ikan Indonesia" untuk main quiz

## 📋 Checklist Setup

### Untuk Production:

- [ ] Ubah password database di `docker-compose.yml`
- [ ] Set `APP_URL` dengan domain Anda
- [ ] Konfigurasi email di `docker-compose.yml`
- [ ] Setup SSL/TLS (uncomment `LE_EMAIL`)
- [ ] Backup database secara berkala
- [ ] Monitor logs: `docker-compose logs -f`

### Untuk Development/Testing:

- [ ] Pastikan Docker terinstal
- [ ] Port 80 dan 443 tidak digunakan
- [ ] Jalankan `docker-compose up -d`
- [ ] Cek status: `docker-compose ps`

## 🎮 Main Fish Quiz

1. Buka browser ke `http://localhost`
2. Klik card **"Tebak Ikan Indonesia"**
3. Klik tombol **"Mulai Bermain"**
4. Jawab 10 pertanyaan tentang ikan Indonesia
5. Lihat skor akhir Anda!

## 🛠️ Command Berguna

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# Restart services
docker-compose restart

# Lihat logs
docker-compose logs -f

# Status containers
docker-compose ps

# Akses shell container
docker-compose exec panel sh
```

## 🆘 Troubleshooting Cepat

**Port sudah digunakan?**
```bash
# Ubah di docker-compose.yml:
ports:
  - "8080:80"   # Ganti 80 dengan 8080
  - "8443:443"  # Ganti 443 dengan 8443
```

**Database error?**
```bash
# Hapus data lama dan mulai fresh
sudo rm -rf /srv/pterodactyl/database/*
docker-compose up -d
```

**Quiz tidak muncul?**
```bash
# Buka langsung file HTML
cd www
python3 -m http.server 8000
# Buka http://localhost:8000/indonesian-fish-quiz.html
```

## 📱 Akses dari HP/Tablet

1. Cek IP komputer Anda: `ip addr` atau `ifconfig`
2. Buka browser di HP: `http://[IP-KOMPUTER]`
3. Contoh: `http://192.168.1.100`

## 💡 Tips

- **First Time Setup**: Pterodactyl Panel perlu setup admin account pertama kali
- **Fish Quiz**: Bisa dimainkan offline, tidak perlu internet
- **Backup**: Database ada di `/srv/pterodactyl/database`
- **Logs**: Selalu cek logs jika ada masalah: `docker-compose logs -f`

## 🎯 Target Audience

- **Pterodactyl Panel**: Server admin, game server hosting
- **Fish Quiz**: Pelajar, guru, siapa saja yang ingin belajar tentang ikan Indonesia

## 📞 Butuh Bantuan?

- Lihat `README.md` untuk dokumentasi lengkap
- Lihat `QUIZ_README.md` untuk detail fish quiz
- Check logs: `docker-compose logs -f`
- Docker docs: https://docs.docker.com/

---

**Selamat mencoba! 🎉**
