class_name Waste
extends Area2D

@export var life : int = 1
@export var damage : int = 1

@onready var hitbox : CollisionPolygon2D = $Hitbox

func receive_damage(enter_damage : int):
	life -= enter_damage

	if life <= 0:
		destroy()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("projectiles"):
		receive_damage(body.damage)

	if body.is_in_group("critter"):
		body.getting_hit(damage)

func destroy():
	hitbox.set_deferred("disabled", true)
	self.hide()
