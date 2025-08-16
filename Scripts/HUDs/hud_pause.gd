class_name HudPause
extends CanvasLayer

@onready var main_buttons: Panel = $Panel/MainButtons
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

func _on_resume_focus_entered() -> void:
	$Panel/MainButtons/Resume.z_index = 1
	var tween = create_tween()
	tween.set_parallel(true)
	$ChangeSelection_AudioStreamPlayer.play()
	tween.tween_property($Panel/MainButtons/Resume, "rotation_degrees", 15, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($Panel/MainButtons/Resume, "scale", Vector2(1.3, 1.3), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_resume_focus_exited() -> void:
	$Panel/MainButtons/Resume.z_index = 0
	var tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property($Panel/MainButtons/Resume, "rotation_degrees", 0, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property($Panel/MainButtons/Resume, "scale", Vector2(1.0, 1.0), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

func _on_restart_focus_entered() -> void:
	$Panel/MainButtons/Restart.z_index = 1
	var tween = create_tween()
	tween.set_parallel(true)
	$ChangeSelection_AudioStreamPlayer.play()
	tween.tween_property($Panel/MainButtons/Restart, "rotation_degrees", -5, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($Panel/MainButtons/Restart, "scale", Vector2(1.1, 1.1), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_restart_focus_exited() -> void:
	$Panel/MainButtons/Restart.z_index = 0
	var tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property($Panel/MainButtons/Restart, "rotation_degrees", 0, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property($Panel/MainButtons/Restart, "scale", Vector2(1.0, 1.0), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

func _on_settings_focus_entered() -> void:
	$Panel/MainButtons/Settings.z_index = 1
	var tween = create_tween()
	tween.set_parallel(true)
	$ChangeSelection_AudioStreamPlayer.play()
	tween.tween_property($Panel/MainButtons/Settings, "rotation_degrees", 10, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($Panel/MainButtons/Settings, "scale", Vector2(1.2, 1.2), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_settings_focus_exited() -> void:
	$Panel/MainButtons/Settings.z_index = 0
	var tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property($Panel/MainButtons/Settings, "rotation_degrees", 0, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property($Panel/MainButtons/Settings, "scale", Vector2(1.0, 1.0), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

func _on_exit_focus_entered() -> void:
	$Panel/MainButtons/Exit.z_index = 1
	var tween = create_tween()
	tween.set_parallel(true)
	$ChangeSelection_AudioStreamPlayer.play()
	tween.tween_property($Panel/MainButtons/Exit, "rotation_degrees", -15, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($Panel/MainButtons/Exit, "scale", Vector2(1.1, 1.1), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_exit_focus_exited() -> void:
	$Panel/MainButtons/Exit.z_index = 0
	var tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property($Panel/MainButtons/Exit, "rotation_degrees", 0, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property($Panel/MainButtons/Exit, "scale", Vector2(1.0, 1.0), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

func _on_back_focus_entered() -> void:
	$Panel/Settings/Back.z_index = 1
	var tween = create_tween()
	tween.set_parallel(true)
	$ChangeSelection_AudioStreamPlayer.play()
	tween.tween_property($Panel/Settings/Back, "rotation_degrees", -10, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($Panel/Settings/Back, "scale", Vector2(1.1, 1.1), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_back_focus_exited() -> void:
	$Panel/Settings/Back.z_index = 0
	var tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property($Panel/Settings/Back, "rotation_degrees", 0, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property($Panel/Settings/Back, "scale", Vector2(1.0, 1.0), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

func _on_focus_entered() -> void:
	$ChangeSelection_AudioStreamPlayer.play()
