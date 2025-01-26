extends Area2D

@export var speed = 200
@export var movement_change_interval = 0.3  # Tiempo entre cambios de dirección
@export var random_factor = 0.5  # Intensidad de los movimientos aleatorios

@onready var sprite : Sprite2D
@onready var animation_player = $AnimationPlayer

const EXPLOSION = preload("res://Escenas/Personajes/Explosion.tscn")
var movement_vector : Vector2 = Vector2.LEFT
var time_since_last_change = 0.0

func _ready() -> void:
	sprite = $Sprite2D
	animation_player.play("Attack")

func _process(delta: float) -> void:
	# Actualizar el tiempo transcurrido
	time_since_last_change += delta

	# Cambiar dirección de movimiento aleatoriamente a intervalos
	if time_since_last_change >= movement_change_interval:
		movement_vector = Vector2(
			lerp(-1, 1, randf()) * random_factor,  # Movimiento horizontal
			lerp(-1, 1, randf()) * random_factor   # Movimiento vertical
		).normalized()
		time_since_last_change = 0.0

	# Aplicar movimiento
	translate(movement_vector * speed * delta)

	# Añadir oscilación a la posición en Y para mayor realismo
	position.y += sin(position.x * 0.1) * 2

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	animation_player.play("Attack")



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("burbuja"):
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		add_sibling(explosion)
		queue_free()
