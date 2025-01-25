extends CharacterBody2D

@export var speed = 300
@onready var sprite : Sprite2D
@onready var animation_player = $AnimationPlayer

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

# Falta agregar la logica para que haga el spin
#func _input(event):
	#if event.is_action_pressed("spin"):
		#sprite.play("spin") 
	#else:
		#sprite.play("idle")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Idle":
		animation_player.play("Idle")
