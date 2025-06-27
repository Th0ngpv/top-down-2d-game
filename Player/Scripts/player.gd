class_name Player extends CharacterBody2D

# initialize variables
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

# nodes references
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

# signals
signal DirectionChanged( new_direction: Vector2 )

func _ready() -> void:
	state_machine.Initialize(self)

func _process(_delta: float) -> void:
#	handle directional inputs
	direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up", "down")
	).normalized()
# allow the character to move
func _physics_process(_delta: float):
	move_and_slide()

func setDirection() -> bool:
#	didn't give any inputs
	if direction == Vector2.ZERO:
		return false
#	round up the user inputs
	var direction_id : int  = int(round( (direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size() ) )
	var new_dir = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false
# change the current direction
	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir)
# flip(scale) the sprite
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

# update player animation
func UpdateAnimation(state : String) -> void:
	animation_player.play( state + "_" + animDirection() )

# convert the cardinal direction to string
func animDirection() -> String:
	if cardinal_direction == Vector2.DOWN || cardinal_direction == Vector2.ZERO:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
