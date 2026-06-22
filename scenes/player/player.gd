extends CharacterBody2D

var direction: Vector2 = Vector2(1,1)
var speed := 60
var selectedItem

@onready var inv: Inv = preload("res://scenes/inventory/playerInv.tres")

@onready var item_holder = $ItemHolder

func _ready():
	print($footsteps.stream)

func change_selected_item(item: InvItem):
	selectedItem = item

	if item:
		item_holder.get_node("Sprite2D").texture = item.texture
		item_holder.get_node("Sprite2D").visible = true
	else:
		item_holder.get_node("Sprite2D").visible = false

func _physics_process(_delta: float) -> void:
	direction = Input.get_vector('left', 'right', 'up', 'down')
	velocity = direction * speed 
	if direction != Vector2.ZERO:
		if !$footsteps.playing:
			$footsteps.play()
	else:
		$footsteps.stop()
	animation()
	move_and_slide()
	
func animation():
	var sprite = $AnimatedSprite2D

	if direction != Vector2.ZERO:
		
		if direction.x != 0:
			if sprite.animation != "left":
				sprite.play("right")
			sprite.flip_h = direction.x < 0
		
		elif direction.y < 0:
			if sprite.animation != "up":
				sprite.play("up")
		
		elif direction.y > 0:
			if sprite.animation != "down":
				sprite.play("down")
	else:
		$AnimatedSprite2D.frame = 0
		
func player():
	pass

func clear_inventory():
	for slot in inv.slots:
		slot.item = null
	
	inv.update.emit()
	selectedItem = null

func collect(item):
	print("Collect called:", item)
	print("Inventory:", inv)
	inv.insert(item)
