extends CanvasLayer

signal reanudar
signal reiniciar
signal salir

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
@onready var boton_salir_menu = $Panel/VFlowContainer/Salir
@onready var boton_reiniciar = $Panel/VFlowContainer/Reiniciar
@onready var boton_reanudar = $Panel/VFlowContainer/Reanudar

func _ready():
	# Ocultar el menú de pausa al inicio
	panel.visible = false  
	set_process_input(true)  # Asegura que el _input siga funcionando cuando está pausado

	# Conectar señales de los botones
	boton_reanudar.pressed.connect(_on_reanudar_pressed)
	boton_reiniciar.pressed.connect(_on_reiniciar_pressed)
	boton_salir_menu.pressed.connect(_on_salir_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa"):
		panel.visible = !panel.visible
		get_tree().paused = panel.visible
		set_process_input(true)  # Mantener la entrada activa


# Función para pausar el juego
func pausar_juego():
	get_tree().paused = true
	visible = true  # Muestra la escena de pausa

# Función para reanudar el juego
func reanudar_juego():
	get_tree().paused = false
	visible = false  # Oculta la escena de pausa

# Función para ajustar el volumen de la música
func ajustar_musica(value):
	musica.volume_db = value

# Función para ajustar el volumen de los efectos
func ajustar_efectos(value):
	efectos.volume_db = value

# Conecta las señales de los botones
func _on_quit_pressed():
	print("Guardar y salir del juego")
	# Implementa lógica para guardar el progreso y cerrar la aplicación
	get_tree().quit()
	

func _on_retry_pressed():
	print("Reiniciar el nivel")
	get_tree().reload_current_scene()

func _on_resume_pressed():
	print("Continual el nivel")
	get_tree().paused = false
	visible = false  # Oculta la escena de pausa
	
# Emitir señal para reanudar el juego
func _on_reanudar_pressed():
	reanudar.emit()
	get_tree().paused = false
	panel.visible = false

# Emitir señal para reiniciar el nivel
func _on_reiniciar_pressed():
	reiniciar.emit()
	get_tree().paused = false
	get_tree().reload_current_scene()

# Emitir señal para salir al menú
func _on_salir_pressed():
	salir.emit()
	get_tree().paused = false
	panel.visible = false
	
func _focus_start() -> void:
	boton_reanudar.grab_focus.call_deferred()

func _on_panel_draw() -> void:
	_focus_start()
