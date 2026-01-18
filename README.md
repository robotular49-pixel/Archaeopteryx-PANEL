# 🚀 Portal Aplikasi Terpadu

Platform terintegrasi yang menggabungkan **Pterodactyl Panel** (cPanel gratis) dengan **aplikasi edukatif** dalam satu infrastruktur Docker.

## 📦 Aplikasi yang Tersedia

### 1. ⚙️ Pterodactyl Panel
Control panel open-source untuk mengelola game server dan aplikasi dengan mudah.

**Fitur:**
- Manajemen multi-server untuk berbagai game (Minecraft, ARK, CS:GO, dll)
- Interface modern berbasis web
- Database MariaDB 10.5
- Redis caching untuk performa optimal
- SSL/TLS support dengan Let's Encrypt
- SMTP email configuration

### 2. 🐟 Tebak Ikan Indonesia
Game quiz edukatif interaktif untuk mengenal ikan-ikan sungai Indonesia.

**Fitur:**
- 10 spesies ikan dari sungai-sungai besar Indonesia
- Animasi CSS yang smooth dan menarik
- Fakta menarik tentang setiap ikan
- Sistem scoring dan progress tracking
- Responsive design untuk mobile dan desktop
- Bilingual (Indonesia & English)

## 🛠️ Stack Teknologi

**Backend & Infrastructure:**
- Docker Compose
- MariaDB 10.5
- Redis Alpine
- PHP/Laravel (Pterodactyl)
- Nginx Web Server

**Frontend:**
- HTML5
- CSS3 dengan Animations
- Vanilla JavaScript
- Responsive Design

## 🚀 Cara Menjalankan

### Prasyarat
- Docker & Docker Compose terinstal
- Port 80 dan 443 tersedia

### Instalasi

1. **Clone repository ini:**
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Konfigurasi environment:**
   Edit file `docker-compose.yml` dan ubah:
   - `MYSQL_PASSWORD` dan `MYSQL_ROOT_PASSWORD`
   - `APP_URL` sesuai dengan domain Anda
   - `APP_SERVICE_AUTHOR` dengan email Anda
   - Konfigurasi SMTP jika diperlukan

3. **Jalankan aplikasi:**
   ```bash
   docker-compose up -d
   ```

4. **Akses aplikasi:**
   - Portal utama: `http://localhost` atau `http://your-domain`
   - Pterodactyl Panel: `http://localhost/panel`
   - Fish Quiz: `http://localhost/fish-quiz` atau buka langsung `www/indonesian-fish-quiz.html`

### Standalone Fish Quiz

Game quiz bisa dijalankan tanpa Docker:
```bash
# Buka langsung di browser
open www/indonesian-fish-quiz.html
# atau
xdg-open www/indonesian-fish-quiz.html
```

## 📁 Struktur Direktori

```
.
├── docker-compose.yml      # Konfigurasi Docker Compose
├── nginx.conf             # Konfigurasi Nginx
├── README.md              # File ini
├── QUIZ_README.md         # Dokumentasi lengkap Fish Quiz
├── www/                   # Aplikasi web
│   ├── index.html         # Portal landing page
│   └── indonesian-fish-quiz.html  # Game quiz
└── .gitignore
```

## 🔧 Konfigurasi Lanjutan

### Database
Data database disimpan di: `/srv/pterodactyl/database`

### SSL/TLS
Untuk mengaktifkan Let's Encrypt:
1. Uncomment `LE_EMAIL` di `docker-compose.yml`
2. Masukkan email Anda
3. Restart container: `docker-compose restart panel`

### Custom Nginx
File konfigurasi nginx tersedia di: `/srv/pterodactyl/nginx/`

## 🎮 Menggunakan Fish Quiz

1. Klik tombol **"Mulai Bermain"**
2. Lihat ikan yang berenang dengan animasi
3. Pilih jawaban yang benar dari 4 pilihan
4. Dapatkan feedback langsung dan fakta menarik
5. Selesaikan 10 pertanyaan
6. Lihat skor akhir dan main lagi!

**Spesies ikan yang tersedia:**
- Ikan Arwana (Asian Arowana) - Sungai Kapuas
- Ikan Lele (Catfish) - Sungai Citarum
- Ikan Gabus (Snakehead) - Sungai Barito
- Ikan Mas (Common Carp) - Sungai Brantas
- Ikan Toman (Giant Snakehead) - Sungai Mahakam
- Ikan Patin (Pangasius) - Sungai Musi
- Ikan Belida (Royal Knifefish) - Sungai Kampar
- Ikan Baung (Asian Redtail Catfish) - Sungai Kapuas
- Ikan Gurame (Giant Gourami) - Sungai Ciliwung
- Ikan Jelawat (Hampala Barb) - Sungai Mahakam

## 📊 Monitoring

Untuk melihat logs:
```bash
# Semua logs
docker-compose logs -f

# Logs panel saja
docker-compose logs -f panel

# Logs database
docker-compose logs -f database
```

## 🛡️ Keamanan

- Ganti semua password default di `docker-compose.yml`
- Gunakan SSL/TLS untuk production
- Atur `TRUSTED_PROXIES` dengan benar
- Batasi akses database hanya dari container panel

## 🤝 Kontribusi

Untuk menambahkan ikan baru ke quiz:
1. Edit `www/indonesian-fish-quiz.html`
2. Tambahkan object baru ke array `fishDatabase`
3. Ikuti struktur yang sudah ada

## 📝 Lisensi

Proyek ini menggunakan:
- Pterodactyl Panel: MIT License
- Fish Quiz: Free untuk penggunaan edukatif

## 🆘 Troubleshooting

**Port sudah digunakan:**
```bash
# Cek port yang digunakan
sudo lsof -i :80
sudo lsof -i :443

# Atau ubah port di docker-compose.yml
ports:
  - "8080:80"
  - "8443:443"
```

**Database tidak terkoneksi:**
- Periksa password di environment variables
- Pastikan container database sudah running: `docker-compose ps`
- Cek logs: `docker-compose logs database`

**Fish Quiz tidak muncul:**
- Pastikan file ada di `www/indonesian-fish-quiz.html`
- Cek permission file: `chmod 644 www/*.html`
- Buka langsung file HTML di browser untuk testing

## 📞 Support

Untuk bantuan lebih lanjut:
- Pterodactyl Docs: https://pterodactyl.io/panel/1.0/getting_started.html
- Docker Docs: https://docs.docker.com/
- Lihat QUIZ_README.md untuk detail game quiz

---

**Dibuat dengan ❤️ untuk kemudahan dan pembelajaran**
