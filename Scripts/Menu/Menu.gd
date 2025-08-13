extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var settings: Panel = $Settings
@onready var selector: Panel = $Selector

func _ready() -> void:
	main_buttons.visible = true
	settings.visible = false
	selector.visible = false
	$MainButtons/Start.grab_focus()
	print(Global.score)
	if Global.score < 1000:
		$Selector/HBoxContainer/Pukul/VBoxContainer/TextureRect.modulate = Color(0, 0, 0)
		$Selector/HBoxContainer/Pukul/VBoxContainer/Stats.text = "Score needed: 1000"
		$Selector/HBoxContainer/Gerakan/VBoxContainer/TextureRect.modulate = Color(0, 0, 0)
		$Selector/HBoxContainer/Gerakan/VBoxContainer/Stats.text = "Score needed: 2000"
		$Selector/HBoxContainer/Muntah/VBoxContainer/TextureRect.modulate = Color(0, 0, 0)
		$Selector/HBoxContainer/Muntah/VBoxContainer/Stats.text = "Score needed: 3000"
		$Selector/HBoxContainer/Kaki/VBoxContainer/TextureRect.modulate = Color(0, 0, 0)
		$Selector/HBoxContainer/Kaki/VBoxContainer/Stats.text = "Score needed: 4000"
	elif Global.score < 2000:
		$Selector/HBoxContainer/Gerakan/VBoxContainer/TextureRect.modulate = Color(0, 0, 0)
		$Selector/HBoxContainer/Gerakan/VBoxContainer/Stats.text = "Score needed: 2000"
		$Selector/HBoxContainer/Muntah/VBoxContainer/TextureRect.modulate = Color(0, 0, 0)
		$Selector/HBoxContainer/Muntah/VBoxContainer/Stats.text = "Score needed: 3000"
		$Selector/HBoxContainer/Kaki/VBoxContainer/TextureRect.modulate = Color(0, 0, 0)
		$Selector/HBoxContainer/Kaki/VBoxContainer/Stats.text = "Score needed: 4000"
	elif Global.score < 3000:
		$Selector/HBoxContainer/Muntah/VBoxContainer/TextureRect.modulate = Color(0, 0, 0)
		$Selector/HBoxContainer/Muntah/VBoxContainer/Stats.text = "Score needed: 3000"
		$Selector/HBoxContainer/Kaki/VBoxContainer/TextureRect.modulate = Color(0, 0, 0)
		$Selector/HBoxContainer/Kaki/VBoxContainer/Stats.text = "Score needed: 4000"
	elif Global.score < 4000:
		$Selector/HBoxContainer/Kaki/VBoxContainer/TextureRect.modulate = Color(0, 0, 0)
		$Selector/HBoxContainer/Kaki/VBoxContainer/Stats.text = "Score needed: 4000"

func _input(event) -> void:
	if event.is_action_released("ui_cancel"):
		if settings.visible or selector.visible:
			main_buttons.visible = true
			settings.visible = false
			selector.visible = false
			$MainButtons/Start.grab_focus()
			$Back_AudioStreamPlayer.play()
		else:
			get_tree().quit()
	
	if event.is_action_pressed("ui_accept"):
		$Select_AudioStreamPlayer.play()
	
	if main_buttons.visible and \
	(event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down")):
		$ChangeSelection_AudioStreamPlayer.play()
		
	if (settings.visible or selector.visible) and \
	(event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down") \
	or event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right")):
		$ChangeSelection_AudioStreamPlayer.play()

func _on_start_pressed() -> void:
	main_buttons.visible = false
	selector.visible = true
	$Selector/HBoxContainer/Babak.grab_focus()

func _on_settings_pressed() -> void:
	main_buttons.visible = false
	settings.visible = true
	$Settings/SettingsContainer/Music/AudioControl.grab_focus()

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Credits/Credits.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_back_settings_pressed() -> void:
	_ready()

func _on_babak_pressed() -> void:
	Global.critter = "res://Scenes/Player/Babak.tscn"
	get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")

func _on_pukul_pressed() -> void:
	if Global.score >= 1000:
		Global.critter = "res://Scenes/Player/Babak.tscn"
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")

func _on_gerakan_pressed() -> void:
	if Global.score >= 2000:
		Global.critter = "res://Scenes/Player/Babak.tscn"
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")

func _on_muntah_pressed() -> void:
	if Global.score >= 3000:
		Global.critter = "res://Scenes/Player/Babak.tscn"
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")

func _on_kaki_pressed() -> void:
	if Global.score >= 4000:
		Global.critter = "res://Scenes/Player/Babak.tscn"
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")
