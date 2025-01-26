extends AnimatedSprite2D

func  _ready() -> void:
	await animation_finished
	queue_free()

func _on_animation_finished() -> void:
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	queue_free()
