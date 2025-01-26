extends CharacterBody2D

@export var speed = 200
@export var movement_vector: Vector2 = Vector2.LEFT
@export var shoot_cooldown = 1.5  # Tiempo en segundos entre disparos

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var attack_area: Area2D = $Area2D  # Referencia al Area2D
@onready var timer: Timer = $Timer  # Timer para manejar el cooldown de disparos

const PROJECTIL = preload("res://Escenas/Personajes/disparo_mosca.tscn")
const EXPLOSION = preload("res://Escenas/Personajes/Explosion.tscn")

func _ready() -> void:
	# Configurar animación inicial y timer
	animation_player.play("fly")
	timer.wait_time = shoot_cooldown
	timer.stop()

func _process(_delta: float) -> void:
	# Mover la mosca hacia el jugador si existe
	var players = get_tree().get_nodes_in_group("Jugador")
	if !players.is_empty():
		var player = players[0]
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed

		# Ajustar la dirección del sprite
		sprite.flip_h = direction.x > 0

	move_and_slide()

func _on_area_2d_body_entered(body: Node) -> void:
	# Cuando el jugador entre en el área de disparo
	if body.is_in_group("Jugador"):
		if !timer.is_stopped():
			return  # Evitar disparar si el cooldown no ha terminado
		shoot_at_target(body)

func _on_timer_timeout() -> void:
	# Reinicia el timer para disparar nuevamente
	timer.stop()

func shoot_at_target(target: Node) -> void:
	# Crear y disparar el proyectil
	var new_projectile = PROJECTIL.instantiate()
	var direction = (target.global_position - global_position).normalized()

	# Configurar dirección y posición inicial del proyectil
	new_projectile.movement_vector = direction
	new_projectile.global_position = global_position
	add_sibling(new_projectile)

	# Reproducir animación de disparo y configurar cooldown
	animation_player.play("disparo_mosca")
	timer.start()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		queue_free()
	else:
		animation_player.play("fly")

func _on_area_2d_area_entered(area: Area2D) -> void:
	# Detectar colisiones con objetos como burbujas
	if area.is_in_group("burbuja"):
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		add_sibling(explosion)
		queue_free()
