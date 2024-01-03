extends CharacterBody2D
class_name Player

@export var shot : PackedScene # También podría ser así: @export var shot : PackedScene = preload("res://shot.tscn")

# get_viewport_rect().size nos retorna el tamaño del viewport, 
#o sea el tamaño de la ventana para los menos sibaritas, y vamos a necesitarlo para limitar la posición del personaje
@onready var screensize = get_viewport_rect().size

const SPEED = 80

func _process(_delta):
	anim_ctrl()
	motion_ctrl()
	
func _input(event):
	if event.is_action_pressed("ui_accept"): #barra espaciadora
		shoot_ctrl()
	
func anim_ctrl() -> void:
	#Indico mayor o menor que 0 en lugar de poner igual a 1 o -1 porque tambien nos podemos mover en diagonal
	if GLOBAL.get_axis().y > 0:
		$Spaceship.animation = "up"
	elif GLOBAL.get_axis().y < 0:
		$Spaceship.animation = "down"
	else:
		$Spaceship.animation = "idle"

func motion_ctrl() -> void:
	# velocity es un Vector2, por eso se pone .x o .y al final.
	velocity.x = GLOBAL.get_axis().x * SPEED
	velocity.y = GLOBAL.get_axis().y * -SPEED
	move_and_slide() # recupera la información de velocity y la aplica en pantalla
	
	# Para limitar el movimiento del player, vamos a usar la función clamp (pinza).
	# Actua como una pinza que mantiene algo entre un valor minimo y un maximo.
	# Pide 3 parámetros: la propiedad a ajustar, el valor minimo, y el valor maximo.
	# En este caso valor minimo y máximo son los valores de la pantalla (0 a max)
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
func shoot_ctrl() -> void:
	$Flash.play("flash")
	$Settings/AudioShot.play()
	
	var shot_instance = shot.instantiate()
	shot_instance.global_position = $Settings/ShootSpawn.global_position
	get_tree().call_group("Level", "add_child", shot_instance)
