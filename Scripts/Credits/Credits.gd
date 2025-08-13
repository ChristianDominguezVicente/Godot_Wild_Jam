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
