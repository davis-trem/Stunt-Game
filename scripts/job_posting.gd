extends GridContainer

var job_id

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _gui_input(event):
	if  event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var scene = preload("res://Job.tscn").instantiate()
		scene.job_id = job_id
		get_tree().root.add_child(scene)
		get_node("/root/Bedroom").free()
		
