extends Node2D

func _on_button_pressed() -> void:
	Fade.transition()
	await Fade.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
