extends Node


@onready var main_menu: Control = $MainMenu
@onready var main_game: Node2D = $MainGame


func _ready() -> void:
	get_tree().paused = true


func _on_main_menu_play_pressed() -> void:
	get_tree().paused = false
	main_menu.visible = false
	main_game.visible = true
