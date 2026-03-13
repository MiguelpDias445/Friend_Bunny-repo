extends Control

@onready var inv: Inv = preload("res://scenes/inventory/playerInv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	update_slots()


func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])
