## Clase base abstracta para niveles en el juego.
## Define señales comunes para el flujo del juego y métodos para emitirlas.
class_name Level2D
extends Node2D

## Emitida cuando el juego se pausa.
signal paused()
## Emitida cuando el juego se reanuda.
signal resumed()
## Emitida cuando el jugador pierde.
signal game_over()
## Emitida cuando el jugador regresa al menú principal.
signal back_to_menu()

## Posicion inicial del jugador al entrar al nivel
@export var starting_position : Vector2 = Vector2.ZERO

func _ready():
	if self.get_script() == preload("res://Escenas/Escenarios/level2d.gd"):
		push_error("Level es abstracta y no debe instanciarse directamente")

# Estos métodos solo son para silenciar los warnings, no deben ser usados

## Emite la señal `game_over`, indicando que el juego ha terminado.
func _emit_game_over():
	game_over.emit()

## Emite la señal `resumed`, indicando que el juego ha sido reanudado.
func _emit_resumed():
	resumed.emit()

## Emite la señal `paused`, indicando que el juego ha sido pausado.
func _emit_paused():
	paused.emit()

## Emite la señal `back_to_menu`, indicando que el jugador ha vuelto al menú.
func _emit_back_to_menu():
	back_to_menu.emit()
