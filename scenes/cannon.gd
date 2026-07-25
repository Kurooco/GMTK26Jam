extends Area2D

@export var force = 500
@onready var shoot_particles: CPUParticles2D = $Sprite2D/CPUParticles2D
var player : Player = null
var size_tween : Tween
var normal_size : Vector2

func _ready() -> void:
	normal_size = $Sprite2D.scale
	make_line()


func _on_timer_timeout() -> void:
	player.disable(false)
	player.apply_impulse(Vector2.from_angle(rotation)*force)
	player.show()
	shoot_particles.emitting = true


func _on_body_entered(body: Node2D) -> void:
	if(body is Player):
		player = body
		body.stick_position = global_position
		body.disable(true)
		body.hide()
		$Timer.start()
		if(is_instance_valid(size_tween)):
			size_tween.kill()
		size_tween = create_tween()
		size_tween.tween_property($Sprite2D, "scale", normal_size, .3).from(normal_size*2)

func make_line():
	$Line2D.global_rotation = 0
	var curr = Vector2.ZERO
	var vel = Vector2.from_angle(rotation)*force
	for i in range(800):
		$Line2D.add_point(curr)
		curr += vel*.001
		vel.y += ProjectSettings.get_setting("physics/2d/default_gravity")*.001
