class_name Babak
extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800
const MAX_HEALTH : int = 3
const DEFAULT_SHOOT_SPEED : float = 0.5
const DEFAULT_SPEED_MULTIPLICATOR_MOVEMENT : int = 10

@onready var anim_tree : AnimationTree = $AnimationTree
@onready var shoot_cooldown : Timer = $CooldownShootTimer

@export_group("Character Stats")
@export var life : int
@export var projectile : PackedScene
@export var speed_multiplicator : int
@export var shoot_cadence : float

var speed : int
var jumping : bool
var shoot_ready : bool
var level_base_speed : float
var moving_direction : int

var able_move_left : bool
var able_move_right : bool

signal player_dies

func _ready() -> void:
	life = MAX_HEALTH
	speed_multiplicator = DEFAULT_SPEED_MULTIPLICATOR_MOVEMENT
	able_move_left = true
	able_move_right = true
	shoot_cadence = DEFAULT_SHOOT_SPEED
	shoot_cooldown.wait_time = shoot_cadence
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
					$Jump_AudioStreamPlayer.play()
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

		moving_direction = 0
		
		if Input.is_action_pressed("right") and able_move_right:
			moving_direction = 1

		if Input.is_action_pressed("left") and able_move_left:
			moving_direction = -1
		
		velocity.x = moving_direction * (speed * speed_multiplicator)
		
		if Input.is_action_pressed("action"):
			shoot()

		move_and_slide()

func reduce_cadence(cadence_reduction_value : float):
	if (DEFAULT_SHOOT_SPEED - cadence_reduction_value) > 0:
		self.shoot_cadence = DEFAULT_SHOOT_SPEED - cadence_reduction_value

	shoot_cooldown.wait_time = self.shoot_cadence

func reset_shoot_cadence():
	self.shoot_cadence = DEFAULT_SHOOT_SPEED
	shoot_cooldown.wait_time = self.shoot_cadence

func increase_movement_speed(movement_speed : float):
	self.speed_multiplicator += movement_speed

func reset_movement_speed():
	self.speed_multiplicator = DEFAULT_SPEED_MULTIPLICATOR_MOVEMENT

func change_pos(pos : Vector2i):
	self.position = pos

func add_to_x_position(x_add):
	self.position.x += x_add

func change_vel(vel : Vector2i):
	self.velocity = vel

func set_speed(new_speed : int):
	self.speed = new_speed

func set_able_move(left : bool, right : bool):
	able_move_left = left
	able_move_right = right

func getting_hit(damage):
	life -= damage

	$HealthContainer.update_health(life)
	$HitParticles.emitting = true
	$Hit_AudioStreamPlayer.play()
	
	if(life <= 0):
		set_able_move(false, false)
		emit_signal("player_dies")

func recover_health(health : int):
	if (life + health) > MAX_HEALTH:
		life = MAX_HEALTH
	else:
		life += health

	$HealthContainer.update_health(life)
	$Cure_AudioStreamPlayer.play()
	
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
		$Shoot_AudioStreamPlayer.play()

		temp_projectile.set_speed(speed)
		temp_projectile.position = $Mouth.global_position
		temp_projectile.target_position = (get_global_mouse_position() - $Mouth.global_position).normalized()

		get_parent().add_child(temp_projectile)

		shoot_cooldown.start()

func _on_cooldown_shoot_timer_timeout() -> void:
	shoot_ready = true
