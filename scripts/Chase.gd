extends Node2D

@onready var player_animation = $Player/AnimationPlayer
@onready var bear_animation = $Bear/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	player_animation.play("run")
	bear_animation.play("chase")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
