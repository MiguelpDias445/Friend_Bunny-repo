extends StaticBody2D

var player = null

@export var item: InvItem

func _on_area_2d_body_entered(body):
	if body.has_method('player'):
		player = body
		playerCollect()
		await get_tree().create_timer(0.1).timeout
		self.queue_free()
		
func playerCollect():
	player.collect(item)
