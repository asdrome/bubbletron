extends Control

signal start_game
signal start_credits
signal quit

func _on_jugar_pressed() -> void:
	start_game.emit()


func _on_creditos_pressed() -> void:
	start_credits.emit()


func _on_salir_pressed() -> void:
	quit.emit()
