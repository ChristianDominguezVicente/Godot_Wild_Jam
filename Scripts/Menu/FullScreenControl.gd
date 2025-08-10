extends CheckButton

func _ready() -> void:
	button_pressed = Global.fullScreen

func _on_toggled(toggled_on: bool) -> void:
	Global.fullScreen = toggled_on
	
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
