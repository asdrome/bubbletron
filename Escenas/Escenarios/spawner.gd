extends Node2D

signal enemy_died(points)

@export var enemy_scenes: Array[PackedScene] = [] # Lista de escenas de enemigos
@export var spawn_radius_min: float = 200.0   # Distancia mínima al jugador
@export var spawn_radius_max: float = 600.0   # Distancia máxima al jugador
@export var spawn_interval: float = 1.5       # Tiempo entre spawn
@export var max_enemies: int = 15             # Límite de enemigos en la escena

var player: CharacterBody2D  # Referencia al jugador
var screen_size: Vector2  # Tamaño de la pantalla
var enemies_spawned: Array[Node2D] = []  # Lista de enemigos activos

func _ready():
	# Obtener referencia al jugador
	player = get_tree().get_first_node_in_group("Jugador")
	if not player:
		printerr("No se encontró un nodo en el grupo 'Jugador'")
		return

	# Obtener tamaño de la pantalla
	screen_size = get_viewport_rect().size

	# Iniciar el spawn de enemigos
	_spawn_timer()

func _spawn_timer():
	# Crear un temporizador para spawnear enemigos periódicamente
	var timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.autostart = true
	timer.timeout.connect(_spawn_enemy)
	add_child(timer)

func _spawn_enemy():
	if not player or enemy_scenes.is_empty():
		return
	
	# No spawnear si ya alcanzamos el límite de enemigos
	if enemies_spawned.size() >= max_enemies:
		return
	
	# Seleccionar un enemigo aleatorio de la lista
	var enemy_scene = enemy_scenes[randi() % enemy_scenes.size()]
	var enemy_instance = enemy_scene.instantiate()

	# Generar una posición aleatoria fuera de la pantalla
	var spawn_position = _get_spawn_position()
	enemy_instance.global_position = spawn_position

	# Agregarlo a la lista de enemigos activos
	enemies_spawned.append(enemy_instance)

	# Detectar cuando el enemigo es eliminado
	enemy_instance.tree_exited.connect(func(): 
		enemy_died.emit(enemy_instance.POINTS_VALUE)
		enemies_spawned.erase(enemy_instance))

	# Agregar el enemigo a la escena
	get_parent().add_child(enemy_instance)

func _get_spawn_position() -> Vector2:
	var side = randi() % 2  # 0 = Izquierda, 1 = Derecha
	var offset = randf_range(spawn_radius_min, spawn_radius_max)

	# Definir la parte inferior de la pantalla como el área válida de spawn
	var min_y = player.global_position.y  # Mitad de la pantalla (línea base)
	var max_y = player.global_position.y + screen_size.y / 2  # Parte inferior

	match side:
		0:  # Izquierda
			return Vector2(player.global_position.x - screen_size.x / 2 - offset, 
						   randf_range(min_y, max_y))
		1:  # Derecha
			return Vector2(player.global_position.x + screen_size.x / 2 + offset, 
						   randf_range(min_y, max_y))

	return player.global_position  # Fallback en caso de error (no debería ocurrir)

func add_enemy_scene(new_enemy_scene: PackedScene):
	if new_enemy_scene and not enemy_scenes.has(new_enemy_scene):
		enemy_scenes.append(new_enemy_scene)

func remove_enemy_scene(enemy_scene: PackedScene):
	enemy_scenes.erase(enemy_scene)
