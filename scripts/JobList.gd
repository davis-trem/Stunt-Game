extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in GameState.job_list.size():
		var job = GameState.job_list[i]
		var scene = load("res://scenes/job_posting.tscn")
		var instance = scene.instantiate()
		instance.get_node("JobName").text = job["job_title"]
		instance.get_node("JobRequest").text = job["job_requirements"]
		instance.get_node("JobPayout").text = str(job["job_payout"])	
		instance.name = "jobposting_" + str(job["id"])
		instance.job_idx = i
		add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
