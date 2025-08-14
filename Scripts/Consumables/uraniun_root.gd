extends Area2D

@export var movement_speed_increase_value : int = 20

var affected_player

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("critter"):
		$AnimatedSprite2D.hide()
		$CPUParticles2D.emitting = true
		affected_player = body
		affected_player.increase_movement_speed(movement_speed_increase_value)
		$EffectDuration.start()


func _on_effect_duration_timeout() -> void:
	affected_player.reset_movement_speed()
	self.queue_free()
	print("Velocidad reseteada")
