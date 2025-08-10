extends HSlider

@export var audio_bus_name : String

var audio_bus_id

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	
	if audio_bus_name == "Music":
		value = Global.music_value
	elif audio_bus_name == "SFX":
		value = Global.sfx_value
	
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)

func _on_value_changed(value: float) -> void:
	if audio_bus_name == "Music":
		Global.music_value = value
	elif audio_bus_name == "SFX":
		Global.sfx_value = value
		
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)
