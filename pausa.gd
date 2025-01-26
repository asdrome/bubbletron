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
@onready var boton_guardar = $Panel/VBoxContainer/HBoxBotones/Salir
@onready var boton_reintentar = $Panel/VBoxContainer/HBoxBotones/Reiniciar
@onready var boton_reanudar = $Panel/VBoxContainer/HBoxBotones/Continuar


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
func _on_SaveAndExit_pressed():
	print("Guardar y salir del juego")
	# Implementa lógica para guardar el progreso y cerrar la aplicación
	get_tree().quit()
	

func _on_Retry_pressed():
	print("Reiniciar el nivel")
	get_tree().reload_current_scene()

func _on_Resume_pressed():
	reanudar_juego()
