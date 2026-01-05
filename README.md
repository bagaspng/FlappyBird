# 🐦 FlappyBird - Godot Engine Game

> Recreasi klasik game FlappyBird yang dibuat menggunakan Godot Engine 4.2 dengan GDScript untuk pembelajaran game development

[![GDScript](https://img.shields.io/badge/GDScript-100%25-478cbf? style=flat-square&logo=godot-engine&logoColor=white)](https://github.com/bagaspng/FlappyBird)
[![Godot Engine](https://img.shields.io/badge/Godot-4.2-blue?style=flat-square&logo=godot-engine&logoColor=white)](https://godotengine.org/)
[![Game Development](https://img.shields.io/badge/Category-Game%20Development-success?style=flat-square&logo=gamepad&logoColor=white)](https://github.com/bagaspng/FlappyBird)
[![Mobile Game](https://img.shields.io/badge/Platform-Mobile%20Ready-orange?style=flat-square&logo=android&logoColor=white)](https://github.com/bagaspng/FlappyBird)
[![License](https://img.shields.io/badge/License-MIT-blue. svg?style=flat-square)](LICENSE)

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

### 🐦 **Bird Controller**

```gdscript
# Core bird mechanics
extends CharacterBody2D

@export var gravity = 1500
@export var jump_force = -400

func _physics_process(delta):
    # Apply gravity
    velocity. y += gravity * delta
    
    # Handle flap input
    if Input. is_action_just_pressed("flap"):
        velocity.y = jump_force
    
    # Move bird
    move_and_slide()
```

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

### 📐 **Procedural Pipe Generation**

```gdscript
# Infinite pipe spawning system
signal next_pipe(distance:  int)

func spawn_pipe():
    var pipe_scene = preload("res://scenes/Pipe.tscn")
    var new_pipe = pipe_scene.instantiate()
    
    # Random gap positioning
    var gap_y = randf_range(-200, 200)
    new_pipe.position = Vector2(spawn_x, gap_y)
    
    add_child(new_pipe)
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

## 🔍 Code Analysis

### 📄 **Main Game Controller**

```gdscript name=main. gd url=https://github.com/bagaspng/FlappyBird/blob/main/main.gd
extends Node

signal next_pipe(distance: int)

@export var camera_speed: int = 400

# Finite State Machine
enum State { IDLE, PLAYING, DEAD }
var current_state = State.IDLE

# Game variables
var score = 0
var day_bg = load("res://assets/sprites/background_day. png")

func _ready():
    # Initialize game components
    $Flash/ColorRect.hide()
    $Player.z_index = -2
    $Player.start($StartLocation.position)
    set_state(State. IDLE)

func _process(delta):
    # State machine processing
    match current_state:
        State.IDLE: 
            pass  # Waiting for input
        State. PLAYING:
            update_game(delta)
        State.DEAD: 
            pass  # Game over state

func update_game(delta):
    # Core game loop
    # Move camera and player horizontally
    $Camera2D.position += Vector2.RIGHT * camera_speed * delta
    $Player.position += Vector2.RIGHT * camera_speed * delta
    
    # Spawn ground tiles
    if ! $Player.is_dead:
        $ground_spawner.spawn()
```

### 🎮 **Input & Control System**

```gdscript
func _input(event):
    """Handle user input for game control"""
    
    if event. is_action_pressed("ui_accept"):
        match current_state: 
            State.IDLE:
                start_game()  # Begin gameplay
            State. PLAYING:
                # Handle flap input in bird script
                pass
            State. DEAD:
                restart_game()  # Restart after game over

func start_game():
    """Transition from IDLE to PLAYING state"""
    if current_state == State. IDLE:
        set_state(State.PLAYING)
```

### 💥 **Collision & Death System**

```gdscript
func on_dead_enter():
    """Handle player death sequence"""
    
    # Visual effects
    $Camera2D.add_trauma(1)        # Screen shake
    $Flash/ColorRect.show()        # Flash effect
    $Flash/AnimationPlayer.play("flash")
    
    # UI updates
    $HUD.show_game_over()
    
    # Stop gameplay
    $PipeSpawner/SpawnTimer.stop()
    camera_speed = 0

func _on_player_bird_collide():
    """Signal handler for bird collision"""
    if current_state == State.PLAYING:
        set_state(State. DEAD)
```

## 🎨 Asset Management

### 🖼️ **Sprite Assets**

| Asset Category | Files | Purpose |
|----------------|-------|---------|
| **Background** | `background_day.png` | Scrolling background scenery |
| **Characters** | `bird_orange_1.png` | Main player sprite |
| **Environment** | `ground.png`, `pipe_green_*.png` | Level geometry |
| **UI Elements** | `number_middle_0-9.png` | Score display numbers |

### 📱 **Mobile Optimization**

```gdscript
# Texture import settings for mobile
[remap]
importer="texture"
type="CompressedTexture2D"
uid="uid://bqlxwvv6448k0"
path="res://.godot/imported/bird_orange_1.png"

[deps]
source_file="res://assets/bird_orange_1.png"
dest_files=["res://.godot/imported/bird_orange_1.png"]

[params]
compress/mode=0           # No compression for pixel art
compress/high_quality=false
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false    # No mipmaps needed
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1
```

## 🎯 Game Design Patterns

### 🏗️ **Component-Based Architecture**

```gdscript
# Modular component system
class_name GameComponent
extends Node

# Base component interface
func initialize():
    pass

func update(delta):
    pass

func cleanup():
    pass

# Example:  ScoreComponent
class_name ScoreComponent
extends GameComponent

var current_score = 0
signal score_changed(new_score)

func add_score(points):
    current_score += points
    score_changed.emit(current_score)
```

### 🔄 **Observer Pattern for Events**

```gdscript
# Event-driven architecture
class_name EventBus
extends Node

# Game events
signal bird_died
signal score_increased(amount)
signal pipe_passed
signal game_started
signal game_restarted

# Usage across components
func _ready():
    EventBus.bird_died.connect(_on_bird_died)
    EventBus.score_increased.connect(_on_score_increased)
```

### 🎲 **Object Pooling for Performance**

```gdscript
# Efficient object management
class_name ObjectPool
extends Node

var pipe_pool = []
var ground_pool = []
var particle_pool = []

func get_pipe():
    if pipe_pool.size() > 0:
        return pipe_pool. pop_back()
    else:
        return create_new_pipe()

func return_pipe(pipe):
    pipe. reset()
    pipe_pool.push_back(pipe)
```

## 🎮 Advanced Features

### 📊 **Analytics & Telemetry**

```gdscript
class_name GameAnalytics
extends Node

var session_data = {
    "games_played": 0,
    "highest_score": 0,
    "total_playtime": 0,
    "average_score": 0
}

func record_game_session(score, duration):
    session_data.games_played += 1
    session_data.total_playtime += duration
    
    if score > session_data. highest_score: 
        session_data. highest_score = score
    
    update_average_score()
    save_analytics_data()
```

### 🎵 **Audio System**

```gdscript
class_name AudioManager
extends Node

@onready var sfx_player = $SFXPlayer
@onready var music_player = $MusicPlayer

var sound_effects = {
    "flap": preload("res://audio/flap.wav"),
    "hit": preload("res://audio/hit.wav"),
    "point": preload("res://audio/point.wav")
}

func play_sfx(sound_name:  String):
    if sound_name in sound_effects:
        sfx_player. stream = sound_effects[sound_name]
        sfx_player.play()
```

### 🌟 **Particle Effects**

```gdscript
class_name ParticleEffects
extends Node

func create_death_particles(position:  Vector2):
    var particles = preload("res://effects/DeathParticles. tscn").instantiate()
    get_tree().current_scene.add_child(particles)
    particles.global_position = position
    particles.emitting = true

func create_score_particles(position: Vector2):
    var particles = preload("res://effects/ScoreParticles. tscn").instantiate()
    get_tree().current_scene.add_child(particles)
    particles.global_position = position
    particles.emitting = true
```

## 🏆 Game Balancing & Tuning

### ⚖️ **Physics Parameters**

```gdscript
# Carefully tuned physics values
const GRAVITY = 1500          # Downward acceleration
const JUMP_FORCE = -400       # Upward velocity on flap
const MAX_FALL_SPEED = 600    # Terminal velocity
const HORIZONTAL_SPEED = 400   # Scrolling speed

# Difficulty progression
func get_pipe_gap_size(score: int) -> float:
    var base_gap = 200. 0
    var min_gap = 120.0
    var reduction_rate = 2.0
    
    var current_gap = base_gap - (score * reduction_rate)
    return max(current_gap, min_gap)
```

### 🎯 **Collision Tuning**

```gdscript
# Precise collision shapes
func setup_bird_collision():
    var collision_shape = CircleShape2D. new()
    collision_shape.radius = 12.0  # Slightly smaller than sprite
    
    var collision_body = CollisionShape2D. new()
    collision_body.shape = collision_shape
    add_child(collision_body)

# Forgiving collision detection
func check_collision_with_grace_period():
    if grace_timer > 0:
        grace_timer -= get_process_delta_time()
        return false  # Ignore collisions during grace period
    
    return collision_detected
```

## 📱 Mobile Development

### 📲 **Touch Controls**

```gdscript
func _unhandled_input(event):
    """Handle touch input for mobile devices"""
    
    if event is InputEventScreenTouch:
        if event.pressed:
            handle_touch_input()
    
    elif event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            handle_touch_input()

func handle_touch_input():
    match current_state:
        State.IDLE: 
            start_game()
        State.PLAYING: 
            bird.flap()
        State.DEAD:
            restart_game()
```

### 📺 **Responsive UI**

```gdscript
func _ready():
    # Adapt to different screen sizes
    adapt_ui_to_screen_size()

func adapt_ui_to_screen_size():
    var screen_size = get_viewport().get_visible_rect().size
    var scale_factor = screen_size.y / 612.0  # Base height
    
    # Scale UI elements
    $HUD. scale = Vector2.ONE * scale_factor
    $GameOverScreen.scale = Vector2.ONE * scale_factor
```

## 🐛 Troubleshooting

### ❓ **Common Issues**

**Q: Game runs too fast/slow on different devices? **
```gdscript
# Use delta time for consistent gameplay
func _process(delta):
    # Always multiply movement by delta
    position += velocity * delta
    
    # Use physics process for physics-based movement
func _physics_process(delta):
    velocity. y += gravity * delta
    move_and_slide()
```

**Q: Bird passes through pipes sometimes?**
```gdscript
# Ensure proper collision detection
func _physics_process(delta):
    # Use move_and_slide() for robust collision
    var collision = move_and_slide()
    
    # Check for collisions after movement
    for i in get_slide_collision_count():
        var collision_obj = get_slide_collision(i)
        handle_collision(collision_obj)
```

**Q: Performance issues on mobile?**
```gdscript
# Optimize for mobile performance
func optimize_for_mobile():
    # Use object pooling
    setup_object_pools()
    
    # Limit particle systems
    $ParticleSystem.amount = 50  # Reduce particle count
    
    # Use compressed textures
    # Set in import settings: compress/mode=2
```

**Q: Audio doesn't play on some devices?**
```gdscript
# Handle audio compatibility
func _ready():
    # Check audio capabilities
    if AudioServer.get_output_device_count() > 0:
        initialize_audio()
    else: 
        disable_audio_features()

func initialize_audio():
    # Set appropriate audio settings
    AudioServer.set_bus_volume_db(0, -10)  # Master volume
```

## 🚀 Extensions & Improvements

### 🔮 **Planned Features**

#### **Gameplay Enhancements**
- [ ] **Power-ups System** - Shields, slow-motion, double points
- [ ] **Multiple Bird Types** - Different abilities and appearances
- [ ] **Day/Night Cycle** - Dynamic background changes
- [ ] **Weather Effects** - Rain, wind affecting gameplay
- [ ] **Boss Battles** - Special challenging sections

#### **Technical Improvements**
```gdscript
# Advanced features roadmap
class_name AdvancedFlappyBird: 
    
    # Procedural level generation
    func generate_themed_levels():
        var themes = ["forest", "desert", "underwater", "space"]
        return create_level_with_theme(themes. pick_random())
    
    # Machine learning AI
    func train_ai_player():
        var neural_network = NeuralNetwork.new()
        return neural_network.train_on_gameplay_data()
    
    # Multiplayer support
    func setup_multiplayer():
        var multiplayer_peer = ENetMultiplayerPeer.new()
        return multiplayer_peer.create_server(7000, 4)
```

#### **Social Features**
- [ ] **Leaderboards** - Global and friends scoring
- [ ] **Achievements** - Unlock system with rewards
- [ ] **Replay System** - Record and share best runs
- [ ] **Social Sharing** - Screenshot sharing integration

### 🎨 **Visual Improvements**

```gdscript
# Enhanced visual effects
class_name VisualEffectsManager:
    
    func create_trail_effect():
        var trail = Line2D.new()
        trail.width = 3.0
        trail.default_color = Color. ORANGE
        return trail
    
    func add_parallax_background():
        var parallax = ParallaxBackground.new()
        var layers = create_background_layers()
        for layer in layers: 
            parallax.add_child(layer)
        return parallax
    
    func create_dynamic_lighting():
        var light = Light2D.new()
        light.texture = preload("res://effects/LightTexture.png")
        light.energy = 0.8
        return light
```

## 🎓 Learning Resources

### 📚 **Godot Engine Fundamentals**

1. **Scene System** - Understanding nodes and scenes
2. **GDScript Basics** - Syntax, variables, functions
3. **Physics System** - RigidBody2D vs CharacterBody2D
4. **Signal System** - Event-driven programming
5. **Animation System** - AnimationPlayer and Tween

### 🎮 **Game Development Concepts**

```gdscript
# Key concepts demonstrated in this project
class_name GameDevConcepts:
    
    # 1. Game States Management
    func finite_state_machine_example():
        """FSM pattern for game flow control"""
        pass
    
    # 2. Object Pooling
    func performance_optimization():
        """Efficient memory management"""
        pass
    
    # 3. Collision Detection
    func physics_interaction():
        """Robust collision systems"""
        pass
    
    # 4. Procedural Generation
    func infinite_level_design():
        """Dynamic content creation"""
        pass
```

### 🏗️ **Architecture Patterns**

```gdscript
# Professional game development patterns
class_name ArchitecturePatterns:
    
    # Singleton pattern for global access
    class_name GameManager:
        extends Node
        
        static var instance: GameManager
        
        func _ready():
            instance = self
    
    # Command pattern for input handling
    class_name InputCommand:
        func execute():
            pass
        
        func undo():
            pass
    
    # Factory pattern for object creation
    class_name EntityFactory:
        func create_bird() -> Bird:
            return Bird.new()
        
        func create_pipe() -> Pipe:
            return Pipe.new()
```

## 🤝 Contributing

Contributions are welcome! Here's how to contribute:

### 🔄 **Development Setup**

```bash
# Requirements
# - Godot Engine 4.2+
# - Git

# Fork and clone
git clone https://github.com/your-username/FlappyBird.git
cd FlappyBird

# Open in Godot
# Import project. godot in Godot Engine
```

### 📋 **Contribution Guidelines**

```gdscript
# Code style guidelines
# 1. Use snake_case for variables and functions
var player_score = 0

func calculate_high_score():
    pass

# 2. Use PascalCase for classes
class_name BirdController
extends CharacterBody2D

# 3. Add comprehensive comments
# This function handles the bird's flapping mechanism
func handle_flap_input():
    if Input.is_action_just_pressed("flap"):
        apply_jump_force()

# 4. Use type hints where possible
func move_bird(delta: float) -> void:
    position += velocity * delta
```

### 🧪 **Testing Guidelines**

```gdscript
# Example test structure
class_name TestBirdPhysics
extends GutTest

func test_bird_applies_gravity():
    var bird = Bird.new()
    var initial_velocity = bird.velocity. y
    
    bird._physics_process(1.0)  # 1 second
    
    assert_gt(bird.velocity. y, initial_velocity, "Bird should fall due to gravity")

func test_bird_flap_mechanics():
    var bird = Bird.new()
    
    bird. flap()
    
    assert_lt(bird.velocity. y, 0, "Bird should move upward after flap")
```

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software")... 
```

## 👨‍💻 Author

**Bagas Pangestu** ([@bagaspng](https://github.com/bagaspng))

- 📧 Email: bagaspangestu0407@gmail.com
- 💼 LinkedIn: [Bagas Pangestu](https://linkedin.com/in/bagaspng)
- 🌐 Portfolio: [bagaspng.dev](https://bagaspng.dev)
- 🎓 Expertise: Game Development, Godot Engine, GDScript Programming

## 🙏 Acknowledgments

- **Godot Community** - For the amazing open-source game engine
- **Original FlappyBird** - Dong Nguyen for the iconic game design
- **Game Assets** - Community contributors for sprites and resources
- **Open Source Game Dev** - For inspiration and learning resources

## 📚 References

### 🎮 **Game Development Resources**
- [Godot Engine Documentation](https://docs.godotengine.org/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [Game Programming Patterns](https://gameprogrammingpatterns.com/)

### 🎯 **FlappyBird Game Analysis**
- [Game Design Analysis](https://www.gamasutra.com/blogs/analysis/flappy-bird)
- [Physics-Based Game Development](https://docs.godotengine.org/en/stable/tutorials/physics/)

### 📱 **Mobile Game Development**
- [Godot Mobile Development Guide](https://docs.godotengine. org/en/stable/tutorials/platform/mobile/)
- [Touch Input Handling](https://docs.godotengine.org/en/stable/tutorials/inputs/input_examples.html)

## 📞 Support

Need help? Contact us: 

- 📖 **Documentation**: [Project Wiki](https://github.com/bagaspng/FlappyBird/wiki)
- 🐛 **Issues**: [Report Bugs](https://github.com/bagaspng/FlappyBird/issues)
- 💬 **Discussions**: [Q&A Forum](https://github.com/bagaspng/FlappyBird/discussions)
- 📧 **Email**: bagaspangestu0407@gmail.com

---

<div align="center">

**🐦 Soar High with Game Development!  🎮**

[![GitHub stars](https://img.shields.io/github/stars/bagaspng/FlappyBird?style=social)](https://github.com/bagaspng/FlappyBird/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/bagaspng/FlappyBird?style=social)](https://github.com/bagaspng/FlappyBird/network/members)

**Made with ❤️ for the Game Development Community**

</div>
