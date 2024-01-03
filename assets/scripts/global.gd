extends Node

#Estas variables podrian ir en la escena del player, pero para saber como
#funcionan los autoload se ponen aqui
var score : int = 0
var credits : int = 0

#variable y función del movimiento del jugador.
#Se pone de forma global para que no se cree una variable nueva cada vez que la funcion sea llamada
var axis : Vector2

#funcion para retornar la dirección pulsada
func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	return axis.normalized()
