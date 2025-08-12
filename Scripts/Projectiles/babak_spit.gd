class_name BabakSpit
extends CharacterBody2D

@export var speed : int = 400
@export var constant_speed : int = 1200
@export var damage : int = 1

var target_position
var despawn_time : int = 2

func _ready() -> void:
	speed = constant_speed
	add_to_group("projectiles")
	despawn()

func _physics_process(delta: float) -> void:
	velocity = target_position * speed
	move_and_slide()

func set_speed(initial_speed : int):
	self.speed = constant_speed + initial_speed

func despawn():
	await get_tree().create_timer(despawn_time).timeout
	queue_free()
