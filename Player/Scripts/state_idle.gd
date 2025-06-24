class_name State_Idle extends State

@onready var walk: State_Walk = $"../Walk"

# when the player enter this state
func Enter() -> void:
	player.UpdateAnimation("idle")

# when the player exit this state
func Exit() -> void:
	pass
	
# what happen durring the state
func Process(_delta : float) -> State:
	
	if player.direction != Vector2.ZERO:
		return walk
	
	player.velocity = Vector2.ZERO
	return null
	
# physics process of the state
func Physics( _delta : float) -> State:
	return null
	
# inputs events in this state
func HandleInputs( _event : InputEvent) -> State:
	return null
