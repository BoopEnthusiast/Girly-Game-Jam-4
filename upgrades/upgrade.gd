@tool
class_name Upgrade
extends GraphElement


signal pressed(node: Upgrade)

@export_multiline var text: String = "Upgrade":
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
		if value > 1:
			level_label.visible = true
			cost_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		else:
			level_label.visible = false
			cost_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		level_label.text = "%d/%d" % [level, value]
@export var enabled: bool = true:
	set(value):
		enabled = value
		if not is_node_ready():
			await ready
		button.disabled = not value
@export var next_upgrades: Array[Upgrade]
@export var level_costs: Array[int]

var level: int = 0:
	set(value):
		level = value
		level_label.text = "%d/%d" % [value, max_level]

@onready var button: Button = $VBoxContainer/Button
@onready var cost_label: Label = $VBoxContainer/HBoxContainer/Cost
@onready var level_label: Label = $VBoxContainer/HBoxContainer/LevelLabel

@onready var animator: AnimationPlayer = $Animator


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	var screen: UpgradeScreen = get_parent().get_parent()
	pressed.connect(screen._on_upgrade_pressed)


func _on_button_pressed() -> void:
	pressed.emit(self)


func show_error(error: String) -> void:
	if Engine.is_editor_hint():
		return
	animator.play(&"error")
	Events.show_error_on_touch.emit(error)


func unlock_next_upgrades() -> void:
	for upgrade: Upgrade in next_upgrades:
		upgrade.enabled = true


func unlocked_max_upgrade() -> void:
	button.disabled = true
