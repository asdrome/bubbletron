extends CanvasLayer

# Variables para controlar el audio
@export var musica: AudioStreamPlayer
@export var efectos: AudioStreamPlayer

# Referencias a las barras de progreso
#onready var barra_musica = $Panel/VBoxContainer/HBoxContainer/TextureProgress
#onready var barra_efectos = $Panel/VBoxContainer/HBoxContainer2/TextureProgress

#func _ready():
	# Inicializar las barras con el volumen actual
#	barra_musica.value = musica.volume_db
#	barra_efectos.value = efectos.volume_db

# Conecta los botones de la interfaz

@onready var panel = $Panel
@onready var boton_quit_game = $Panel/VFlowContainer/Quit
@onready var boton_back_to_menu = $Panel/VFlowContainer/BackMenu
@onready var boton_reanudar = $Panel/VFlowContainer/Continue

func _ready():
	# Ocultar el menú de pausa al inicio
	visible = false  
	set_process_input(true)  # Asegura que el _input siga funcionando cuando está pausado

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa"):
		visible = !visible
		get_tree().paused = visible
		set_process_input(true)  # Mantener la entrada activa

# Función para ajustar el volumen de la música
func ajustar_musica(value):
	musica.volume_db = value

# Función para ajustar el volumen de los efectos
func ajustar_efectos(value):
	efectos.volume_db = value

	
func _focus_start() -> void:
	boton_reanudar.grab_focus.call_deferred()

func _on_panel_draw() -> void:
	_focus_start()


func _on_continue_pressed() -> void:
	get_tree().paused = false
	visible = false  # Oculta la escena de pausa


func _on_back_menu_pressed() -> void:
	visible = false
	get_parent()._emit_back_to_menu()


func _on_quit_pressed() -> void:
	# Implementa lógica para guardar el progreso y cerrar la aplicación
	get_tree().quit()
