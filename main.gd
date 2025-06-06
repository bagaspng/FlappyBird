extends Node

signal next_pipe(distance: int)

@export var camera_speed: int = 400

# FSM State Enum
enum State { IDLE, PLAYING, DEAD }
var current_state = State.IDLE

# Score
var score = 0

# Background
var day_bg = load("res://assets/sprites/background_day.png") 

func _ready():
	$Flash/ColorRect.hide()

	# Z-index player dan posisi awal
	$Player.z_index = -2
	$Player.start($StartLocation.position)

	# Mulai dari state IDLE
	set_state(State.IDLE)

func _process(delta):
	match current_state:
		State.IDLE:
			pass # Belum jalan, menunggu input atau trigger
		State.PLAYING:
			update_game(delta)
		State.DEAD:
			pass # Tidak bergerak setelah mati

func update_game(delta):
	# Gerakkan kamera dan player secara horizontal
	$Camera2D.position += Vector2.RIGHT * camera_speed * delta
	$Player.position += Vector2.RIGHT * camera_speed * delta
	
	# Spawn ground kalau belum mati
	if !$Player.is_dead:
		$ground_spawner.spawn()

# --- FSM Transition Functions ---
func set_state(new_state):
	current_state = new_state
	match current_state:
		State.IDLE:
			$PipeSpawner/SpawnTimer.stop()
			camera_speed = 0
		State.PLAYING:
			$PipeSpawner/SpawnTimer.start()
			camera_speed = 400
		State.DEAD:
			on_dead_enter()

func start_game():
	if current_state == State.IDLE:
		set_state(State.PLAYING)

func on_dead_enter():
	$Camera2D.add_trauma(1)
	$Flash/ColorRect.show()
	$Flash/AnimationPlayer.play("flash")
	$HUD.show_game_over()
	$PipeSpawner/SpawnTimer.stop()
	camera_speed = 0

# --- Signals dari Player Node ---
func _on_player_on_player_ready():
	var start_pipe = $Player.position.x + (get_viewport().size.x * 2)
	next_pipe.emit(start_pipe)

func _on_player_bird_collide():
	if current_state == State.PLAYING:
		set_state(State.DEAD)

# --- Contoh Input untuk mulai permainan ---
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if current_state == State.IDLE:
			start_game()

