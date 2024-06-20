extends Area2D

@export var dialogue_ressource: DialogueResource
@export var dialogue_start: String = "start"
@export var time_cost: int = 10
@export var player: CharacterBody2D


func action(player) -> void:
	if player.deduct_time_units(time_cost):
		DialogueManager.show_example_dialogue_balloon(dialogue_ressource, dialogue_start)
	else:
		print("Player does not have enough time units to talk to this NPC")
	
