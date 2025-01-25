extends Node2D

signal game_over

func _on_bubble_bot_has_died() -> void:
	game_over.emit()
