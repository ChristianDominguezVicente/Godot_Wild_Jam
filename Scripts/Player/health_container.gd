extends HBoxContainer

const full_hearth = preload("res://Assets/Spritesheets/Hearth.png")

func _ready() -> void:
	for i in get_child_count():
		get_child(i).texture = full_hearth

func update_health(health: int) -> void:
	for i in get_child_count():
		get_child(i).visible = health > i
