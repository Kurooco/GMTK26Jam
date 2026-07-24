extends Node2D

@export var counts : Dictionary[Collectable.VegType, int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for veg in counts.keys():
		$ItemList.add_item(str(counts[veg]), Collectable.sprites[veg], false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
