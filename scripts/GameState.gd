extends Node

const QTEManager = preload('res://scripts/qte_manager.gd')

var money = 100
var round = 1
var health = {
	"head" : 10,
	"back": 10,
	"legs": 10,
	"arms": 10,
	"torso":10,
}
var current_scene

var job_list = [
	{
		"id": 1,
		"job_title": "Jump over a shark",
		"job_requirements": "Clear over a shark with a motorcycle",
		"job_payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
	},
	{
		"id": 2,
		"job_title": "Building Dive",
		"job_requirements": "Dive from a 500ft building",
		"job_payout": 1500,
		"qte_type": QTEManager.TYPE.MASHING,
	},
	{
		"id": 3,
		"job_title": "Fight Scene",
		"job_requirements": "Fight 10 mean",
		"job_payout": 750,
		"qte_type": QTEManager.TYPE.SIMON_SAYS,
	},
]
func proceedToNextRound():
	randomizeLifeEvents()
	round += 1
func scene_swapper(scene):
	get_tree().root.remove_child(current_scene)
	get_tree().root.add_child(scene)	
	current_scene.queue_free()
	current_scene = scene
	
func randomizeLifeEvents():
	pass #A function to generate life events
# Called when the node enters the scene tree for the first time.
func _ready():
	current_scene = get_node("/root/Bedroom")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
