extends Node2D

@export var node_textures : Dictionary[StaticBody2D, Texture]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var static_bodies = get_all_static_bodies(self)
	for b in static_bodies:
		var p : Polygon2D = Polygon2D.new()
		p.polygon = get_collision(b).polygon
		if(b in node_textures.keys()):
			p.texture = node_textures[b]
		else:
			p.texture = load("res://art/dirt.png")
		p.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
		p.position = get_collision(b).position
		b.add_child(p)
			

func get_all_static_bodies(node):
	var res = []
	for child in node.get_children():
		if(child is StaticBody2D):
			res.append(child)
		if(child.get_child_count() > 0):
			res.append_array(get_all_static_bodies(child))
	return res

func get_collision(node: StaticBody2D):
	for child in node.get_children():
		if(child is CollisionPolygon2D):
			return child
	return null
