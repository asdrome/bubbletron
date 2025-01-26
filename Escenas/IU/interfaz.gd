extends Control

@export var max_health = 100
@export var health = max_health

@onready var health_bar = $MarginContainer/VBoxContainer/HBoxContainer/TextureProgressBar

func update_health(value: int):
	health_bar.value = value
	update_health_color(value, max_health)

func update_health_color(value: int, max_value: int):
	var percentage = float(value) / float(max_value)
	
	# Define colores según el porcentaje (puedes ajustarlos según tu diseño)
	if percentage > 0.5:
		health_bar.modulate = Color(0.2, 1.0, 0.2)  # Verde
	elif percentage > 0.2:
		health_bar.modulate = Color(1.0, 1.0, 0.2)  # Amarillo
	else:
		health_bar.modulate = Color(1.0, 0.2, 0.2)  # Rojo
