class_name UpgradeScreen
extends Control


signal sparkle_further()
signal more_glitter()
signal sparkle_sprinkler()
signal sprinkler_size()
signal sprinkler_spread()

signal hide_screen()
signal points_updated(points: int)

var points: int = 0:
	set(value):
		points = value
		points_updated.emit(value)


func _on_upgrade_pressed(upgrade: Upgrade) -> void:
	print("Upgraded: " + upgrade.name)
	if points < upgrade.cost:
		upgrade.show_error("Not enough upgrade points")
		return
	points -= upgrade.cost
	
	match upgrade.name:
		&"SparkleFurther":
			sparkle_further.emit()
		&"MoreGlitter":
			more_glitter.emit()
		&"SparkleSprinkler":
			sparkle_sprinkler.emit()
		&"SprinklerSize":
			sprinkler_size.emit()
		&"SprinklerSpread":
			sprinkler_spread.emit()
	
	upgrade.level += 1
	if upgrade.level >= upgrade.max_level:
		upgrade.unlocked_max_upgrade()
	upgrade.unlock_next_upgrades()
	if not upgrade.level_costs.is_empty() and upgrade.level < upgrade.level_costs.size():
		upgrade.cost = upgrade.level_costs[upgrade.level]


func _hide_screen() -> void:
	hide_screen.emit()


func _on_close_upgrade_pressed() -> void:
	_hide_screen()
