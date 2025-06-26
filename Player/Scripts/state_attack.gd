class_name State_Attack extends State

# initialize var
var attacking : bool = false

# nodes references
@onready var walk: State_Walk = $"../Walk"
@onready var idle: State_Idle = $"../Idle"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

# when the player enter this state
func Enter() -> void:
	attacking = true
	player.UpdateAnimation("attack")
	animation_player.animation_finished.connect(EndAttack)

# when the player exit this state
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	pass
	
# what happen durring the state
func Process(_delta : float) -> State:	
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	
	return null
	
# physics process of the state
func Physics( _delta : float) -> State:
	return null
	
# inputs events in this state
func HandleInputs( _event : InputEvent) -> State:
	return null

func EndAttack( _newAnimName) -> void:
	attacking = false
