extends Panel

@onready var retry_button = $MarginContainer/VBoxContainer/HBoxContainer/RetryButton
@onready var quit_button = $MarginContainer/VBoxContainer/HBoxContainer/QuitButton
@onready var status_label = $MarginContainer/VBoxContainer/StatusLabel

signal retry_button_pressed
signal quit_button_pressed


func show_dialog(has_failed: bool, can_retry: bool = true):
	if has_failed:
		status_label.text = 'You suck ass'
		retry_button.visible = can_retry
	else:
		status_label.text = 'Good shit'
		retry_button.hide()
	show()


func _on_retry_button_pressed():
	hide()
	retry_button_pressed.emit()


func _on_quit_button_pressed():
	hide()
	quit_button_pressed.emit()
