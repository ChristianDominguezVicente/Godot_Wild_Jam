extends Control

func _ready() -> void:
	$Back.grab_focus()

func _input(event) -> void:
	if event.is_action_released("ui_cancel"):
		$Back_AudioStreamPlayer.play()
		get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_back_pressed() -> void:
	$Back_AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_back_focus_entered() -> void:
	$Back.z_index = 1
	var tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property($Back, "rotation_degrees", -10, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($Back, "scale", Vector2(1.2, 1.2), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_back_focus_exited() -> void:
	$Back.z_index = 0
	var tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property($Back, "rotation_degrees", 0, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property($Back, "scale", Vector2(1.0, 1.0), 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
