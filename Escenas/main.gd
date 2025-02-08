extends Node

var starting_level_scene = preload("res://Escenas/Escenarios/Dia.tscn")

@onready var menu = $Menu
@onready var level : Level2D

func _on_menu_start_game() -> void:
	_load_new_level(starting_level_scene.instantiate())
	menu.hide()

func _on_menu_quit() -> void:
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()

func _end_game() -> void:
	level.queue_free()	
	print(level)

func _show_menu() -> void:
	menu.show()

func _on_level_game_over() -> void:
	_end_game()
	_show_menu()
	
func _load_new_level(new_level : Level2D):
	level = new_level
	level.connect("game_over", _on_level_game_over)
	level.connect("back_to_menu", _on_level_back_to_menu)
	add_child(level)

func _on_level_back_to_menu() -> void:
	_end_game()
	_show_menu()
