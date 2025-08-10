class_name HudRestart
extends CanvasLayer

signal restart_pressed

func _on_exit_pressed() -> void:
	print("SALIENDO")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_restart_pressed() -> void:
	print("REINICIANDO")
	emit_signal("restart_pressed")
