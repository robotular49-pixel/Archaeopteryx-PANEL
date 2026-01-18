#!/bin/bash

# Script testing untuk Portal Aplikasi
# Memeriksa apakah semua komponen berjalan dengan baik

set -e

echo "🧪 Testing Portal Aplikasi"
echo "========================="
echo ""

# Warna
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASSED=0
FAILED=0

test_pass() {
    echo -e "${GREEN}✓ PASS${NC}: $1"
    ((PASSED++))
}

test_fail() {
    echo -e "${RED}✗ FAIL${NC}: $1"
    ((FAILED++))
}

test_warn() {
    echo -e "${YELLOW}⚠ WARN${NC}: $1"
}

# Test 1: Cek file structure
echo "📁 Testing file structure..."
if [ -f "www/index.html" ]; then
    test_pass "index.html exists"
else
    test_fail "index.html not found"
fi

if [ -f "www/indonesian-fish-quiz.html" ]; then
    test_pass "indonesian-fish-quiz.html exists"
else
    test_fail "indonesian-fish-quiz.html not found"
fi

if [ -f "docker-compose.yml" ]; then
    test_pass "docker-compose.yml exists"
else
    test_fail "docker-compose.yml not found"
fi

# Test 2: Cek HTML validity (basic)
echo ""
echo "🔍 Testing HTML files..."
if grep -q "<!DOCTYPE html>" www/index.html; then
    test_pass "index.html has valid DOCTYPE"
else
    test_fail "index.html missing DOCTYPE"
fi

if grep -q "</html>" www/index.html; then
    test_pass "index.html properly closed"
else
    test_fail "index.html not properly closed"
fi

if grep -q "<!DOCTYPE html>" www/indonesian-fish-quiz.html; then
    test_pass "quiz.html has valid DOCTYPE"
else
    test_fail "quiz.html missing DOCTYPE"
fi

if grep -q "</html>" www/indonesian-fish-quiz.html; then
    test_pass "quiz.html properly closed"
else
    test_fail "quiz.html not properly closed"
fi

# Test 3: Cek JavaScript
echo ""
echo "🔧 Testing JavaScript..."
if grep -q "fishDatabase" www/indonesian-fish-quiz.html; then
    test_pass "Fish database found in quiz"
else
    test_fail "Fish database not found"
fi

if grep -q "function startGame" www/indonesian-fish-quiz.html; then
    test_pass "Game functions exist"
else
    test_fail "Game functions not found"
fi

# Test 4: Cek CSS animations
echo ""
echo "🎨 Testing CSS animations..."
if grep -q "@keyframes swim" www/indonesian-fish-quiz.html; then
    test_pass "Fish swim animation exists"
else
    test_fail "Swim animation not found"
fi

if grep -q "@keyframes rise" www/indonesian-fish-quiz.html; then
    test_pass "Bubble rise animation exists"
else
    test_fail "Bubble animation not found"
fi

# Test 5: Count fish in database
echo ""
echo "🐟 Testing fish database..."
FISH_COUNT=$(grep -o '"id":' www/indonesian-fish-quiz.html | wc -l)
if [ "$FISH_COUNT" -ge 10 ]; then
    test_pass "Fish database has $FISH_COUNT fish species (>= 10)"
else
    test_fail "Fish database only has $FISH_COUNT fish species (< 10)"
fi

# Test 6: Cek Docker Compose
echo ""
echo "🐳 Testing Docker configuration..."
if command -v docker &> /dev/null; then
    test_pass "Docker installed"
    
    if command -v docker-compose &> /dev/null; then
        test_pass "Docker Compose installed"
        
        # Validate docker-compose.yml
        if docker-compose config > /dev/null 2>&1; then
            test_pass "docker-compose.yml is valid"
        else
            test_fail "docker-compose.yml has errors"
        fi
    else
        test_warn "Docker Compose not installed (optional for quiz-only)"
    fi
else
    test_warn "Docker not installed (optional for quiz-only)"
fi

# Test 7: Cek required content
echo ""
echo "📝 Testing content..."
if grep -q "Pterodactyl" www/index.html; then
    test_pass "Pterodactyl panel referenced in index"
else
    test_fail "Pterodactyl not mentioned in index"
fi

if grep -q "Tebak Ikan" www/index.html; then
    test_pass "Fish quiz referenced in index"
else
    test_fail "Fish quiz not mentioned in index"
fi

# Test 8: Cek Indonesian content
echo ""
echo "🇮🇩 Testing Indonesian content..."
if grep -q "Sungai Kapuas\|Sungai Mahakam\|Sungai Barito" www/indonesian-fish-quiz.html; then
    test_pass "Indonesian rivers mentioned"
else
    test_fail "Indonesian rivers not found"
fi

if grep -q "Ikan Arwana\|Ikan Gabus\|Ikan Lele" www/indonesian-fish-quiz.html; then
    test_pass "Indonesian fish names found"
else
    test_fail "Indonesian fish names not found"
fi

# Test 9: Cek responsive design
echo ""
echo "📱 Testing responsive design..."
if grep -q "@media.*max-width" www/indonesian-fish-quiz.html; then
    test_pass "Mobile responsive CSS found"
else
    test_fail "No mobile responsive CSS"
fi

if grep -q "viewport" www/indonesian-fish-quiz.html; then
    test_pass "Viewport meta tag exists"
else
    test_fail "Viewport meta tag missing"
fi

# Test 10: File permissions
echo ""
echo "🔐 Testing permissions..."
if [ -r "www/index.html" ]; then
    test_pass "index.html is readable"
else
    test_fail "index.html not readable"
fi

if [ -r "www/indonesian-fish-quiz.html" ]; then
    test_pass "quiz.html is readable"
else
    test_fail "quiz.html not readable"
fi

# Summary
echo ""
echo "========================="
echo "📊 Test Summary"
echo "========================="
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 All tests passed!${NC}"
    echo "Aplikasi siap untuk deployment."
    exit 0
else
    echo -e "${RED}❌ Some tests failed.${NC}"
    echo "Periksa errors di atas dan perbaiki."
    exit 1
fi
