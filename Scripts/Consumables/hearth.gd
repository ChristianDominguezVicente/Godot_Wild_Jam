extends Area2D

@export var heal : int = 1

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("critter"):
		$AnimatedSprite2D.hide()
		$CPUParticles2D.emitting = true
		body.recover_health(heal)
