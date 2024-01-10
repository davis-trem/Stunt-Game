extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in GameState.job_list.size():
		var job = GameState.job_list[i]
		var scene = load("res://scenes/job_posting.tscn")
		var instance = scene.instantiate()
		instance.get_node("JobRequest").text = job["description"]
		instance.get_node("JobPayout").text = str(job["payout"])	
		instance.name = "jobposting_" + str(i)
		instance.job_idx = i
		instance.qte_type = job["qte_type"]
		instance.qte_difficulty = job["qte_difficulty"]
		instance.required_skills = job["required_skills"]
		instance.injury_risk_level = job["injury_risk_level"]
		instance.injury_risk_areas = job["injury_risk_areas"]
		add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
