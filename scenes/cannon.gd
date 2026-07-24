extends Node2D

@onready var shoot_particles: CPUParticles2D = $Sprite2D/CPUParticles2D
var player : Player = null
var size_tween : Tween
var normal_size : Vector2

func _ready() -> void:
	normal_size = $Sprite2D.scale

func _on_area_2d_body_entered(body: Node2D) -> void:
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

func _on_timer_timeout() -> void:
	player.disable(false)
	player.apply_impulse(Vector2.from_angle(rotation)*500)
	player.show()
	shoot_particles.emitting = true
