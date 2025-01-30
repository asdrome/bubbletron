extends Level2D

const MnMs = preload("res://Escenas/Personajes/eminen.tscn")
const RATAS = preload("res://Escenas/Personajes/rata.tscn")
const MOSCAS = preload("res://Escenas/Personajes/mosca.tscn")
@onready var spawner = $Spawner
@onready var player = $BubbleBot

func _ready() -> void:
	player.position = starting_position
	spawner.add_enemy_scene(MnMs)
	# spawner.add_enemy_scene(RATAS)
	# spawner.add_enemy_scene(MOSCAS)

func _on_bubble_bot_has_died() -> void:
	game_over.emit()
	
