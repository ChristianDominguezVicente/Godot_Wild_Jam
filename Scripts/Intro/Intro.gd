extends Control


func _input(event) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")
