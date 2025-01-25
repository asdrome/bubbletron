extends CharacterBody2D

@export var speed = 300
@onready var sprite : Sprite2D
@onready var animation_player = $AnimationPlayer
@onready  var animation_tree: AnimationTree = $AnimationTree

var input_direction: Vector2 = Vector2.ZERO

const PROJECTILE = preload("res://Escenas/disparo_burbuja.tscn")

func _ready() -> void:
	sprite = $Sprite2D
	#animation_player.play("Idle")
	animation_tree.active = true
	
func _process(_delta: float) -> void:
	update_animation_parameters()
	
func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction.x < 0:
		sprite.flip_h = true
	elif input_direction.x > 0:
		sprite.flip_h = false
	
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()

func _input(event):
	if event.is_action_pressed("spin"):
		animation_player.play("spin")
	elif event.is_action_pressed("shoot"):
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

func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		
	if Input.is_action_just_pressed("spin"):
		animation_tree["parameters/conditions/spin"] = true
	else:
		animation_tree["parameters/conditions/spin"] = false
		
	animation_tree["parameters/Idle/blend_position"] = input_direction
	animation_tree["parameters/Spin/blend_position"] = input_direction
	animation_tree["parameters/Walk/blend_position"] = input_direction
	
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	animation_player.play("Idle")
