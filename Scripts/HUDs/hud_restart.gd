class_name HudRestart
extends CanvasLayer

@onready var main_buttons: VBoxContainer = $Panel/MainButtons

signal restart_pressed

func _input(event) -> void:
	if event.is_action_pressed("ui_accept"):
		$Select_AudioStreamPlayer.play()
	
	if main_buttons.visible and \
	(event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down")):
		$ChangeSelection_AudioStreamPlayer.play()

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_restart_pressed() -> void:
	emit_signal("restart_pressed")
