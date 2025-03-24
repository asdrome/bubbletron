extends CharacterBody2D

signal has_died
signal was_hit(damage)

@export var speed = 300
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var hitbox : Area2D = $HitBox  # Nodo de la hitbox

const MAX_HEALTH = 100
var health = MAX_HEALTH

const PROJECTILE = preload("res://Escenas/Personajes/disparo_burbuja.tscn")

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction.x < 0:
		sprite.flip_h = true
	elif input_direction.x > 0:
		sprite.flip_h = false
	
	velocity = input_direction * speed
	
func _process(_delta: float) -> void:
	if !animation_player.is_playing(): 
		animation_player.play("Idle")
	

func _physics_process(_delta):
	get_input()
	move_and_slide()

func _input(event):
	if event.is_action_pressed("spin"):
		animation_player.play("Spin")
	elif event.is_action_pressed("shoot") and (animation_player.current_animation != "Spin"):
		var new_projectile = PROJECTILE.instantiate()
		
		# Determinar la dirección del proyectil
		if velocity == Vector2.ZERO:
			# Si el personaje no se mueve, usar dirección basada en flip_h 
			new_projectile.movement_vector = Vector2.LEFT if sprite.flip_h else Vector2.RIGHT
		else:
			new_projectile.movement_vector = velocity.normalized()
		
		# Posición inicial del proyectil
		new_projectile.global_position = global_position
		add_sibling(new_projectile)
		animation_player.play("Shoot")
	
	# TEMPORAL - REMOVE ASAP
	elif event.is_action_pressed("debug_self_hit"):
		take_damage(1)
	elif event.is_action_pressed("debug_self_kill"):
		take_damage(100)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		has_died.emit()
		queue_free()

func take_damage(damage):
	var prev_hp = health
	health -= damage
	
	if health <= 0.0:
		die()
		
	elif prev_hp != health:
		was_hit.emit(damage)
		animation_player.play("Hit")
		


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemigos"):
		take_damage(5)
	if area.is_in_group("Proyectiles"):
		take_damage(1)

## Mata al personaje
func die() -> void:
	set_physics_process(false)
	set_process(false)
	#  La liberación de memoria y la señal se procesan despues de la animación
	animation_player.play("Death")
