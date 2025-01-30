extends Node

var starting_scene = preload("res://Escenas/Escenarios/Dia.tscn")
var credits_scene = preload("res://Escenas/IU/creditos.tscn")
var current_scene

@onready var menu = $Menu
@onready var pausa = preload("res://Escenas/IU/pausa.tscn").instantiate()

func _ready() -> void:
	current_scene = menu
	menu.visible = true
	add_child(pausa)
	pausa.visible = false  # Oculta la pausa inicialmente
	
	pausa.connect("reanudar", Callable(self, "_on_reanudar_juego"))
	pausa.connect("reiniciar", Callable(self, "_on_reiniciar_nivel"))
	pausa.connect("salir", Callable(self, "_on_salir_menu"))
	
	#var player = "res://Escenas/Escenarios/Dia.tscn"
	#var ui = "res://Escenas/IU/interfaz.tscn"
	
	# Conecta la señal `was_hit` del jugador a la función que actualiza la barra
	#player.connect("was_hit", Callable(ui, "update_health"))

func _on_menu_quit() -> void:
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()


func _on_menu_start_credits() -> void:
	menu.visible = false
	current_scene = credits_scene.instantiate()
	add_child(current_scene)
	current_scene.connect("back_to_menu", _on_back_to_menu)
	
func _on_back_to_menu() -> void:
	current_scene.queue_free()  # Eliminar la escena de créditos
	current_scene = menu  # Restaurar el menú principal
	menu.visible = true  # Asegurar que el menú se muestre nuevamente
	

func _on_menu_start_game() -> void:
	menu.visible = false
	current_scene = starting_scene.instantiate()
	get_tree().root.add_child(current_scene)
	current_scene.game_over.connect(_on_game_over)
	
func _on_game_over() -> void:
	current_scene.queue_free()
	current_scene = menu
	menu.visible = true
	
	
func _input(event):
	# Detectar si el jugador presiona "ESC" para pausar o reanudar el juego
	if event.is_action_pressed("ui_cancel"):
		if not get_tree().paused:
			print("Pausando nivel")
			activar_pausa()
		else:
			print("Reanudando nivel")
			desactivar_pausa()

func activar_pausa():
	pausa.visible = true
	get_tree().paused = true

func desactivar_pausa():
	pausa.visible = false
	get_tree().paused = false

# Señal: Reanudar el juego
func _on_reanudar_juego():
	desactivar_pausa()

# Señal: Reiniciar el nivel
func _on_reiniciar_nivel():
	current_scene.queue_free()
	current_scene = starting_scene.instantiate()
	get_tree().root.add_child(current_scene)
	desactivar_pausa()

# Señal: Salir al menú principal
func _on_salir_menu():
	current_scene.queue_free()
	current_scene = $Menu
	$Menu.visible = true
	desactivar_pausa()
