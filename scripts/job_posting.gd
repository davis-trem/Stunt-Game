extends GridContainer

const QTEManager = preload('res://scripts/qte_manager.gd')
const QTE_MASHING = preload('res://scenes/qte_mashing.tscn')
const QTE_SIMON_SAYS = preload('res://scenes/qte_simon_says.tscn')

const QTE_TYPE_TO_SCENE = {
	QTEManager.TYPE.MASHING: QTE_MASHING,
	QTEManager.TYPE.SIMON_SAYS: QTE_SIMON_SAYS,
}

var job_idx
var qte_type: QTEManager.TYPE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _gui_input(event):
	if  event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var scene = QTE_TYPE_TO_SCENE[qte_type].instantiate()
		scene.job_idx = job_idx
		GameState.scene_swapper(scene)
		
