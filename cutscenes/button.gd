extends Button



func _on_pressed() -> void:
	Fade.transition()
	await Fade.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/game.tscn")
