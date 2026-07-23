extends Node2D

@export var rail : Path2D
@export var collision : CollisionObject2D

var movable = false
var moving = false
var pos_diff = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(!is_instance_valid(rail)):
		for child in get_children():
			if(child is Path2D):
				rail = child
				break
	if(!is_instance_valid(collision)):
		for child in get_children():
			if(child is CollisionObject2D):
				collision = child
				break
	collision.input_pickable = true
	collision.mouse_entered.connect(enable_movement.bind(true))
	collision.mouse_exited.connect(enable_movement.bind(false))
	
	# Create rail line
	$Line2D.points = rail.curve.get_baked_points()
	$Line2D.global_position = rail.global_position
	
	collision.position = rail.position + rail.curve.get_closest_point(collision.position)

func enable_movement(b:bool) -> void:
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and !moving): return
	movable = b

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(movable || moving):
		if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
			moving = true
			var desired_position = get_local_mouse_position()- pos_diff
			$Sprite2D.position = desired_position
			collision.position = rail.curve.get_closest_point(desired_position)
		else:
			moving = false
			pos_diff = get_local_mouse_position() - collision.position
	modulate = Color.RED if movable else Color.WHITE
