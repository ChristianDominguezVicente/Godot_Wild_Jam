class_name HudStart
extends CanvasLayer

func update_score(score: int) -> void:
	$ScoreLabel.text = "SCORE: " + str(score)

func hide_ready_msg() -> void:
	$ReadyLabel.hide()
	$Panel.hide()
	
func show_ready_msg() -> void:
	$ReadyLabel.show()
	$Panel.show()
