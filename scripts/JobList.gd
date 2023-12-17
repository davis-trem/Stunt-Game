extends GridContainer

var job_list = [
		{
			"id": 1,
			"job_title": "Jump over a shark",
			"job_requirements": "Clear over a shark with a motorcycle",
			"job_payout": 500,
		},
		{
			"id": 2,
			"job_title": "Building Dive",
			"job_requirements": "Dive from a 500ft building",
			"job_payout": 1500,
		},
		{
			"id": 3,
			"job_title": "Fight Scene",
			"job_requirements": "Fight 10 mean",
			"job_payout": 750,
		},
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for job in job_list:
		var scene = load("res://job_posting.tscn")
		var instance = scene.instantiate()
		instance.get_node("JobName").text = job["job_title"]
		instance.get_node("JobRequest").text = job["job_requirements"]
		instance.get_node("JobPayout").text = str(job["job_payout"])	
		instance.name = "jobposting_" + str(job["id"])
		instance.job_id = job["id"] 
		add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
