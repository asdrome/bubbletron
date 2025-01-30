extends CharacterBody2D

@export var speed = 90
@export var movement_vector : Vector2 = Vector2.LEFT

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _process(_delta: float) -> void:
	if !animation_player.is_playing(): 
		animation_player.play("Idle")

func _physics_process(_delta: float) -> void:
	var players = get_tree().get_nodes_in_group("Jugador")
	if !players.is_empty():
		var player = players[0]
		var distance = global_position.distance_to(player.global_position)
		speed = distance/2
		var direction = (player.global_position - global_position).normalized()
		if direction.x < 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		velocity = direction * speed
	
	move_and_slide()	
	

func _on_hurt_box_area_entered(_area: Area2D) -> void:
	set_physics_process(false)
	animation_player.play("Death")
	
func _on_attack_box_area_entered(_area: Area2D) -> void:
	if !(animation_player.current_animation == "Death"):
		animation_player.play("Punch")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		queue_free()
