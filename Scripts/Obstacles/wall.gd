class_name Wall
extends Area2D

@export var life : int = 3
@export var damage : int = 1

func receive_damage(enter_damage : int):
	life -= enter_damage
	
	if life <= 0:
		destroy()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.getting_hit(damage)
	elif body.name == "BabakSpit":
		receive_damage(body.damage)

func destroy():
	self.hide()
