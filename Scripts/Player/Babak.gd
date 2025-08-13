class_name Babak
extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800
const MAX_HEALTH : int = 3

@onready var anim_tree : AnimationTree = $AnimationTree
@onready var shoot_cooldown : Timer = $CooldownShootTimer

@export_group("Character Stats")
@export var life : int
@export var projectile : PackedScene

var speed : int
var jumping : bool
var shoot_ready : bool

signal player_dies

func _ready() -> void:
	life = MAX_HEALTH
	$HealthContainer.update_health(life)
	add_to_group("critter")
	shoot_ready = true

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
					$LandedParticles.emitting = true
					anim_tree["parameters/conditions/has_fell"] = false
					anim_tree["parameters/conditions/is_walking"] = true
		else:
			if velocity.y <= 200:
				anim_tree["parameters/conditions/has_jumped"] = false
				anim_tree["parameters/conditions/is_falling"] = true
		
		if Input.is_action_pressed("action"):
			shoot()

		move_and_slide()

func change_pos(pos : Vector2i):
	self.position = pos

func add_to_x_position(x_add):
	self.position.x += x_add

func change_vel(vel : Vector2i):
	self.velocity = vel

func set_speed(new_speed : int):
	self.speed = new_speed

func getting_hit(damage):
	life -= damage

	$HealthContainer.update_health(life)
	$HitParticles.emitting = true
	
	if(life <= 0):
		emit_signal("player_dies")

func recover_health(health : int):
	if (life + health) > MAX_HEALTH:
		life = MAX_HEALTH
	else:
		life += health

	$HealthContainer.update_health(life)

func reset():
	anim_tree["parameters/conditions/has_jumped"] = false
	anim_tree["parameters/conditions/has_fell"] = false
	anim_tree["parameters/conditions/is_falling"] = false

	anim_tree["parameters/conditions/is_stopped"] = true
	life = MAX_HEALTH
	$HealthContainer.update_health(life)

func shoot() -> void:
	if shoot_ready:
		shoot_ready = false
		var temp_projectile = projectile.instantiate()

		temp_projectile.set_speed(speed)
		temp_projectile.position = $Mouth.global_position
		temp_projectile.target_position = (get_global_mouse_position() - $Mouth.global_position).normalized()

		get_parent().add_child(temp_projectile)

		shoot_cooldown.start()

func _on_cooldown_shoot_timer_timeout() -> void:
	shoot_ready = true
