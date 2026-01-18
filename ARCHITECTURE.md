# 🏗️ Architecture Diagram - Portal Aplikasi Terpadu

## 📐 System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         BROWSER / CLIENT                         │
│                      http://localhost                            │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ↓
┌─────────────────────────────────────────────────────────────────┐
│                         NGINX (Port 80/443)                      │
│  ┌──────────────┬─────────────────┬─────────────────────────┐  │
│  │   Route: /   │  Route: /panel  │  Route: /fish-quiz      │  │
│  └──────┬───────┴────────┬────────┴──────────┬──────────────┘  │
└─────────┼────────────────┼───────────────────┼─────────────────┘
          │                │                   │
          ↓                ↓                   ↓
    ┌─────────┐    ┌──────────────┐    ┌──────────────┐
    │  Static │    │  Pterodactyl │    │  Fish Quiz   │
    │  Files  │    │    Panel     │    │   (Static)   │
    │  (www/) │    │  (Container) │    │     (www/)   │
    └─────────┘    └───────┬──────┘    └──────────────┘
                           │
                  ┌────────┴────────┐
                  │                 │
                  ↓                 ↓
           ┌────────────┐    ┌───────────┐
           │  MariaDB   │    │   Redis   │
           │  (10.5)    │    │  (Alpine) │
           │ Container  │    │ Container │
           └────────────┘    └───────────┘
```

## 🐳 Docker Compose Structure

```
docker-compose.yml
│
├── 📦 Service: database
│   ├── Image: mariadb:10.5
│   ├── Volume: /srv/pterodactyl/database
│   ├── Database: panel
│   └── User: pterodactyl
│
├── 📦 Service: cache
│   ├── Image: redis:alpine
│   └── Purpose: Caching, Sessions, Queue
│
└── 📦 Service: panel
    ├── Image: pterodactyl/panel:latest
    ├── Ports: 80, 443
    ├── Volumes:
    │   ├── /srv/pterodactyl/var → /app/var
    │   ├── /srv/pterodactyl/nginx → /etc/nginx/http.d
    │   ├── /srv/pterodactyl/certs → /etc/letsencrypt
    │   ├── /srv/pterodactyl/logs → /app/storage/logs
    │   └── ./www → /var/www/html  ⭐ (Integration point)
    └── Links: database, cache
```

## 📂 File System Structure

```
Host Machine
│
├── /home/user/project/
│   │
│   ├── docker-compose.yml          # Orchestration
│   ├── nginx.conf                  # Web server config
│   │
│   └── www/                        # ⭐ Mounted to container
│       ├── index.html              # Portal landing
│       ├── indonesian-fish-quiz.html
│       └── demo.html
│
└── /srv/pterodactyl/              # Persistent data
    ├── database/                   # MariaDB data
    ├── var/                        # Panel data
    ├── nginx/                      # Nginx configs
    ├── certs/                      # SSL certificates
    └── logs/                       # Application logs
```

## 🌐 Network Topology

```
┌─────────────────────────────────────────────────────────────┐
│               Docker Network: 172.20.0.0/16                 │
│                                                             │
│  ┌──────────────┐      ┌──────────────┐      ┌──────────┐ │
│  │   database   │◄─────┤    panel     │◄─────┤  cache   │ │
│  │  172.20.0.2  │      │  172.20.0.4  │      │172.20.0.3│ │
│  └──────────────┘      └──────┬───────┘      └──────────┘ │
│                               │                            │
└───────────────────────────────┼────────────────────────────┘
                                │
                                ↓
                        Host: 0.0.0.0:80
                        Host: 0.0.0.0:443
```

## 🔄 Request Flow

### Scenario 1: User Accesses Portal
```
1. User → http://localhost
2. Browser → Nginx (port 80)
3. Nginx → Static file: /var/www/html/index.html
4. Response → User sees portal with 2 cards
```

### Scenario 2: User Plays Fish Quiz
```
1. User clicks "Tebak Ikan Indonesia" card
2. Browser → http://localhost/indonesian-fish-quiz.html
3. Nginx → Static file: /var/www/html/indonesian-fish-quiz.html
4. Response → Fish quiz loads (no backend needed)
5. JavaScript runs in browser (client-side only)
```

### Scenario 3: User Accesses Panel
```
1. User clicks "Pterodactyl Panel" card
2. Browser → http://localhost/panel
3. Nginx → Proxy to panel container (port 8080)
4. Panel (Laravel) → Processes request
5. Panel → Queries MariaDB (if needed)
6. Panel → Uses Redis for cache/sessions
7. Response → Panel interface rendered
```

## 🎨 Application Layer

```
┌─────────────────────────────────────────────────────────────┐
│                     PRESENTATION LAYER                       │
├─────────────────────────────────────────────────────────────┤
│  Portal Landing (index.html)                                │
│  ├── Header: Title & Score                                  │
│  ├── Cards: 2 application cards                             │
│  ├── Info: Platform details                                 │
│  └── Footer: Credits                                        │
├─────────────────────────────────────────────────────────────┤
│  Fish Quiz (indonesian-fish-quiz.html)                      │
│  ├── Start Screen                                           │
│  ├── Game Screen                                            │
│  │   ├── Aquarium (CSS animations)                          │
│  │   ├── Question display                                   │
│  │   ├── Multiple choice buttons                            │
│  │   └── Progress bar                                       │
│  └── Results Screen                                         │
└─────────────────────────────────────────────────────────────┘
```

## 💾 Data Flow

### Fish Quiz (Client-Side Only)
```
fishDatabase (JavaScript Array)
          ↓
   shuffleArray()
          ↓
   Display Question
          ↓
   User Selects Answer
          ↓
   checkAnswer()
          ↓
   Update Score (in memory)
          ↓
   Show Feedback
          ↓
   Next Question / Show Results
```

### Pterodactyl Panel (Full Stack)
```
User Request
     ↓
Laravel Router
     ↓
Controller
     ↓
┌────┴─────┐
│          │
↓          ↓
Model    Cache (Redis)
↓
Database (MariaDB)
↓
Response (Blade Template)
↓
User Browser
```

## 🔐 Security Layers

```
┌─────────────────────────────────────────────────────────────┐
│ Layer 1: Network                                            │
│ ├── Docker internal network (172.20.0.0/16)                │
│ ├── Only panel exposed to host (80, 443)                   │
│ └── Database & Redis: internal only                        │
├─────────────────────────────────────────────────────────────┤
│ Layer 2: Web Server                                         │
│ ├── Nginx reverse proxy                                    │
│ ├── SSL/TLS support (Let's Encrypt)                        │
│ └── Trusted proxies configuration                          │
├─────────────────────────────────────────────────────────────┤
│ Layer 3: Application                                        │
│ ├── Panel: Laravel authentication                          │
│ ├── Panel: CSRF protection                                 │
│ ├── Panel: Password hashing                                │
│ └── Quiz: Client-side only (no data sent)                  │
├─────────────────────────────────────────────────────────────┤
│ Layer 4: Database                                           │
│ ├── Password protected                                     │
│ ├── Isolated network                                       │
│ └── Volume-mounted (persistent)                            │
└─────────────────────────────────────────────────────────────┘
```

## 🚀 Deployment Flow

```
Developer Machine
       ↓
   git clone
       ↓
Edit docker-compose.yml
(Set passwords, APP_URL)
       ↓
   ./deploy.sh
       ↓
┌──────────────────┐
│ Pre-flight Check │
│ ├── Docker       │
│ ├── Compose      │
│ └── Config       │
└────────┬─────────┘
         ↓
┌──────────────────┐
│  Create Dirs     │
│  /srv/pterodactyl│
└────────┬─────────┘
         ↓
┌──────────────────┐
│  Pull Images     │
│  ├── mariadb:10.5│
│  ├── redis:alpine│
│  └── panel:latest│
└────────┬─────────┘
         ↓
┌──────────────────┐
│  Start Services  │
│  docker-compose  │
│  up -d           │
└────────┬─────────┘
         ↓
┌──────────────────┐
│  Health Check    │
│  Wait for ready  │
└────────┬─────────┘
         ↓
    ✅ READY!
```

## 🧪 Testing Architecture

```
./test.sh
    ↓
┌───────────────────┐
│ File Structure    │
│ ├── index.html    │
│ ├── quiz.html     │
│ └── config files  │
└────────┬──────────┘
         ↓
┌───────────────────┐
│ HTML Validation   │
│ ├── DOCTYPE       │
│ └── Closing tags  │
└────────┬──────────┘
         ↓
┌───────────────────┐
│ JavaScript Check  │
│ ├── fishDatabase  │
│ └── Functions     │
└────────┬──────────┘
         ↓
┌───────────────────┐
│ CSS Animations    │
│ ├── @keyframes    │
│ └── Responsive    │
└────────┬──────────┘
         ↓
┌───────────────────┐
│ Content Check     │
│ ├── Fish names    │
│ └── River names   │
└────────┬──────────┘
         ↓
┌───────────────────┐
│ Docker Config     │
│ ├── YAML syntax   │
│ └── Validation    │
└────────┬──────────┘
         ↓
    📊 Report
    ✅ Pass / ❌ Fail
```

## 📊 Component Interaction Matrix

```
┌──────────┬────────┬─────────┬───────┬──────┬───────┐
│          │ Nginx  │  Panel  │ MariaDB│Redis │ www/  │
├──────────┼────────┼─────────┼───────┼──────┼───────┤
│ Nginx    │   -    │  Proxy  │   -   │  -   │ Serve │
│ Panel    │   ←    │    -    │ Query │Cache │   -   │
│ MariaDB  │   -    │   ←     │   -   │  -   │   -   │
│ Redis    │   -    │   ←     │   -   │  -   │   -   │
│ www/     │   ←    │    -    │   -   │  -   │   -   │
└──────────┴────────┴─────────┴───────┴──────┴───────┘

Legend:
  -      : No direct interaction
  Proxy  : Reverse proxy connection
  Query  : Database queries
  Cache  : Cache read/write
  Serve  : Static file serving
  ←      : Receives requests from
```

## 🎯 Integration Points

### Point 1: Volume Mount
```
Host: ./www/
  ↓ [Docker Volume]
Container: /var/www/html/
  ↓ [Nginx Config]
URL: http://localhost/
```

### Point 2: Nginx Routing
```
Request: /
  → index.html

Request: /panel
  → Proxy to panel:8080

Request: /fish-quiz
  → indonesian-fish-quiz.html
```

### Point 3: Docker Networking
```
Panel Container
  ↓ [Link]
Database Container (database:3306)
  ↓ [Link]
Cache Container (cache:6379)
```

## 🌟 Key Design Decisions

### 1. Static vs Dynamic
- **Portal & Quiz**: Static HTML (fast, no backend)
- **Panel**: Dynamic Laravel app (full features)

### 2. Separation of Concerns
- **Frontend**: www/ directory
- **Backend**: Panel container
- **Data**: Persistent volumes

### 3. Integration Method
- **Loose Coupling**: Apps independent
- **Portal**: Single entry point
- **Shared**: Only infrastructure (nginx, docker)

### 4. Deployment Strategy
- **All-in-one**: Single docker-compose.yml
- **Automated**: deploy.sh script
- **Flexible**: Can run quiz standalone

## 📈 Scalability Considerations

```
Current Setup (Single Host)
┌─────────────────────────────┐
│      Docker Host            │
│  ┌────┐ ┌────┐ ┌────┐      │
│  │DB  │ │Cache│ │Panel│     │
│  └────┘ └────┘ └────┘      │
└─────────────────────────────┘

Future Scaling (Multi-Host)
┌──────────┐  ┌──────────┐  ┌──────────┐
│ Web Tier │  │App Tier  │  │Data Tier │
│ ┌────┐   │  │ ┌────┐   │  │ ┌────┐   │
│ │Nginx│  │  │ │Panel│  │  │ │DB  │   │
│ └────┘   │  │ ├────┤   │  │ ├────┤   │
│ ┌────┐   │  │ │Panel│  │  │ │Cache│  │
│ │Nginx│  │  │ └────┘   │  │ └────┘   │
│ └────┘   │  │          │  │          │
└──────────┘  └──────────┘  └──────────┘
```

## 💡 Architecture Benefits

✅ **Modularity**: Each component independent  
✅ **Scalability**: Can scale components separately  
✅ **Maintainability**: Clear separation of concerns  
✅ **Flexibility**: Apps can run together or separately  
✅ **Performance**: Static files = fast, cached data = fast  
✅ **Security**: Network isolation, minimal exposure  
✅ **Simplicity**: Single command deployment  
✅ **Portability**: Docker = runs anywhere  

---

**Designed for**: Ease of use, education, and scalability  
**Built with**: Docker, Nginx, Laravel, Vanilla JavaScript  
**Architecture**: Microservices-inspired, containerized  

**🏗️ Clean, Simple, Effective Architecture**
