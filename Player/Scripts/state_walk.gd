class_name State_Walk extends State

# export variable
@export var move_speed : float = 100.0

# nodes references
@onready var idle: State = $"../Idle"

# when the player enter this state
func Enter() -> void:
	player.UpdateAnimation("walk")

# when the player exit this state
func Exit() -> void:
	pass

# what happen durring the state
func Process(_delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.setDirection():
		player.UpdateAnimation("walk")
	
	return null

# physics process of the state
func Physics( _delta : float) -> State:
	return null

# inputs events in this state
func HandleInputs( _event : InputEvent) -> State:
	return null
