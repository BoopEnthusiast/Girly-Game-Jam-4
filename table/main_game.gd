class_name MainGame
extends Node2D


@onready var covering_texture: CoveringTexture = $CoveringTexture
@onready var glitter_manager: Node2D = $GlitterManager
@onready var screen: Camera2D = $Screen

@onready var upgrade_screen: UpgradeScreen = $UI/UpgradeScreen
@onready var open_upgrade: Button = $UI/OpenUpgrade


func _ready() -> void:
	var viewport_size: Vector2 = get_viewport_rect().size * screen.zoom
	screen.position = viewport_size / 2.0


func open_upgrade_screen() -> void:
	upgrade_screen.visible = true
	glitter_manager.active_glitter_emitter.emitting = false
	open_upgrade.visible = false


func _on_covering_finished() -> void:
	screen.zoom /= 1.1
	covering_texture.setup_new_layer()
	upgrade_screen.points += 1
	glitter_manager.change_color_and_icon()
	glitter_manager.rotate_glitter_emitter()


func _on_hide_upgrade_screen() -> void:
	upgrade_screen.visible = false
	open_upgrade.visible = true
