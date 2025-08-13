class_name HudPause
extends CanvasLayer

@onready var main_buttons: VBoxContainer = $Panel/MainButtons
@onready var settings: Panel = $Panel/Settings

func _input(event) -> void:
	if event.is_action_released("ui_cancel"):
		if settings.visible:
			main_buttons.visible = true
			settings.visible = false
			$Panel/MainButtons/Resume.grab_focus()
			$Back_AudioStreamPlayer.play()

	if event.is_action_pressed("ui_accept"):
		$Select_AudioStreamPlayer.play()
	
	if main_buttons.visible and \
	(event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down")):
		$ChangeSelection_AudioStreamPlayer.play()
		
	if settings.visible and \
	(event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down") \
	or event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right")):
		$ChangeSelection_AudioStreamPlayer.play()

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
