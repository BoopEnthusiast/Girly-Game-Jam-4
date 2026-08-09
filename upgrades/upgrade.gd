@tool
class_name Upgrade
extends GraphElement


signal pressed()

@export_multiline var text: String:
	set(value):
		text = value
		if not is_node_ready():
			await ready
		button.text = value
@export var cost: int = 1:
	set(value):
		cost = value
		if not is_node_ready():
			await ready
		cost_label.text = "Cost: %d" % value
@export_range(1, 10) var max_level: int:
	set(value):
		max_level = value
		if not is_node_ready():
			await ready
		level_label.visible = true if value > 1 else false
		level_label.text = "%d/%d" % [level, value]

var level: int = 0:
	set(value):
		level = value
		level_label.text = "%d/%d" % [value, max_level]

@onready var button: Button = $VBoxContainer/Button
@onready var cost_label: Label = $VBoxContainer/HBoxContainer/Cost
@onready var level_label: Label = $VBoxContainer/HBoxContainer/LevelLabel


func _on_button_pressed() -> void:
	pressed.emit()
