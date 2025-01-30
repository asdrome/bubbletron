extends Control

signal back_to_menu

func _on_button_pressed() -> void:
	$Back.connect("pressed", Callable(self, "_on_button_pressed"))
	emit_signal("back_to_menu")
	queue_free()
