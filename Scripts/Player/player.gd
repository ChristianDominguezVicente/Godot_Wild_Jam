class_name Player
extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800
const MAX_HEALTH : int = 3

var life : int

signal player_dies

func _ready() -> void:
	life = MAX_HEALTH

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta

	if Input.is_action_pressed("up"):
		if is_on_floor():
			velocity.y = JUMP_SPEED

	move_and_slide()

func getting_hit(damage):
	life -= damage

	if(life <= 0):
		emit_signal("player_dies")

func reset():
	life = MAX_HEALTH
