extends CanvasLayer

@onready var hbox = $Panel/HBoxContainer
@onready var timer = $Panel/Timer
@onready var time_label = $Panel/TimeLabel

signal qte_finished(success)

var sequence: Array[String] = []
var current_index: int = 0
var finished: bool = false

var arrow_scenes := {
	"up": preload("res://Scenes/HUD/Arrows/ArrowUp.tscn"),
	"down": preload("res://Scenes/HUD/Arrows/ArrowDown.tscn"),
	"left": preload("res://Scenes/HUD/Arrows/ArrowLeft.tscn"),
	"right": preload("res://Scenes/HUD/Arrows/ArrowRight.tscn")
}

func _ready() -> void:
	timer.timeout.connect(Callable(self, "_on_time_up"))

func start_qte(num: int, time: float) -> void:
	$AnimationPlayer.play("Start")
	await $AnimationPlayer.animation_finished
	
	$Panel/TimeLabel.show()
	
	for child in hbox.get_children():
		child.queue_free()

	sequence.clear()

	for i in range(num):
		var dir = ["up", "down", "left", "right"].pick_random()
		sequence.append(dir)
		var arrow_scene = arrow_scenes[dir].instantiate()
		arrow_scene.modulate = Color(1, 1, 1)
		hbox.add_child(arrow_scene)

	current_index = 0
	timer.start(time)
	time_label.text = str(time)

func _process(_delta: float) -> void:
	time_label.text = str(round(timer.time_left * 10) / 10.0)

	if sequence.is_empty():
		return
	
	if !finished:
		if Input.is_action_just_pressed(sequence[current_index]):
			_set_arrow_color(current_index, Color(0, 1, 0))
			current_index += 1

			if current_index >= sequence.size():
				end_qte(true)
				finished = true
			
			$KeyPress_AudioStreamPlayer.play()

		elif Input.is_action_just_pressed("up") \
			or Input.is_action_just_pressed("down") \
			or Input.is_action_just_pressed("left") \
			or Input.is_action_just_pressed("right"):

			if not Input.is_action_just_pressed(sequence[current_index]):
				_set_arrow_color(current_index, Color(1, 0, 0))
				end_qte(false)
				finished = true

func _set_arrow_color(index: int, color: Color) -> void:
	if index < 0 or index >= hbox.get_child_count():
		return
	var arrow_scene = hbox.get_child(index)
	if arrow_scene.has_method("set_modulate"):
		arrow_scene.modulate = color
	elif arrow_scene.has_node("TextureRect"):
		arrow_scene.get_node("TextureRect").modulate = color

func _on_time_up() -> void:
	end_qte(false)
	finished = true

func end_qte(result : bool):
	if result:
		$AnimationPlayer.play("EndCorrect")
		await $AnimationPlayer.animation_finished
		qte_finished.emit(true)
	else:
		$AnimationPlayer.play("EndIncorrect")
		await $AnimationPlayer.animation_finished
		qte_finished.emit(false)
