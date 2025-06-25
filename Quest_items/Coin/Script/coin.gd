extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var ID : String =  ""
@export var Name : String = ""
@export var Amount : int = 1
@export var item_con = Texture2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		sprite_2d.texture = item_con


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
