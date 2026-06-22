extends Control

@onready var inv: Inv = preload("res://scenes/inventory/playerInv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


func _ready():
	inv.update.connect(update_slots)
	update_slots()

	for i in range(slots.size()):
		var button = slots[i].get_node("Button")
		button.pressed.connect(selectedItem.bind(i))


func selectedItem(index: int):
	if index >= inv.slots.size():
		return

	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.selectedItem = inv.slots[index]

	slots[index].get_node("Button").grab_focus()


func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

		var button = slots[i].get_node("Button")
		
		if inv.slots[i].item:
			button.tooltip_text = inv.slots[i].item.name
		else:
			button.tooltip_text = ""
