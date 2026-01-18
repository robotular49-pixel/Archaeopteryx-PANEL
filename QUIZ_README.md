# 🐟 Indonesian Fish Quiz Game

## Overview
An interactive, single-page HTML application that tests your knowledge of Indonesian river fish species. The game features beautiful animations, engaging gameplay, and educational content about fish found in Indonesia's major rivers.

## Features

### Core Gameplay
- **10 Fish Species**: Learn about iconic Indonesian river fish including Arowana, Catfish, Snakehead, Carp, Giant Snakehead, Pangasius, Royal Knifefish, Asian Redtail Catfish, Giant Gourami, and Hampala Barb
- **Interactive Quiz**: Multiple choice questions with 4 options each
- **Animated Fish**: CSS-based swimming animations with bubbles and seaweed
- **Score Tracking**: Real-time tracking of correct/incorrect answers
- **Progress Bar**: Visual indicator showing quiz progress
- **Instant Feedback**: Color-coded responses (green for correct, red for incorrect)

### Educational Content
- **Bilingual Names**: Both Indonesian and English names for each fish
- **River Information**: Geographic location where each fish is found
- **Fun Facts**: Interesting trivia about each fish species
- **Visual Learning**: Emoji-based fish representations with smooth animations

### User Experience
- **Responsive Design**: Works seamlessly on desktop, tablet, and mobile devices
- **Tropical Theme**: Beautiful aquatic-themed UI with gradient backgrounds
- **Smooth Animations**: CSS animations for swimming, bubbles, seaweed swaying
- **Results Screen**: Final score with performance-based messages
- **Replay Option**: Restart the game at any time

## How to Use

### Opening the Game
Simply open `indonesian-fish-quiz.html` in any modern web browser:
- Double-click the file
- Or right-click and select "Open with" → your preferred browser
- Or drag and drop the file into an open browser window

### Playing the Game
1. Click **"Mulai Bermain"** (Start Playing) on the welcome screen
2. Watch the animated fish in the aquarium
3. Read the question: "Ikan apakah ini?" (What fish is this?)
4. Click one of the four answer choices
5. Get instant feedback with:
   - Correct/incorrect indicator
   - Fish name in both languages
   - River location
   - Interesting fun fact
6. Click **"Ikan Berikutnya"** (Next Fish) to continue
7. Complete all 10 questions
8. View your final score and performance message
9. Click **"Main Lagi"** (Play Again) to restart

### Scoring System
- Each correct answer adds 1 point
- Track your progress: Correct answers / Incorrect answers / Total answered
- Final results include:
  - Your score out of 10
  - Performance message based on percentage
  - Trophy emoji based on achievement level

## Fish Species Included

1. **Ikan Arwana** (Asian Arowana) - Sungai Kapuas, Kalimantan
2. **Ikan Lele** (Catfish) - Sungai Citarum, Jawa Barat
3. **Ikan Gabus** (Snakehead Fish) - Sungai Barito, Kalimantan Selatan
4. **Ikan Mas** (Common Carp) - Sungai Brantas, Jawa Timur
5. **Ikan Toman** (Giant Snakehead) - Sungai Mahakam, Kalimantan Timur
6. **Ikan Patin** (Pangasius) - Sungai Musi, Sumatera Selatan
7. **Ikan Belida** (Royal Knifefish) - Sungai Kampar, Riau
8. **Ikan Baung** (Asian Redtail Catfish) - Sungai Kapuas, Kalimantan Barat
9. **Ikan Gurame** (Giant Gourami) - Sungai Ciliwung, Jakarta
10. **Ikan Jelawat** (Hampala Barb) - Sungai Mahakam, Kalimantan Timur

## Technical Details

### Technologies Used
- **HTML5**: Semantic structure
- **CSS3**: Animations, gradients, flexbox, grid
- **Vanilla JavaScript**: Game logic, no external dependencies

### Browser Compatibility
Works on all modern browsers:
- Chrome/Edge (recommended)
- Firefox
- Safari
- Opera

### File Structure
- Single self-contained HTML file
- Embedded CSS in `<style>` tags
- Embedded JavaScript in `<script>` tags
- No external dependencies or internet connection required

### Animations
- **Fish Swimming**: Smooth horizontal and vertical movement
- **Bubbles**: Rising animation with varying sizes and speeds
- **Seaweed**: Gentle swaying effect
- **Button Interactions**: Hover effects, pulse animations, shake effects
- **Transitions**: Smooth screen changes and feedback displays

## Performance Metrics

### Performance Levels
- 🏆 **100%**: "Sempurna! Anda adalah ahli ikan Indonesia!" (Perfect! You are an Indonesian fish expert!)
- 🥇 **80-99%**: "Luar Biasa! Pengetahuan Anda sangat baik!" (Excellent! Your knowledge is very good!)
- 🥈 **60-79%**: "Bagus! Anda cukup mengenal ikan Indonesia!" (Good! You know Indonesian fish quite well!)
- 🥉 **40-59%**: "Lumayan! Masih ada ruang untuk belajar lebih banyak!" (Not bad! There's still room to learn more!)
- 🎯 **0-39%**: "Jangan menyerah! Coba lagi dan pelajari lebih banyak!" (Don't give up! Try again and learn more!)

## Customization

To add more fish or modify the game:

1. Open `indonesian-fish-quiz.html` in a text editor
2. Find the `fishDatabase` array in the JavaScript section
3. Add new fish objects following this structure:
```javascript
{
    id: 11,
    nameId: "Nama Ikan",
    nameEn: "English Name",
    emoji: "🐠",
    river: "Nama Sungai, Lokasi",
    funFact: "Fakta menarik tentang ikan ini...",
    choices: ["Pilihan 1", "Pilihan 2", "Pilihan 3", "Pilihan 4"]
}
```

## Educational Value

This quiz helps players:
- Learn about Indonesian biodiversity
- Understand river ecosystems
- Recognize different fish species
- Discover geographic distribution of fish
- Engage with conservation awareness

## License
Free to use and modify for educational purposes.

## Credits
Created as an educational tool to promote awareness of Indonesian river fish species and biodiversity.

---

**Selamat bermain dan belajar tentang ikan-ikan Indonesia!** 🐟🎮
**Have fun playing and learning about Indonesian fish!** 🐟🎮
