extends RigidBody2D
class_name Player


@onready var line_2d: Line2D = $CanvasLayer/Line2D
var origin_position : Vector2
var reset = false
var colliding = false
var stick = false
var stick_position = Vector2.ZERO
var drawing = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin_position = global_position
	can_sleep = false
	gravity_scale = 0
	#line_2d.reparent(GameManager.level_handler.current_level, false)
	line_2d.global_position = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(drawing):
		line_2d.add_point(global_position)
	modulate = Color.BLUE if GameManager.current_mode == 0 else Color.WHITE
	if(Input.is_action_just_pressed("switch_modes")):
		$PlaySound.play()
		GameManager.current_mode = (GameManager.current_mode + 1) % 2
		if(GameManager.current_mode == 0):
			gravity_scale = 0
			GameManager.player_reset.emit()
			reset = true
		else:
			line_2d.clear_points()
			drawing = true
			gravity_scale = 1
			reset = false
	$Sprite2D.rotation += delta*linear_velocity.x*.1
	$CPUParticles2D.emitting = colliding && abs(linear_velocity.x) > 50


func _integrate_forces(state):
	if(reset):
		print_debug("here")
		drawing = false
		stick = false
		var t = state.get_transform()
		t.origin = origin_position
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		$Sprite2D.rotation += .1
		rotation = 0
		state.set_transform(t)
		show()
	if(stick):
		var t = state.get_transform()
		t.origin = stick_position
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		$Sprite2D.rotation = 0
		rotation = 0
		state.set_transform(t)


func _on_body_entered(body: Node) -> void:
	if(linear_velocity.y < -200):
		$BigHit.emitting = true
		$Thud.play()
	colliding = true


func _on_body_exited(body: Node) -> void:
	colliding = false


func disable(b:bool):
	stick = b
