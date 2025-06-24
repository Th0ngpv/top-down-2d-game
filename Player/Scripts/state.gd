class_name State extends Node

# initialize variables
static var player: Player 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

# when the player enter this state
func Enter() -> void:
	pass

# when the player exit this state
func Exit() -> void:
	pass
	
# what happen durring the state
func Process(_delta : float) -> State:
	return null
	
# physics process of the state
func Physics( _delta : float) -> State:
	return null
	
# inputs events in this state
func HandleInputs( _event : InputEvent) -> State:
	return null
