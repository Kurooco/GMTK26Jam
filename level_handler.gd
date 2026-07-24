extends Node

@export var levels : Array[PackedScene]
var current_level_ind = -1
var current_level = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_level(0)

func set_level(ind:int):
	if(is_instance_valid(current_level)):
		remove_child(current_level)
		current_level.queue_free()
	
	current_level_ind = ind
	current_level = levels[ind].instantiate()
	
	add_child(current_level)
