extends Panel

@onready var item_icon: Sprite2D = $CenterContainer/Panel/icon

func update(item: InvItem):
	if !item:
		item_icon.visible = false
	else:
		item_icon.visible = true
		item_icon.texture = item.texture
