extends Area2D
@export var speed = 20
@export var movement_vector : Vector2 = Vector2.LEFT

@onready var sprite : Sprite2D
@onready var animation_player = $AnimationPlayer

const EXPLOSION = preload("res://Escenas/Personajes/Explosion.tscn")

func _ready() -> void:
	sprite = $Sprite2D
	animation_player.play("Walk")

func _process(delta: float) -> void:
	translate(movement_vector * speed * delta)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("burbuja"):
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		add_sibling(explosion)
		queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		queue_free()
	else:
		animation_player.play("Walk")
	animation_player.play("Idle")
