extends RigidBody2D

var origin_position : Vector2
var reset = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin_position = global_position
	can_sleep = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	modulate = Color.RED if GameManager.current_mode == 0 else Color.WHITE
	if(Input.is_action_just_pressed("switch_modes")):
		GameManager.current_mode = (GameManager.current_mode + 1) % 2
		if(GameManager.current_mode == 0):
			gravity_scale = 0
			reset = true
		else:
			gravity_scale = 1
			reset = false

func _integrate_forces(state):
	print_debug(Time.get_ticks_msec())
	if(reset):
		var t = state.get_transform()
		t.origin = origin_position
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		state.set_transform(t)
		#reset = false
