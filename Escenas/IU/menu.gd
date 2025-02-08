extends Control

signal start_game
signal quit

@onready var sfx_selection = $sfx_selection
@onready var credits = $Creditos
@onready var jugar_button = $MainMenu/Jugar
@onready var creditos_button = $MainMenu/Creditos
@onready var salir_button = $MainMenu/Salir
@onready var menu_music = $MenuMusic

func _ready():
	if OS.has_feature("web"):
		salir_button.hide()

	_focus_start()
	
	# Inicia música del menú
	menu_music.play()
	
	# Conectar señales para reproducción de sonido
	jugar_button.pressed.connect(_on_button_pressed)
	creditos_button.pressed.connect(_on_button_pressed)
	salir_button.pressed.connect(_on_button_pressed)

	# Conectar señales para detectar cuando un botón gana foco con el teclado
	jugar_button.focus_entered.connect(_on_button_focused)
	creditos_button.focus_entered.connect(_on_button_focused)
	salir_button.focus_entered.connect(_on_button_focused)

func _on_button_pressed():
	if sfx_selection:
		sfx_selection.play()  # Sonido al presionar

func _on_button_focused():
	if sfx_selection:
		sfx_selection.play()  # Sonido al navegar con el teclado

func _on_jugar_pressed() -> void:
	menu_music.stop()
	start_game.emit()

func _on_creditos_pressed() -> void:
	$MainMenu.hide()
	credits.visible = true
	$Creditos/BackToMenu.grab_focus.call_deferred()

func _on_salir_pressed() -> void:
	quit.emit()

func _focus_start() -> void:
	jugar_button.grab_focus.call_deferred()

func _on_back_to_menu_pressed() -> void:
	credits.visible = false
	$MainMenu.show()
	_focus_start()
	# Solo vuelve a reproducirse si no está sonando
	if not menu_music.playing:
		menu_music.play()

func _on_draw() -> void:
	_focus_start()
	
func _on_has_died() -> void:
	$MainMenu.show()
	if not menu_music.playing:
		menu_music.play()
