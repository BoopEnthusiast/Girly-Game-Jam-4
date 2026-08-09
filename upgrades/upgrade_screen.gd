class_name UpgradeScreen
extends Control


signal sparkle_further()
signal more_glitter()
signal hide_screen()
signal points_updated(points: int)

var points: int = 0:
	set(value):
		points = value
		points_updated.emit(value)


func _on_sparkle_further_pressed() -> void:
	sparkle_further.emit()
	_hide_screen()


func _on_more_glitter_pressed() -> void:
	more_glitter.emit()
	_hide_screen()


func _hide_screen() -> void:
	hide_screen.emit()
