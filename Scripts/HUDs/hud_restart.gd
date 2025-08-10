class_name HudRestart
extends CanvasLayer

signal restart_pressed

func _on_exit_pressed() -> void:
	print("SALIENDO")
	get_tree().quit()

func _on_restart_pressed() -> void:
	print("REINICIANDO")
	emit_signal("restart_pressed")
