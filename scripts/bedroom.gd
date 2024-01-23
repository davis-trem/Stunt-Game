extends Node

@onready var job_list_container: TextureRect = $JobListContainer
@onready var money_amount: Label = $MoneyAmount


# Called when the node enters the scene tree for the first time.
func _ready():
	money_amount.text = "Money $" + str(GameState.player_stats.money)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_display_job_button_pressed() -> void:
	job_list_container.show()
