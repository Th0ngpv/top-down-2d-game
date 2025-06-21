class_name Player extends CharacterBody2D

# initialize variables
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var move_speed: float = 100.0
var state : String = "idle"

# nodes references
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready():
	pass

func _process(_delta: float) -> void:
#	handle directional inputs
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
#	calculate current movement speed
	velocity = direction * move_speed
#	update animation conditions
	if SetState() == true || setDirection() == true:
		UpdateAnimation()
	
	pass
# allow the character to move
func _physics_process(_delta: float) -> void:
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
# flip(scale) the sprite
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func SetState() -> bool:
#	get the next state of player
	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
	
#	current state and next state comparision
	if new_state == state:
		return false	
	state = new_state
	return true

# update player animation
func UpdateAnimation() -> void:
	animation_player.play( state + "_" + animDirection() )
	pass

# convert the cardinal direction to string
func animDirection() -> String:
	if cardinal_direction == Vector2.DOWN || cardinal_direction == Vector2.ZERO:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
