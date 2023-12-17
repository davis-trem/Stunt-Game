extends Node2D

var job_idx

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_job(job_idx)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_job(job_idx):
	#Add in function that searches for background and job settings based on ID
	print(job_idx)
	pass

#TEMP FUNCTION TO TEST PROCEEDING ROUNDS
func _on_texture_rect_gui_input(event):
	if  event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameState.money += GameState.job_list[job_idx]["job_payout"]
		print(GameState.round)
		GameState.proceedToNextRound()
		print(GameState.round)
		var scene = preload("res://bedroom.tscn").instantiate()
		GameState.scene_swapper(scene)
