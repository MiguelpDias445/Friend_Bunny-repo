extends Area2D

@export var item: InvItem

var player = null
var player_near := false
var picked_up := false


func _ready():
	$EPrompt.visible = false


func _on_body_entered(body):
	if body.has_method("collect"):
		player = body
		player_near = true
		$EPrompt.visible = true


func _on_body_exited(body):
	if body == player:
		player = null
		player_near = false
		$EPrompt.visible = false


func _process(_delta):
	if player_near and Input.is_action_just_pressed("Interact"):
		pickup()


func pickup():
	if picked_up:
		return

	picked_up = true
	player_near = false
	$EPrompt.visible = false

	if player:
		player.collect(item)
		queue_free()
