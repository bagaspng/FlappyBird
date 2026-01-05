# 🐦 FlappyBird - Godot Engine Game

> Recreasi klasik game FlappyBird yang dibuat menggunakan Godot Engine 4.2 dengan GDScript untuk pembelajaran game development

[![GDScript](https://img.shields.io/badge/GDScript-100%25-478cbf?style=flat-square&logo=godot-engine&logoColor=white)](https://github.com/bagaspng/FlappyBird)
[![Godot Engine](https://img.shields.io/badge/Godot-4.2-blue?style=flat-square&logo=godot-engine&logoColor=white)](https://godotengine.org/)
[![Game Development](https://img.shields.io/badge/Category-Game%20Development-success?style=flat-square&logo=gamepad&logoColor=white)](https://github.com/bagaspng/FlappyBird)

## 📋 Deskripsi

FlappyBird adalah recreasi dari game mobile viral yang dibuat menggunakan **Godot Engine 4.2**. Proyek ini mendemonstrasikan implementasi game mechanics fundamental seperti collision detection, finite state machine, physics-based movement, dan procedural generation dalam game development.

## ✨ Fitur Game

### 🎮 **Core Gameplay Features**
- 🐦 **Bird Physics** - Realistic gravity dan flap mechanics
- 🎯 **Collision Detection** - Precise collision dengan pipes dan ground
- 📊 **Score System** - Real-time scoring dengan visual feedback
- 🎨 **Smooth Animations** - Fluid bird movement dan wing flapping

### 🏗️ **Technical Features**
- 🔄 **Finite State Machine** - IDLE, PLAYING, DEAD states
- 📐 **Procedural Generation** - Infinite scrolling pipes dan ground
- 📱 **Mobile Optimized** - Touch controls dan portrait orientation
- ⚡ **Performance Optimized** - Efficient rendering dan memory management

### 🎨 **Visual & Audio Features**
- 🌅 **Day Theme** - Beautiful day background scenery  
- 🎭 **Visual Effects** - Screen shake, flash effects, trauma system
- 🔢 **Score Display** - Animated number sprites (0-9)
- 🎯 **Game Over Screen** - Polished UI dengan restart functionality

## 🎯 Game Mechanics


### 🔄 **Finite State Machine**

```gdscript
# Game states implementation
enum State { IDLE, PLAYING, DEAD }
var current_state = State.IDLE

func set_state(new_state):
    current_state = new_state
    match current_state:
        State. IDLE:
            # Pause all gameplay
            camera_speed = 0
            $PipeSpawner/SpawnTimer.stop()
        State.PLAYING:
            # Active gameplay
            camera_speed = 400
            $PipeSpawner/SpawnTimer.start()
        State. DEAD:
            # Game over state
            on_dead_enter()
```

## 🚀 Instalasi & Setup

### 📦 **Prerequisites**

```bash
# Download Godot Engine 4.2+
# https://godotengine.org/download
```

### 🎮 **Quick Start**

1. **Clone Repository**
   ```bash
   git clone https://github.com/bagaspng/FlappyBird.git
   cd FlappyBird
   ```

2. **Open in Godot**
   ```bash
   # Buka Godot Engine
   # File > Import > Select project. godot
   # Atau drag folder project ke Godot Project Manager
   ```

3. **Run Game**
   ```bash
   # Press F5 dalam Godot Editor
   # Atau klik "Play" button di toolbar
   ```

### ⚙️ **Project Configuration**

```godot
[application]
config/name="Flap Test"
run/main_scene="res://scene/node_2d. tscn"
config/features=PackedStringArray("4.2", "GL Compatibility")

[display]
window/size/viewport_width=342    # Mobile portrait width
window/size/viewport_height=612   # Mobile portrait height

[rendering]
textures/canvas_textures/default_texture_filter=0  # Pixel perfect
renderer/rendering_method="gl_compatibility"       # Mobile compatibility
```

## 🏗️ Struktur Project

```
FlappyBird/
│
├── 📂 assets/                    # Game assets
│   ├── 🖼️ background_day.png     # Background scenery
│   ├── 🐦 bird_orange_1.png      # Bird sprite
│   ├── 🌱 ground. png             # Ground texture
│   ├── 🔢 number_middle_0-9.png  # Score number sprites
│   └── 🟢 pipe_green_*. png       # Pipe sprites (top/bottom)
│
├── 📂 scene/                     # Godot scene files
│   ├── 🐦 bird.tscn             # Bird character scene
│   └── 🌍 node_2d.tscn          # Main game scene
│
├── 📄 main.gd                   # Main game logic script
├── ⚙️ project.godot             # Godot project configuration
├── 🚫 . gitignore               # Git ignore rules
└── 📖 README.md                # Documentation (this file)
```

## 🎨 Asset Management

### 🖼️ **Sprite Assets**

| Asset Category | Files | Purpose |
|----------------|-------|---------|
| **Background** | `background_day.png` | Scrolling background scenery |
| **Characters** | `bird_orange_1.png` | Main player sprite |
| **Environment** | `ground.png`, `pipe_green_*.png` | Level geometry |
| **UI Elements** | `number_middle_0-9.png` | Score display numbers |


## 👨‍💻 Author

**Bagas Pangestu** ([@bagaspng](https://github.com/bagaspng))


---

<div align="center">

**🐦 Soar High with Game Development!  🎮**

[![GitHub stars](https://img.shields.io/github/stars/bagaspng/FlappyBird?style=social)](https://github.com/bagaspng/FlappyBird/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/bagaspng/FlappyBird?style=social)](https://github.com/bagaspng/FlappyBird/network/members)

**Made with ❤️ for the Game Development Community**

</div>
