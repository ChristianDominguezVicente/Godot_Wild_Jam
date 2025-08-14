extends Area2D

const effect_code : int = 1

@export var reduce_cadence_value : float = 0.3

var affected_player

func _ready() -> void:
	add_to_group("consumable")
	$EffectDuration.wait_time = 2.0
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("critter"):
		$AnimatedSprite2D.hide()
		$CPUParticles2D.emitting = true
		affected_player = body
		affected_player.reduce_cadence(reduce_cadence_value)
		$EffectDuration.start()


func _on_effect_duration_timeout() -> void:
	print("Cadencia reseteada")
	affected_player.reset_shoot_cadence()
	self.queue_free()
