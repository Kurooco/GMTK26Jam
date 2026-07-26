extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.player_reset.connect(set_expression.bind(0))
	get_tree().get_first_node_in_group("count_tracker").satisfied.connect(set_expression.bind(1))
	get_tree().get_first_node_in_group("count_tracker").dissatisfied.connect(set_expression.bind(2))


	
func set_expression(frame:int):
	$Sprite2D.frame = frame
	if(frame == 1):
		$Yes.play()
	if(frame == 2):
		$Yes.stop()
		$No.play()
