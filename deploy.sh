#!/bin/bash

# Script deployment untuk Portal Aplikasi Terpadu
# Author: Auto-generated
# Description: Deploy Pterodactyl Panel + Fish Quiz Application

set -e

echo "🚀 Portal Aplikasi Terpadu - Deployment Script"
echo "=============================================="
echo ""

# Warna untuk output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function untuk print dengan warna
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "ℹ $1"
}

# Cek Docker
echo "📦 Checking prerequisites..."
if ! command -v docker &> /dev/null; then
    print_error "Docker tidak terinstal!"
    echo "Install Docker: https://docs.docker.com/get-docker/"
    exit 1
fi
print_success "Docker terinstal"

# Cek Docker Compose
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose tidak terinstal!"
    echo "Install Docker Compose: https://docs.docker.com/compose/install/"
    exit 1
fi
print_success "Docker Compose terinstal"

# Cek apakah sudah mengubah konfigurasi
if grep -q "CHANGE_ME" docker-compose.yml; then
    print_warning "Password database masih default!"
    echo ""
    echo "PENTING: Edit docker-compose.yml dan ubah:"
    echo "  - MYSQL_PASSWORD"
    echo "  - MYSQL_ROOT_PASSWORD"
    echo "  - APP_URL"
    echo ""
    read -p "Sudah mengubah konfigurasi? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Deployment dibatalkan. Silakan edit docker-compose.yml terlebih dahulu."
        exit 1
    fi
fi

# Buat direktori yang diperlukan
echo ""
echo "📁 Creating required directories..."
sudo mkdir -p /srv/pterodactyl/{database,var,nginx,certs,logs}
print_success "Direktori dibuat"

# Set permission untuk www
echo ""
echo "🔐 Setting permissions..."
chmod -R 755 www/
print_success "Permissions set"

# Stop container lama jika ada
echo ""
echo "🛑 Stopping old containers..."
docker-compose down 2>/dev/null || true
print_success "Old containers stopped"

# Pull image terbaru
echo ""
echo "📥 Pulling Docker images..."
docker-compose pull
print_success "Images pulled"

# Start containers
echo ""
echo "🚀 Starting containers..."
docker-compose up -d
print_success "Containers started"

# Tunggu services siap
echo ""
echo "⏳ Waiting for services to be ready..."
sleep 10

# Cek status
echo ""
echo "📊 Container status:"
docker-compose ps

# Print informasi akses
echo ""
echo "=============================================="
print_success "Deployment berhasil!"
echo "=============================================="
echo ""
echo "📍 Akses aplikasi di:"
echo "   🏠 Portal Utama: http://localhost"
echo "   ⚙️  Pterodactyl Panel: http://localhost/panel"
echo "   🐟 Fish Quiz: http://localhost (klik card Fish Quiz)"
echo ""
echo "📊 Management commands:"
echo "   docker-compose logs -f         # Lihat logs semua services"
echo "   docker-compose logs -f panel   # Lihat logs panel saja"
echo "   docker-compose ps              # Status containers"
echo "   docker-compose down            # Stop semua containers"
echo "   docker-compose restart         # Restart semua containers"
echo ""
echo "🔧 Next steps:"
echo "   1. Akses panel untuk setup awal"
echo "   2. Konfigurasi SSL/TLS jika diperlukan"
echo "   3. Main Fish Quiz untuk testing"
echo ""
print_warning "Jangan lupa backup database secara berkala!"
echo ""
