extends CharacterBody2D

@export var speed = 300
@onready var sprite : Sprite2D
@onready var animation_player = $AnimationPlayer

const PROJECTILE = preload("res://Escenas/disparo_burbuja.tscn")

func _ready() -> void:
	sprite = $Sprite2D
	animation_player.play("Idle")
	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
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
		new_projectile.movement_vector = velocity.normalized()
		new_projectile.global_position = global_position
		add_sibling(new_projectile)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("Idle")

