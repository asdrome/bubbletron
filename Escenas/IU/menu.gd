extends Control

signal start_game
signal quit

@onready var credits = $Creditos

func _ready():
	if OS.has_feature("web"):
		$MainMenu/Salir.hide()
	_focus_start()
	
func _on_jugar_pressed() -> void:
	start_game.emit()

func _on_creditos_pressed() -> void:
	$MainMenu.hide()
	credits.visible = true
	$Creditos/BackToMenu.grab_focus.call_deferred()

func _on_salir_pressed() -> void:
	quit.emit()

func _focus_start() -> void:
	$MainMenu/Jugar.grab_focus.call_deferred()

func _on_back_to_menu_pressed() -> void:
	credits.visible = false
	$MainMenu.show()
	_focus_start()

func _on_draw() -> void:
	_focus_start()
