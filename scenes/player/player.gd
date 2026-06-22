extends CharacterBody2D

var direction: Vector2 = Vector2(1,1)
var speed := 60
var selectedItem

@onready var inv: Inv = preload("res://scenes/inventory/playerInv.tres")

@onready var item_holder = $ItemHolder

func change_selected_item(item: InvItem):
	selectedItem = item

	if item:
		item_holder.get_node("Sprite2D").texture = item.texure
		item_holder.get_node("Sprite2D").visible = true
	else:
		item_holder.get_node("Sprite2D").visible = false

func _physics_process(_delta: float) -> void:
	direction = Input.get_vector('left', 'right', 'up', 'down')
	velocity = direction * speed 
	animation()
	move_and_slide()
	
	if is_on_floor():
		print('Está no chão')
	
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

func collect(item):
	print("Collect called:", item)
	print("Inventory:", inv)
	inv.insert(item)
