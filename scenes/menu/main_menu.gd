extends Node2D

func _on_play_pressed() -> void:
	Fade.transition()
	await Fade.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/game.tscn")
