extends Node2D

@export var counts : Dictionary[Collectable.VegType, int]
@onready var item_list: ItemList = $VBoxContainer/ItemList
var count_copy
var is_satisfied

signal satisfied
signal dissatisfied

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	count_copy = counts.duplicate()
	GameManager.player_reset.connect(reset)
	update_list()

func update_list():
	item_list.clear()
	for veg in counts.keys():
		var display = "x"+str(counts[veg]) if counts[veg] >= 0 else "X"
		item_list.add_item(display, Collectable.sprites[veg], false)

func subtract(type:int) -> void:
	if(!type in counts.keys()): return
	counts[type] -= 1
	if(check_satisfaction()):
		is_satisfied = true
		satisfied.emit()
	elif(is_satisfied || counts[type] == -1):
		dissatisfied.emit()
	update_list()

func reset():
	counts = count_copy.duplicate()
	if(is_satisfied):
		is_satisfied = false
	update_list()

func check_satisfaction():
	for k in counts.keys():
		if(counts[k] != 0):
			return false
	return true
