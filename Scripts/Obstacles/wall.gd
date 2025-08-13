class_name Wall
extends Area2D

@export var life : int = 3
@export var damage : int = 1

@onready var hitbox : CollisionShape2D = $Hitbox

func receive_damage(enter_damage : int):
	life -= enter_damage
	
	$AnimatedSprite2D.animation = "broken_" + str(life)
	$AnimatedSprite2D.play()

	if life <= 0:
		hitbox.set_deferred("disabled", true)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("projectiles"):
		receive_damage(body.damage)
		
		var particles = body.get_node("HitParticles")
		body.remove_child(particles)
		get_tree().current_scene.add_child(particles)
		particles.global_position = body.global_position
		particles.emitting = true

		body.queue_free()

	if body.is_in_group("critter"):
		body.getting_hit(damage)

func _on_animated_sprite_2d_animation_finished() -> void:
	if life <= 0:
		self.hide()
