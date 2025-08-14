extends Camera2D

func _on_left_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("critter"):
		body.set_able_move(false, true)
		print("LIMITE IZQUIERDO DENTRO")

func _on_middle_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("critter"):
		body.set_able_move(true, false)
		print("LIMITE CENTRO DENTRO ")

func _on_left_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("critter"):
		body.set_able_move(true, true)
		print("LIMITE IZQUIERDO FUERA ")

func _on_middle_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("critter"):
		body.set_able_move(true, true)
		print("LIMITE CENTRO FUERA ")
