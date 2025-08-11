extends Control

func _ready() -> void:
	$Back.grab_focus()

func _input(event) -> void:
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")
