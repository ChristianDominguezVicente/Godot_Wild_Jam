class_name Level1
extends Node

var wall_scene = preload("res://Scenes/Obstacles/Wall.tscn")
var waste_scene = preload("res://Scenes/Obstacles/Waste.tscn")

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

var last_obstacle

func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	start_level()

func _process(delta: float) -> void:
	if(player_ready):
		main_level_logic()
	else:
		if Input.is_action_pressed("action"):
			player_ready = true
			$Hud.hide_ready_msg()

func main_level_logic():
	speed = START_SPEED + score / ACCELERATION
	if speed > MAX_SPEED:
		speed = MAX_SPEED

	generate_obstacle()

	$Player.position.x += speed
	$Camera2D.position.x += speed

	if $Camera2D.position.x - $Ground.position.x> screen_size.x * 1.5:
		$Ground.position.x += screen_size.x

	score += speed         
	$Hud.update_score(score / SCORE_INCREASE_SPEED)
 
	clear_passed_obs()

func start_level():
	player_ready = false
	score = 0

	$Player.position = PLAYER_START_LOCATION
	$Player.velocity = Vector2i(0, 0)
	
	$Camera2D.position = CAM_START_LOCATION
	$Ground.position = Vector2i(0, 10)

	$Hud.update_score(score)
	$Hud.show_ready_msg()

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

func remove_obs(obs):
	obs.queue_free()
	obstacles.erase(obs)
