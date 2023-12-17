extends Node2D

var job_id



# Called when the node enters the scene tree for the first time.
func _ready():
	generate_job(job_id)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_job(job_id):
	#Add in function that searches for background and job settings based on ID
	print(job_id)
	pass
