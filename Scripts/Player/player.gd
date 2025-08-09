class_name Player
extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800
const MAX_HEALTH : int = 3

var life : int

signal player_dies

func _ready() -> void:
	life = MAX_HEALTH
	$HealthContainer.update_health(life)

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta

	if is_on_floor():
		if not get_parent().player_ready:
			$AnimatedSprite2D.play("idle")
		if Input.is_action_pressed("up"):
			velocity.y = JUMP_SPEED
		else:
			$AnimatedSprite2D.play("walk")

	move_and_slide()

func getting_hit(damage):
	life -= damage

	$HealthContainer.update_health(life)

	if(life <= 0):
		emit_signal("player_dies")

func reset():
	life = MAX_HEALTH
	$HealthContainer.update_health(life)
