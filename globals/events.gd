extends Node


@warning_ignore("unused_signal")
signal show_error_on_touch(test: String)

var click_position: Vector2


func _input(event: InputEvent) -> void:
	# Mouse-based input
	if event is InputEventMouse:
		click_position = event.position
	# Touch-based input
	elif event is InputEventScreenTouch:
		click_position = event.position
	elif event is InputEventScreenDrag:
		click_position = event.position
