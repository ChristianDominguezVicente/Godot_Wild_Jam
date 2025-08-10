class_name HudPause
extends CanvasLayer

@onready var main_buttons: VBoxContainer = $Panel/MainButtons
@onready var settings: Panel = $Panel/Settings

func _on_resume_pressed() -> void:
	$".".hide()
	get_tree().paused = false

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")

func _on_settings_pressed() -> void:
	main_buttons.visible = false
	settings.visible = true
	$Panel/Settings/SettingsContainer/Music/AudioControl.grab_focus()

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_back_pressed() -> void:
	main_buttons.visible = true
	settings.visible = false
	$Panel/MainButtons/Resume.grab_focus()
