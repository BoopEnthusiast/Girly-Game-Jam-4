class_name MainGame
extends Node2D


signal covering_finishing()


@onready var covering_texture: CoveringTexture = $CoveringTexture
@onready var glitter_manager: GlitterManager = $GlitterManager
@onready var screen: Camera2D = $Screen
@onready var table_background: Sprite2D = $"../../CanvasLayer/TableBackground"

@onready var upgrade_screen: UpgradeScreen = $"../../UI/UpgradeScreen"
@onready var open_upgrade: Button = $"../../UI/OpenUpgrade"


func _ready() -> void:
	var viewport_size: Vector2 = get_viewport_rect().size * screen.zoom
	screen.position = viewport_size / 2.0


func open_upgrade_screen() -> void:
	upgrade_screen.visible = true
	glitter_manager.active_glitter_emitter.emitting = false
	open_upgrade.visible = false


func _on_covering_finished() -> void:
	await RenderingServer.frame_post_draw
	covering_finishing.emit()
	screen.zoom /= 1.05
	table_background.scale = screen.zoom
	covering_texture.setup_new_layer()
	upgrade_screen.points += 1
	glitter_manager.hide_all_emitters()
	glitter_manager.change_color_and_icon()
	glitter_manager.rotate_glitter_emitter()


func _on_hide_upgrade_screen() -> void:
	upgrade_screen.visible = false
	open_upgrade.visible = true
