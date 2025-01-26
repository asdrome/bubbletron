extends Area2D

@export var speed = 200
@export var movement_vector : Vector2 = Vector2.LEFT

@onready var sprite : Sprite2D
@onready var animation_player = $AnimationPlayer

const EXPLOSION = preload("res://Escenas/Personajes/Explosion.tscn")

func _ready() -> void:
	sprite = $Sprite2D
	animation_player.play("Attack")

func _process(delta: float) -> void:
	translate(movement_vector * speed * delta)
	position.y += sin(position.x * delta) * 4

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	animation_player.play("Attack")


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("burbuja"):
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		add_sibling(explosion)
		queue_free()
