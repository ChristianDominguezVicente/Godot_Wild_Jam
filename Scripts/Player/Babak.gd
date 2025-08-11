class_name Babak
extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800
const MAX_HEALTH : int = 3

@onready var anim_tree : AnimationTree = $AnimationTree

@export_group("Character Stats")
@export var life : int
@export var projectile : PackedScene

var speed : int
var jumping : bool

signal player_dies

func _ready() -> void:
	life = MAX_HEALTH
	$HealthContainer.update_health(life)

func _physics_process(delta: float) -> void:
	if !get_tree().paused:
		velocity.y += GRAVITY * delta

		if is_on_floor():
			if not get_parent().player_ready:
				anim_tree["parameters/conditions/is_stopped"] = true
			else:
				anim_tree["parameters/conditions/is_stopped"] = false

			if Input.is_action_pressed("up"):
				velocity.y = JUMP_SPEED
				jumping = true
				anim_tree["parameters/conditions/has_jumped"] = true
			elif jumping:
				jumping = false
				anim_tree["parameters/conditions/is_falling"] = false
				anim_tree["parameters/conditions/has_fell"] = true
			else:
				anim_tree["parameters/conditions/has_fell"] = false
				anim_tree["parameters/conditions/is_walking"] = true
		else:
			if velocity.y <= 200:
				anim_tree["parameters/conditions/has_jumped"] = false
				anim_tree["parameters/conditions/is_falling"] = true
		
		if Input.is_action_pressed("action"):
			shoot()

		move_and_slide()

func getting_hit(damage):
	life -= damage

	$HealthContainer.update_health(life)

	if(life <= 0):
		emit_signal("player_dies")

func reset():
	life = MAX_HEALTH
	$HealthContainer.update_health(life)

func shoot() -> void:
	var temp_projectile = projectile.instantiate()

	temp_projectile.set_speed(speed)
	temp_projectile.position = $Mouth.global_position
	temp_projectile.target_position = (get_global_mouse_position() - $Mouth.global_position).normalized()

	get_parent().add_child(temp_projectile)
