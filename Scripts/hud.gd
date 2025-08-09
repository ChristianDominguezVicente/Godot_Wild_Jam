class_name Hud
extends CanvasLayer

func update_score(score: int) -> void:
	$ScoreLabel.text = "SCORE: " + str(score)

func hide_ready_msg() -> void:
	$ReadyLabel.hide()
	
func show_ready_msg() -> void:
	$ReadyLabel.show()
