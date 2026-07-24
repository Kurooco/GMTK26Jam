extends AnimatedSprite2D

var t : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_first_node_in_group("count_tracker").satisfied.connect(open)
	get_tree().get_first_node_in_group("count_tracker").dissatisfied.connect(close)


func open():
	frame = 1

func close():
	frame = 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Player and frame == 1):
		pass
		
