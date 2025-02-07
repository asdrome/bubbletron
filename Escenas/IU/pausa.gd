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
@onready var boton_salir_menu = $Panel/VBoxContainer/HBoxBotones/Salir
@onready var boton_reiniciar = $Panel/VBoxContainer/HBoxBotones/Reiniciar
@onready var boton_reanudar = $Panel/VBoxContainer/HBoxBotones/Continuar

func _ready():
	# Conectar señales de los botones
	boton_reanudar.connect("pressed", Callable(self, "_on_reanudar_pressed"))
	boton_reiniciar.connect("pressed", Callable(self, "_on_reiniciar_pressed"))
	boton_salir_menu.connect("pressed", Callable(self, "_on_salir_pressed"))


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

# Emitir señal para reiniciar el nivel
func _on_reiniciar_pressed():
	reiniciar.emit()

# Emitir señal para salir al menú
func _on_salir_pressed():
	salir.emit()
