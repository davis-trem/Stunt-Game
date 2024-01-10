class_name QTEManager
extends Control

enum TYPE {
	MASHING,
	QUICK_PRESS,
	RHYTHM,
	SIMON_SAYS,
	BALANCE,
}

enum DIFFICULTY {
	EASY = 6,
	MEDIUM = 8,
	HARD = 10,
}

@export var qte_type: TYPE
@export var qte_difficulty: DIFFICULTY

var required_skills
var injury_risk_level
var injury_risk_areas
var qte_buttons = []
var action_names = []
var wait_times = {
	TYPE.MASHING: 10,
	TYPE.SIMON_SAYS: 5,
}

signal event_finished(has_failed: bool)

@onready var timer = $Timer
@onready var timer_label = $TimerLabel
@onready var event_ended_dialog = $EventEndedDialog

var simon_says_list = []
var job_idx


# Called when the node enters the scene tree for the first time.
func _ready():
	qte_buttons = get_tree().get_nodes_in_group('qte_button')
	for index in qte_buttons.size():
		var button = qte_buttons[index]
		var action_name = 'qte_{0}'.format([index + 1])
		action_names.append(action_name)
		button.pressed.connect(func ():
			var event = InputEventAction.new()
			event.action = action_name
			event.pressed = true
			Input.parse_input_event(event)
		)
		# Every button should have a label as a child
		button.get_child(0).text = _get_action_button_text(action_name)
	
	event_ended_dialog.retry_button_pressed.connect(_handle_event_ended_dialog_retry_button_pressed)
	event_ended_dialog.quit_button_pressed.connect(_handle_event_ended_dialog_quit_button_pressed)
	
	timer.timeout.connect(_handle_timer_timeout)
	
	# wait for all scene sizes to be set
	await get_tree().create_timer(0.001).timeout
	
	match qte_type:
		TYPE.MASHING:
			_start_mashing_event()
		TYPE.SIMON_SAYS:
			_start_simon_says_event()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if event_ended_dialog.visible:
		return

	timer_label.text = str(int(timer.time_left))
	
	match qte_type:
		TYPE.MASHING:
			$VBoxContainer/ProgressBar.value -= 42 * delta


func _input(event):
	if event_ended_dialog.visible:
		return

	match qte_type:
		TYPE.MASHING:
			_mash_button(event)
		TYPE.SIMON_SAYS:
			_simon_says_input(event)


func _mash_button(event: InputEvent):
	if event.is_action_pressed('qte_1'):
		$VBoxContainer/ProgressBar.value += 10


func _start_mashing_event():
	var target_mashing_size = randi_range(
		$VBoxContainer/ProgressBar.size.x * 0.11,
		$VBoxContainer/ProgressBar.size.x * 0.21,
	)
	($TargetRect as ColorRect).custom_minimum_size.x = target_mashing_size
	
	var target_mashing_pos = randf_range(
		($VBoxContainer/ProgressBar.size.x / 2) - (target_mashing_size / 2),
		$VBoxContainer/ProgressBar.size.x - (target_mashing_size / 2),
	)
	($TargetRect as ColorRect).position.x = target_mashing_pos
	
	$VBoxContainer/ProgressBar.value = 0
	timer.wait_time = wait_times[TYPE.MASHING]
	timer.start()


func _simon_says_input(event: InputEvent):
	if simon_says_list.is_empty():
		return
	
	if event.is_action_pressed('qte_1') or event.is_action_pressed('qte_2') or event.is_action_pressed('qte_3'):
		if event.is_action_pressed(simon_says_list[0]):
			simon_says_list.pop_front()
			if simon_says_list.is_empty():
				timer.stop()
				event_finished.emit(false)
				event_ended_dialog.show_dialog(false)
		else:
			timer.stop()
			event_finished.emit(true)
			event_ended_dialog.show_dialog(true)


func _start_simon_says_event():
	timer.wait_time = wait_times[TYPE.SIMON_SAYS]
	simon_says_list = []
	for i in 5:
		var random_action = action_names[randi() % action_names.size()]
		simon_says_list.append(random_action)
	$VBoxContainer/Label.text = 'Remember ' + ', '.join(
		simon_says_list.map(func (action): return _get_action_button_text(action))
	)
	get_tree().paused = true
	await get_tree().create_timer(3.0).timeout
	get_tree().paused = false
	$VBoxContainer/Label.text = 'Enter combination!'
	timer.start()


func _handle_event_ended_dialog_retry_button_pressed():
	match qte_type:
		TYPE.MASHING:
			_start_mashing_event()
		TYPE.SIMON_SAYS:
			_start_simon_says_event()


func _handle_event_ended_dialog_quit_button_pressed():
	var did_succeed = _calculate_if_success()
	var potential_injured_body_part = _apply_protential_injury()
	if potential_injured_body_part != null:
		pass # TODO: Show user what's injured
	if did_succeed:
		GameState.player_stats.money += GameState.job_list[job_idx]["payout"]
	GameState.proceedToNextRound()
	var scene = preload("res://scenes/bedroom.tscn").instantiate()
	GameState.scene_swapper(scene)


func _handle_timer_timeout():
	timer.stop()
	match qte_type:
		TYPE.MASHING:
			var value = $VBoxContainer/ProgressBar.size.x * ($VBoxContainer/ProgressBar.value / 100)
			var target_pos = ($TargetRect as ColorRect).position.x
			var target_size = ($TargetRect as ColorRect).size.x
			var is_in_range = target_pos <= value && value <= (target_pos + target_size)
			event_finished.emit(not is_in_range)
			event_ended_dialog.show_dialog(not is_in_range)
		TYPE.SIMON_SAYS:
			event_finished.emit(true)
			event_ended_dialog.show_dialog(true)


func _get_action_button_text(action_name: String) -> String:
	var input_events = InputMap.action_get_events(action_name)
	# TODO: get input event by OS
	return input_events[0].as_text().split(' ')[0]


func _calculate_if_success() -> bool:
	var skill_check = 1
	for required_skill in required_skills:
		if GameState.get_player_skill(required_skill['type']) < required_skill['value']:
			skill_check = -2
			break
	
	var qte_score = 6 # TODO: Determine score for qte
	
	var chance = randi_range(1, 4) + skill_check + qte_score
	return chance > qte_difficulty


func _apply_protential_injury():
	var is_injured = randi_range(1, 2) == 1
	if is_injured:
		var body_type = injury_risk_areas[randi() % injury_risk_areas.size()]
		GameState.set_player_body_health(
			body_type,
			GameState.get_player_body_health(body_type) - injury_risk_level
		)
		return body_type
	return null
