extends Node2D
class_name Collectable

enum VegType {
	CARROT = 0,
	TURNIP = 1
}

static var sprites = [
	preload("res://art/carrot.png"),
	preload("res://art/turnip.png")
]

@export var type : VegType
var origin_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin_position = global_position
	$Sprite2D.frame = type


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = origin_position + Vector2(0, sin(Time.get_ticks_msec()/500.0)*10)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Player):
		queue_free()
