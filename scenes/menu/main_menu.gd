extends Node2D

func _on_play_pressed() -> void:
	Fade.transition()
	await Fade.on_transition_finished
	get_tree().change_scene_to_file("res://cutscenes/cutscene_1.tscn")
	Fade.transition()
	await Fade.on_transition_finished
	
"res://scenes/game.tscn"

func _on_quit_pressed() -> void:
	get_tree().quit()
	


func _on_credits_pressed() -> void:
	pass # Replace with function body.
