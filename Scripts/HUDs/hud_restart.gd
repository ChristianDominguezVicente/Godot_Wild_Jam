class_name HudRestart
extends CanvasLayer

signal restart_pressed

func _input(event) -> void:
	if event.is_action_pressed("ui_accept"):
		$Select_AudioStreamPlayer.play()

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_restart_pressed() -> void:
	emit_signal("restart_pressed")

func _on_restart_focus_entered() -> void:
	$Panel/Restart.z_index = 1
	var tween = create_tween()
	tween.set_parallel(true)
	$ChangeSelection_AudioStreamPlayer.play()
	tween.tween_property($Panel/Restart, "rotation_degrees", 10, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($Panel/Restart, "scale", Vector2(1.2, 1.2), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_restart_focus_exited() -> void:
	$Panel/Restart.z_index = 0
	var tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property($Panel/Restart, "rotation_degrees", 0, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property($Panel/Restart, "scale", Vector2(1.0, 1.0), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

func _on_exit_focus_entered() -> void:
	$Panel/Exit.z_index = 1
	var tween = create_tween()
	tween.set_parallel(true)
	$ChangeSelection_AudioStreamPlayer.play()
	tween.tween_property($Panel/Exit, "rotation_degrees", -5, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($Panel/Exit, "scale", Vector2(1.1, 1.1), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_exit_focus_exited() -> void:
	$Panel/Exit.z_index = 0
	var tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property($Panel/Exit, "rotation_degrees", 0, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property($Panel/Exit, "scale", Vector2(1.0, 1.0), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
