extends Node

enum PlayMode {
	PLACING = 0,
	ROLLING = 1
}

var current_mode : PlayMode = 0

signal player_reset
