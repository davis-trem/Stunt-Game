extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("HUD").get_node("MoneyAmount").text = "Money $" + str(GameState.player_stats.money)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
