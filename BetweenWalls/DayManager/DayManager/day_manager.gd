extends Node2D

var current_day: int = 1
@export var player: CharacterBody2D

func _ready():
	if player:
		player.connect("day_changed", Callable(self, "_on_day_changed"))
	else:
		print("Player node not assigned")

func _on_day_changed():
	current_day += 1
	print("Day changed to: Day ", current_day)
	player.reset_time_units()
