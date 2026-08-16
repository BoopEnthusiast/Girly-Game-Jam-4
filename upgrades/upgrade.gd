@tool
class_name Upgrade
extends GraphElement


signal pressed(node: Upgrade)

@export_category("Pretty")
@export_tool_button("Update icon") var update_icon: Callable = _update_icon
@export var icon: Texture2D:
	set(value):
		icon = value
		if not is_node_ready():
			await ready
		button.icon = value
		var styleboxes: Dictionary[StringName, StyleBoxTexture] = {
			&"normal": button.get_theme_stylebox(&"normal"),
			&"pressed": button.get_theme_stylebox(&"pressed"),
			&"hover": button.get_theme_stylebox(&"hover"),
			&"disabled": button.get_theme_stylebox(&"disabled"),
		}
		for stylebox: StringName in styleboxes:
			button.remove_theme_stylebox_override(stylebox)
		for stylebox: StringName in styleboxes:
			var new_stylebox: StyleBoxTexture = styleboxes[stylebox].duplicate()
			new_stylebox.texture = value
			new_stylebox.region_rect = Rect2(Vector2(-10.0, -10.0), value.get_size())
			button.add_theme_stylebox_override(stylebox, new_stylebox)
		button.custom_minimum_size = value.get_size() / 8.0
		aspect_ratio_container.ratio = value.get_size().aspect()
@export_range(0, 4) var cost_texture_index: int = 0:
	set(value):
		cost_texture_index = value
		if not is_node_ready():
			await ready
		var tex: AtlasTexture = cost_texture.texture.duplicate()
		tex.region.position.x = 2000.0 + value * 400.0
		cost_texture.texture = tex

@export_category("Actual stuff")
@export_range(0, 9) var cost: int = 1:
	set(value):
		cost = value
		if not is_node_ready():
			await ready
		var tex: AtlasTexture = cost_num.texture.duplicate()
		tex.region.position.x = 20.0 + value * 150.0
		cost_num.texture = tex
@export_range(1, 9) var max_level: int:
	set(value):
		max_level = value
		if not is_node_ready():
			await ready
		if value > 1:
			level_num.visible = true
			slash.visible = true
			level_max.visible = true
			cost_num.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			cost_texture.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		else:
			level_num.visible = false
			slash.visible = false
			level_max.visible = false
			cost_num.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN | Control.SIZE_EXPAND
			cost_texture.size_flags_horizontal = Control.SIZE_SHRINK_END | Control.SIZE_EXPAND
		var tex: AtlasTexture = level_max.texture.duplicate()
		tex.region.position.x = 20.0 + value * 150.0
		level_max.texture = tex
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
		if not is_node_ready():
			await ready
		var tex: AtlasTexture = level_num.texture.duplicate()
		tex.region.position.x = 20.0 + value * 150.0
		level_num.texture = tex

@onready var button: Button = $VBoxContainer/AspectRatioContainer/Button
@onready var aspect_ratio_container: AspectRatioContainer = $VBoxContainer/AspectRatioContainer
@onready var cost_texture: TextureRect = $VBoxContainer/HBoxContainer/CostTexture
@onready var cost_num: TextureRect = $VBoxContainer/HBoxContainer/CostNum
@onready var level_num: TextureRect = $VBoxContainer/HBoxContainer/LevelNum
@onready var slash: TextureRect = $VBoxContainer/HBoxContainer/Slash
@onready var level_max: TextureRect = $VBoxContainer/HBoxContainer/LevelMax

@onready var animator: AnimationPlayer = $Animator


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	var screen: UpgradeScreen = get_parent().get_parent()
	pressed.connect(screen._on_upgrade_pressed)
	print(size)
	size = Vector2.ZERO
	print(size)


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


func _update_icon() -> void:
	self.icon = icon
