extends Area2D

@export var speed = 1000
@export var movement_vector : Vector2 = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	translate(movement_vector * speed * delta)
