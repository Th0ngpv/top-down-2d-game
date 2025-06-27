class_name Player extends CharacterBody2D

# initialize variables
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
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up", "down")
	).normalized()
# allow the character to move
func _physics_process(_delta: float):
	move_and_slide()

func setDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
#	didn't give any inputs
	if direction == Vector2.ZERO:
		return false
#	round up user's inputs
	# left and right
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	# up and down
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
#	compare the current and the next direction
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
