class_name Level1
extends Node

var wall_scene = preload("res://Scenes/Obstacles/Wall.tscn")
var waste_scene = preload("res://Scenes/Obstacles/Waste.tscn")

var platform1_scene = preload("res://Scenes/Platforms/Platform1.tscn")
var platform2_scene = preload("res://Scenes/Platforms/Platform2.tscn")
var platform3_scene = preload("res://Scenes/Platforms/Platform3.tscn")
var platform4_scene = preload("res://Scenes/Platforms/Platform4.tscn")
var platform5_scene = preload("res://Scenes/Platforms/Platform5.tscn")

var syringe_scene = preload("res://Scenes/Consumables/syringe.tscn")
var uranium_scene = preload("res://Scenes/Consumables/uraniun_root.tscn")
var hearth_scene = preload("res://Scenes/Consumables/hearth.tscn")

###########################################
## BORRAR HACER CON UN OBJETO CON HITBOX ##
###########################################
var qte_scene = preload("res://Scenes/HUD/HUDQTE.tscn")

var obstacles_scenes := [wall_scene, waste_scene]
var obstacles : Array

var platforms_scenes := [platform1_scene, platform2_scene, platform3_scene, platform4_scene, platform5_scene]

var consumables_scenes := [syringe_scene, uranium_scene, hearth_scene]

const PLAYER_START_LOCATION := Vector2i(70, 485)
const CAM_START_LOCATION := Vector2i(576, 324)

const START_SPEED : float = 5.0
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
var qte_arrows : int = 4
var qte_time : float = 10.0
var last_qte_score : int = 0

func _ready() -> void:
	screen_size = Vector2i(1152, 648)
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
				player.set_able_move(true, true)
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

	if ($Camera2D.position.x - $Ground.position.x) > (screen_size.x * 1.5):     
		$Ground.position.x += screen_size.x

	score += speed
	var hud_score = int(score / SCORE_INCREASE_SPEED)
	$HudStart.update_score(hud_score)
	
	if hud_score >= last_qte_score + 1000:
		last_qte_score = hud_score
		start_qte()
 
	clear_passed_obs()

func start_level():
	player_ready = false
	score = 0
	qte_arrows = 4
	qte_time = 10.0
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
		var obs_y : int

		if obs_type == wall_scene:
			var random_wall_height = randf_range(0.5, 1.0)
			obs.get_node("Sprite2D").scale.y = random_wall_height
			obs_scale = obs.get_node("Sprite2D").scale
			obs_y = screen_size.y - ground_height - (obs_height * obs_scale.y / 2)

		if obs_type == waste_scene:
			obs_y = screen_size.y - ground_height - obs_height * obs_scale.y + 42
		else:
			obs_y = screen_size.y - ground_height - (obs_height * obs_scale.y / 2)
		
		add_obstacle(obs, obs_x, obs_y, true)
		
		if randf() < 0.75:
			var plat_type = platforms_scenes[randi() % platforms_scenes.size()]
			var plat = plat_type.instantiate()
			
			var plat_x : int = obs_x + randi_range(350, 400)
			var plat_y : int = screen_size.y - ground_height - randi_range(100, 300)
			
			add_obstacle(plat, plat_x, plat_y, false)
			
			if randf() < 0.75:
				var consumable_type = consumables_scenes[randi() % consumables_scenes.size()]
				var consumable = consumable_type.instantiate()
				
				var plat_center_x = plat.position.x + randi_range(40, 50)
				var plat_top_y = plat.position.y - 75
				
				add_obstacle(consumable, plat_center_x, plat_top_y, false)

func add_obstacle(obs, x, y, flag):
	obs.position = Vector2i(x, y)
	if flag:
		last_obstacle = obs
	add_child(obs)
	obstacles.append(obs)

func clear_passed_obs():
	for obs in obstacles:
		if obs == null:
			obstacles.erase(obs)
		elif not obs.is_in_group("consumable") and obs.position.x < ($Camera2D.position.x - screen_size.x):
			remove_obs(obs)
			break

func clear_all_obs():
	for obs in obstacles:
		if obs != null:
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
	$Music_AudioStreamPlayer.volume_db -= 10
	
	get_tree().paused = true
	qte_instance = qte_scene.instantiate()
	add_child(qte_instance)
	qte_instance.start_qte(qte_arrows, qte_time)
	qte_arrows += 1
	qte_time -= 1
	qte_instance.connect("qte_finished", _on_qte_finished)

func _on_qte_finished(success : bool):
	if success:
		player.recover_health(1)
	else:
		player.getting_hit(1)

	if qte_instance:
		qte_instance.queue_free()
		qte_instance = null
	
	$Music_AudioStreamPlayer.volume_db += 10

	if player_ready:
		get_tree().paused = false
   
