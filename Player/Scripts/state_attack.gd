class_name State_Attack extends State

# initialize var
var attacking : bool = false

# export var
@export var attack_sound : AudioStream
@export_range(1, 20, 0.5) var deceleration : float = 5.0

# nodes references
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation_player: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var hurt_box: HurtBox = %HurtBox
@onready var walk: State_Walk = $"../Walk"
@onready var idle: State_Idle = $"../Idle"

# when the player enter this state
func Enter() -> void:
	attacking = true
#	update animation
	player.UpdateAnimation("attack")
	attack_animation_player.play("attack_" + player.animDirection() )
	
#	end state when animaiton end
	animation_player.animation_finished.connect(EndAttack)
	
	# add audio 
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true

# when the player exit this state
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	hurt_box.monitoring = false
	attacking = false
	pass
	
# what happen durring the state
func Process(_delta : float) -> State:	
	player.velocity -= player.velocity * deceleration * _delta
	
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
