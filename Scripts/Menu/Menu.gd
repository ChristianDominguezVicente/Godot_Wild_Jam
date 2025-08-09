extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var settings: Panel = $Settings

func _ready() -> void:
	main_buttons.visible = true
	settings.visible = false
	$MainButtons/Start.grab_focus()

func _input(event) -> void:
	if event.is_action_released("ui_cancel"):
		if settings.visible:
			main_buttons.visible = true
			settings.visible = false
			$MainButtons/Start.grab_focus()
		else:
			get_tree().quit()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_settings_pressed() -> void:
	main_buttons.visible = false
	settings.visible = true
	$Settings/SettingsContainer/Music/AudioControl.grab_focus()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_back_settings_pressed() -> void:
	_ready()
