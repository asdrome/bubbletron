extends Node2D

signal game_over

const RATAS = preload("res://Escenas/Personajes/rata.tscn")
@onready var spawner = $Spawner

func _ready() -> void:
	spawner.add_enemy_scene(RATAS)

func _on_bubble_bot_has_died() -> void:
	game_over.emit()
