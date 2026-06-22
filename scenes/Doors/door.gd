extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var dest = get_node_or_null("Marker2D")

		if dest:
			Fade.transition()
			await Fade.on_transition_finished
			body.global_position = dest.global_position
		else:
			print("DestinationPoint not found!")
