extends CharacterBody2D

@export var speed = 400.0
@export var acceleration = 2000.0
@export var deceleration = 1500.0

@export var end_day_dialogue_resource: DialogueResource
@export var end_day_dialogue_start: String = "start"

@onready var actionable_finder: Area2D = $Direction/ActionableFinder

var custom_velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
var time_units: int = 20
signal day_changed

func _ready():
	print("Player starts with ", time_units, " time units")

func _physics_process(delta):
	handle_input()
	update_movement(delta)
	move_and_slide()

func handle_input():
	input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	input_vector = input_vector.normalized()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action(self) 
			return
	

func update_movement(delta):
	if input_vector != Vector2.ZERO:
		custom_velocity = custom_velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		custom_velocity = custom_velocity.move_toward(Vector2.ZERO, deceleration * delta)

	velocity = custom_velocity

func deduct_time_units(amount: int) -> bool:
	if time_units >= amount:
		time_units -= amount
		print("Time units remaining: ", time_units)
		if time_units == 0:
			show_end_day_dialogue()
		return true
	else:
		print("Not enough time units")
		return false

func reset_time_units():
	time_units = 20
	print("Time units reset for a new day: ", time_units)

func show_end_day_dialogue():
	print("Attempting to show end day dialogue")
	if end_day_dialogue_resource:
		print("End day dialogue resource found")
		DialogueManager.show_example_dialogue_balloon(end_day_dialogue_resource, end_day_dialogue_start)
	else:
		print("End day dialogue resource not assigned")
