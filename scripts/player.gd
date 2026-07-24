extends RigidBody2D
class_name Player

var origin_position : Vector2
var reset = false
var colliding = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin_position = global_position
	can_sleep = false
	gravity_scale = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	modulate = Color.BLUE if GameManager.current_mode == 0 else Color.WHITE
	if(Input.is_action_just_pressed("switch_modes")):
		GameManager.current_mode = (GameManager.current_mode + 1) % 2
		if(GameManager.current_mode == 0):
			gravity_scale = 0
			reset = true
		else:
			gravity_scale = 1
			reset = false
	$Sprite2D.rotation += delta*linear_velocity.x*.1
	$CPUParticles2D.emitting = colliding && linear_velocity.length() > 50

func _integrate_forces(state):
	if(reset):
		var t = state.get_transform()
		t.origin = origin_position
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		$Sprite2D.rotation = 0
		rotation = 0
		state.set_transform(t)
		GameManager.player_reset.emit()
		#reset = false


func _on_body_entered(body: Node) -> void:
	if(linear_velocity.y < -200):
		$BigHit.emitting = true
	colliding = true


func _on_body_exited(body: Node) -> void:
	colliding = false
