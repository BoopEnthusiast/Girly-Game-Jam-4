extends Node2D


var _next_sprinkler: int = 0

@onready var sprinklers: Array[GlitterSprinkler] = [$GlitterSprinkler, $GlitterSprinkler2, $GlitterSprinkler3, $GlitterSprinkler4]


func _on_upgrade_sparkle_sprinkler() -> void:
	assert(_next_sprinkler < sprinklers.size())
	
	var new_sprinkler: GlitterSprinkler = sprinklers[_next_sprinkler]
	_next_sprinkler += 1
	
	new_sprinkler.visible = true
	new_sprinkler.emitting = true
	new_sprinkler.global_position = get_viewport_rect().get_center()


func _on_upgrade_sprinkler_size() -> void:
	for sprinkler: GlitterSprinkler in sprinklers:
		sprinkler.circle_size += 0.3


func _on_upgrade_sprinkler_spread() -> void:
	for sprinkler: GlitterSprinkler in sprinklers:
		sprinkler.glitter_rate += 0.5
