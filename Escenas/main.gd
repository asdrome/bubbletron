extends Node

var starting_scene = preload("res://Escenas/Escenarios/Dia.tscn")

@onready var current_scene = $Menu

func _ready() -> void:
	pass
	

func _on_menu_quit() -> void:
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()


func _on_menu_start_credits() -> void:
	pass # Replace with function body.


func _on_menu_start_game() -> void:
	current_scene = starting_scene.instantiate()
	get_tree().root.add_child(current_scene)
	$Menu.visible = false
	current_scene.game_over.connect(_on_game_over)
	
func _on_game_over() -> void:
	current_scene.queue_free()
	current_scene = $Menu
	$Menu.visible = true
	
