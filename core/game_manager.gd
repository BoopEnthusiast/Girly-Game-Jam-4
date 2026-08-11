extends Node


@onready var main_menu: Control = $MainMenu
@onready var main_game_viewport_container: SubViewportContainer = $MainGame


func _ready() -> void:
	get_tree().paused = true


func _on_main_menu_play_pressed() -> void:
	get_tree().paused = false
	main_menu.visible = false
	main_game_viewport_container.visible = true
