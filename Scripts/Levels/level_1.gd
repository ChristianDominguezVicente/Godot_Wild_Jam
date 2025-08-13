class_name Level1
extends Node

var wall_scene = preload("res://Scenes/Obstacles/Wall.tscn")
var waste_scene = preload("res://Scenes/Obstacles/Waste.tscn")

###########################################
## BORRAR HACER CON UN OBJETO CON HITBOX ##
###########################################
var qte_scene = preload("res://Scenes/HUD/HUDQTE.tscn")

var obstacles_scenes := [wall_scene, waste_scene]
var obstacles : Array

const PLAYER_START_LOCATION := Vector2i(70, 485)
const CAM_START_LOCATION := Vector2i(576, 324)

const START_SPEED : float = 10.0
const MAX_SPEED : float = 25.0
const ACCELERATION : int = 2500
const SCORE_INCREASE_SPEED : int = 10

var speed : float
var screen_size : Vector2i
var ground_height : int
var score : int

var player_ready : bool
var player

var last_obstacle
var qte_instance

func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	player = load(Global.critter).instantiate()
	player.player_dies.connect(game_over)
	add_child(player)
	$HudRestart.restart_pressed.connect(start_level)
	start_level()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") and !$HudRestart.visible and !$HudStart/ReadyLabel.visible:
		pause()
	
	if !get_tree().paused:
		if(player_ready):
			main_level_logic()
		else:
			if Input.is_action_pressed("action"):
				player_ready = true
				$HudStart.hide_ready_msg()

func main_level_logic():
	speed = START_SPEED + score / ACCELERATION
	if speed > MAX_SPEED:
		speed = MAX_SPEED

	generate_obstacle()

	player.add_to_x_position(speed)
	player.set_speed(speed)
	$Camera2D.position.x += speed

	if $Camera2D.position.x - $Ground.position.x> screen_size.x * 1.5:
		$Ground.position.x += screen_size.x

	score += speed         
	$HudStart.update_score(score / SCORE_INCREASE_SPEED)
	
	if (score % 10000) == 0:
		start_qte()
 
	clear_passed_obs()

func start_level():
	player_ready = false
	score = 0
	clear_all_obs()
	
	get_tree().paused = false

	player.change_pos(PLAYER_START_LOCATION)
	player.change_vel(Vector2i(0, 0))
	player.reset()
	
	$Camera2D.position = CAM_START_LOCATION
	$Ground.position = Vector2i(0, 10)

	$HudRestart.hide()

	$HudStart.update_score(score)
	$HudStart.show_ready_msg()

func generate_obstacle():
	if obstacles.is_empty() or last_obstacle.position.x < score + randi_range(300, 500):
		var obs_type = obstacles_scenes[randi() % obstacles_scenes.size()]
		var obs = obs_type.instantiate()

		var obs_height = obs.get_node("Sprite2D").texture.get_height()
		var obs_scale = obs.get_node("Sprite2D").scale
		var obs_x : int = screen_size.x + score + 100
		var obs_y : int = screen_size.y - ground_height - (obs_height * obs_scale.y / 2) + 5
		
		add_obstacle(obs, obs_x, obs_y)

func add_obstacle(obs, x, y):
	obs.position = Vector2i(x, y)
	last_obstacle = obs
	add_child(obs)
	obstacles.append(obs)

func clear_passed_obs():
	for obs in obstacles:
		if obs.position.x < ($Camera2D.position.x - screen_size.x):
			remove_obs(obs)
			break

func clear_all_obs():
	for obs in obstacles:
		obs.queue_free()

	obstacles.clear()

func remove_obs(obs):
	obs.queue_free()
	obstacles.erase(obs)

func game_over():
	if Global.score < (score / SCORE_INCREASE_SPEED):
		Global.score = score / SCORE_INCREASE_SPEED
	
	get_tree().paused = true
	player_ready = false
	$HudRestart/Panel/MainButtons/Restart.grab_focus()
	$HudRestart.show()
	
func pause():
	if get_tree().paused:
		if $HudPause/Panel/Settings.visible:
			$HudPause._on_back_pressed()
		else:              
			get_tree().paused = false
			$HudPause.hide()
	else:
		get_tree().paused = true
		$HudPause/Panel/MainButtons/Resume.grab_focus()
		$HudPause.show()

###########################################
## BORRAR HACER CON UN OBJETO CON HITBOX ##
###########################################
func start_qte():
	get_tree().paused = true
	qte_instance = qte_scene.instantiate()
	add_child(qte_instance)
	qte_instance.connect("qte_finished", _on_qte_finished)

func _on_qte_finished(success : bool):
	if success:
		player.recover_health(1)
	else:
		player.getting_hit(1)

	if qte_instance:
		qte_instance.queue_free()
		qte_instance = null
	
	get_tree().paused = false
   
