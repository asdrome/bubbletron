extends CharacterBody2D
@export var speed = 100
@export var movement_vector : Vector2 = Vector2.LEFT

@onready var sprite : Sprite2D = $RataSprite
@onready var animation_player = $AnimationPlayer

func _process(_delta: float) -> void:
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
	velocity = Vector2.ZERO  # Detener el movimiento
	set_process_mode(Node.PROCESS_MODE_DISABLED)
	set_physics_process(false)  # Opcional: Deshabilita la física del enemigo
	animation_player.play("Death")
	await get_tree().create_timer(1).timeout
	queue_free()	

func _on_hit_box_area_entered(_area: Area2D) -> void:
	animation_player.play("Attack")
