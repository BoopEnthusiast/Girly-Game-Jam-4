@tool
class_name UpgradeOld
extends GraphElement


signal pressed()


@export_multiline() var text: String = "Upgrade":
	set(value):
		text = value
		button.text = value
@export var cost: int = 1:
	set(value):
		cost = value
		cost_label.text = "Cost: %d" % value
@export var max_levels: int = 1:
	set(value):
		max_levels = value
		levels_label.text = "%d/%d" % [level, value]

var level: int = 1:
	set(value):
		level = value
		levels_label.text = "%d/%d" % [value, max_levels]

var vertical_list: VBoxContainer
var button: Button
var level_cost_box: HBoxContainer
var cost_label: Label
var levels_label: Label


func _init() -> void:
	vertical_list = VBoxContainer.new()
	add_child(vertical_list, false, Node.INTERNAL_MODE_FRONT)
	
	button = Button.new()
	vertical_list.add_child(button)
	button.text = text
	button.pressed.connect(pressed.emit)
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	level_cost_box = HBoxContainer.new()
	vertical_list.add_child(level_cost_box)
	level_cost_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	cost_label = Label.new()
	level_cost_box.add_child(cost_label)
	cost_label.text = "Cost: %d" % cost
	if max_levels > 1: # Only show levels if it has more than one
		cost_label.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		
		var separator := VSeparator.new()
		level_cost_box.add_child(separator)
		
		levels_label = Label.new()
		level_cost_box.add_child(levels_label)
		levels_label.text = "%d/%d" % [level, max_levels]
		levels_label.size_flags_horizontal = Control.SIZE_SHRINK_END
