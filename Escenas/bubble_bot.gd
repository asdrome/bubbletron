extends CharacterBody2D

@export var speed = 300
var sprite : AnimatedSprite2D

func _ready() -> void:
	sprite = $AnimatedSprite2D
	
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
		sprite.play("spin") 
	else:
		sprite.play("idle")
