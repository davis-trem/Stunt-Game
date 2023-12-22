extends Node2D

@onready var Player

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = self.get_node("Player")
	Player.get_node('PlayerAnimation').play("run")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
