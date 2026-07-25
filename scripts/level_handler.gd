extends Node

@export var levels : Array[PackedScene]
@export var music_transition_levels : Array[int]
@onready var fade_screen: ColorRect = $CanvasLayer/Fade
var current_level_ind = -1
var current_level = null

var fade_tween : Tween
var music_order = [
	preload("res://sounds/music/Only You Could Know - v1.wav"),
	preload("res://sounds/music/Only You Could Know - v2.wav"),
	preload("res://sounds/music/Only You Could Know - v3.wav"),
	preload("res://sounds/music/Only You Could Know - v4.wav"),
	preload("res://sounds/music/Only You Could Know - v5.wav")
]
var current_song = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.level_handler = self
	set_level(0)

func set_level(ind:int):
	if(is_instance_valid(current_level)):
		remove_child(current_level)
		current_level.queue_free()
	
	current_level_ind = ind
	current_level = levels[ind].instantiate()
	
	add_child(current_level)

func next_level():
	fade(true)
	await fade_tween.finished
	GameManager.current_mode = GameManager.PlayMode.PLACING
	set_level(current_level_ind+1)
	check_level_music(current_level_ind)
	fade(false)

func fade(out:bool):
	fade_screen.show()
	if(is_instance_valid(fade_tween)):
		fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.set_trans(Tween.TRANS_QUART)
	if(out):
		fade_tween.tween_property(fade_screen, "position:x", -200, 1.5).set_ease(Tween.EASE_OUT).from(1200)
	else:
		fade_tween.tween_property(fade_screen, "position:x", -2000, 1).set_ease(Tween.EASE_IN)


func check_level_music(ind:int):
	if(music_transition_levels[current_song] <= ind):
		current_song += 1
		print_debug(current_song)
		var pos = $Music.get_playback_position()
		print_debug(pos)
		$Music.stream = music_order[current_song]
		$Music.play(pos)
