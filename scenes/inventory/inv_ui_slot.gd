extends Panel

@onready var item_icon: Sprite2D = $CenterContainer/Panel/icon
@onready var amount_text: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot):
	if !slot.item:
		item_icon.visible = false
		amount_text.visible = false
	else:
		item_icon.visible = true
		item_icon.texture = slot.item.texture
	
		if slot.amount > 1:
			amount_text.visible = true
			amount_text.text = "x"+str(slot.amount)
		else:
			amount_text.visible = false 
