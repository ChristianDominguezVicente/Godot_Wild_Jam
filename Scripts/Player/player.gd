class_name Player
extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta

	if Input.is_action_pressed("up"):
		if is_on_floor():
			velocity.y = JUMP_SPEED

	move_and_slide()
