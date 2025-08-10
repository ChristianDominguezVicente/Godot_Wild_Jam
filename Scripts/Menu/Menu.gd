extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var settings: Panel = $Settings
@onready var selector: Panel = $Selector

func _ready() -> void:
	main_buttons.visible = true
	settings.visible = false
	selector.visible = false
	$MainButtons/Start.grab_focus()

func _input(event) -> void:
	if event.is_action_released("ui_cancel"):
		if settings.visible or selector.visible:
			main_buttons.visible = true
			settings.visible = false
			selector.visible = false
			$MainButtons/Start.grab_focus()
		else:
			get_tree().quit()

func _on_start_pressed() -> void:
	main_buttons.visible = false
	selector.visible = true
	$Selector/HBoxContainer/Babak.grab_focus()

func _on_settings_pressed() -> void:
	main_buttons.visible = false
	settings.visible = true
	$Settings/SettingsContainer/Music/AudioControl.grab_focus()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_back_settings_pressed() -> void:
	_ready()

func _on_babak_pressed() -> void:
	Global.critter = "res://Scenes/Player/Babak.tscn"
	get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")
