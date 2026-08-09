class_name GlitterEmitter
extends GPUParticles2D


const BLUR_CIRCLE = preload("uid://d2j0j2at25l4n")
const BASE_FORCE = 1.5
const BASE_CIRCLE_SIZE = 15.0

var circle_size: float = 1.0
var glitter_rate: float = 1.0

var _mat: ParticleProcessMaterial = process_material
var _starting_amount_ratio: float = amount_ratio
var _starting_velocity_max: float = process_material.initial_velocity_max

@onready var covering_texture: CoveringTexture = $"../CoveringTexture"


func _ready() -> void:
	emitting = false


func _process(delta: float) -> void:
	# Change the drawable texture
	if emitting:
		var diameter: float = BASE_CIRCLE_SIZE * circle_size
		# Global position to the smaller resolution of the texture
		var pos: Vector2 = global_position / CoveringTexture.RESOLUTION_FACTOR
		# How much to impress on the texture, used to calculate pressure (force / area)
		var force: float = BASE_FORCE * glitter_rate * delta
		covering_texture.texture.blit_rect(
				Rect2i(Vector2i(pos - Vector2.ONE * (diameter / 2.0)),
				Vector2i.ONE * diameter), BLUR_CIRCLE,
				Color(1.0, 1.0, 1.0, force / circle_size))
	
	amount_ratio = glitter_rate * _starting_amount_ratio
	_mat.initial_velocity_max = _starting_velocity_max + circle_size * 15.0


func _unhandled_input(event: InputEvent) -> void:
	# Mouse-based input
	if event is InputEventMouse:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					emitting = true
				else:
					emitting = false
		global_position = get_global_mouse_position()
	# Touch-based input
	elif event is InputEventScreenTouch:
		if event.pressed:
			emitting = true
		else:
			emitting = false
		global_position = event.position
	elif event is InputEventScreenDrag:
		global_position = event.position


func _on_upgrade_more_glitter() -> void:
	glitter_rate += 0.5


func _on_upgrade_sparkle_further() -> void:
	circle_size += 0.5
