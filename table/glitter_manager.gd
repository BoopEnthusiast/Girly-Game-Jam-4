class_name GlitterManager
extends Node2D


const ICONS: Array[DPITexture] = [
	preload("uid://daqyakmjcju0m"),
	preload("uid://8knc0ncwwmny"),
	preload("uid://bqfuyoax1on17"),
	preload("uid://bm4usp7cju78w"),
	preload("uid://dk56sg27k2scr"),
	preload("uid://bqfuyoax1on17"),
]

var active_glitter_emitter_index: int = 0
var active_glitter_emitter: GlitterEmitter:
	get():
		return glitter_emitters[active_glitter_emitter_index]

var glitter_rate: float = 1.0

var _starting_color := Color(1.0, 0.0, 1.0)
var _color_icon_increment: int = 0

var queue_rotate_emitter := false

@onready var glitter_emitters: Array[GlitterEmitter] = [$GlitterEmitter, $GlitterEmitter2, $GlitterEmitter3, $GlitterEmitter4, $GlitterEmitter5, $GlitterEmitter6]


func rotate_glitter_emitter() -> void:
	# Disactivate current one
	var was_emitting = active_glitter_emitter.emitting
	active_glitter_emitter.active = false
	
	# Get new one
	active_glitter_emitter_index += 1
	active_glitter_emitter_index %= glitter_emitters.size() - 1
	
	# Activate new one
	active_glitter_emitter.visible = true
	active_glitter_emitter.active = true
	active_glitter_emitter.emitting = was_emitting
	active_glitter_emitter.restart()
	# Set new color
	var new_hue: float = fmod(_starting_color.ok_hsl_h + (2.7 * _color_icon_increment), 1.0)
	var new_col := Color.from_ok_hsl(new_hue, _starting_color.ok_hsl_s, _starting_color.ok_hsl_l)
	new_col *= 2 ** 1
	new_col.a = 1.0
	active_glitter_emitter.modulate = new_col
	# Set new icon
	active_glitter_emitter.texture = ICONS[_color_icon_increment % ICONS.size()]
	# Activate new one
	active_glitter_emitter.glitter_rate = glitter_rate


func change_color_and_icon() -> void:
	_color_icon_increment += 1


func hide_all_emitters() -> void:
	for emitter: GlitterEmitter in glitter_emitters:
		emitter.visible = false


func _on_upgrade_more_glitter() -> void:
	glitter_rate += 1.0
	queue_rotate_emitter = true


func _on_upgrade_sparkle_further() -> void:
	for emitter: GlitterEmitter in glitter_emitters:
		emitter.circle_size += 0.3
