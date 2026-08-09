class_name MainGame
extends Node2D


@onready var covering_texture: CoveringTexture = $CoveringTexture
@onready var glitter_emitter: GlitterEmitter = $GlitterEmitter

@onready var upgrade_screen: UpgradeScreen = $UI/UpgradeScreen
@onready var open_upgrade: Button = $UI/OpenUpgrade


func _on_covering_finished() -> void:
	covering_texture.setup_new_layer()
	upgrade_screen.points += 1
	open_upgrade_screen()


func open_upgrade_screen() -> void:
	upgrade_screen.visible = true
	glitter_emitter.emitting = false
	open_upgrade.visible = false


func _on_hide_upgrade_screen() -> void:
	upgrade_screen.visible = false
	open_upgrade.visible = true
