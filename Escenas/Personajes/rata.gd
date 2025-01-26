extends CharacterBody2D
@export var speed = 100
@export var movement_vector : Vector2 = Vector2.LEFT

@onready var sprite : Sprite2D
@onready var animation_player = $AnimationPlayer

const EXPLOSION = preload("res://Escenas/Personajes/Explosion.tscn")

func _ready() -> void:
	sprite = $Sprite2D
	animation_player.play("Walk")

func _process(_delta: float) -> void:
	var players = get_tree().get_nodes_in_group("Jugador")
	if !players.is_empty():
		var player = players[0]
		var distance = player.global_position - global_position
		var direction = distance.normalized()
		if direction.x < 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		velocity = direction * speed 
	
	move_and_slide()
		

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		queue_free()
	else:
		animation_player.play("Walk")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("burbuja"):
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		add_sibling(explosion)
		queue_free()
