class_name GlitterEmitter
extends GPUParticles2D


const BLUR_CIRCLE = preload("uid://d2j0j2at25l4n")
const BASE_FORCE = 1.5
const BASE_CIRCLE_SIZE = 15.0

@export var active: bool = true:
	set(value):
		active = value
		if not value:
			emitting = false

var circle_size: float = 1.0
var glitter_rate: float = 1.0

var _mat: ParticleProcessMaterial = process_material
var _starting_amount: float = amount
var _starting_velocity_max: float = process_material.initial_velocity_max

@onready var covering_texture: CoveringTexture = $"../../CoveringTexture"
@onready var glitter_manager: GlitterManager = $".."


func _ready() -> void:
	emitting = false


func _process(delta: float) -> void:
	# Change the drawable texture
	if emitting:
		var diameter: float = BASE_CIRCLE_SIZE * circle_size
		# Global position to the smaller resolution of the texture
		var pos: Vector2 = global_position - covering_texture.position
		pos /= CoveringTexture.RESOLUTION_FACTOR
		# How much to impress on the texture, used to calculate pressure (force / area)
		var force: float = BASE_FORCE * glitter_rate * delta
		covering_texture.texture.blit_rect(
				Rect2i(Vector2i(pos - Vector2.ONE * (diameter / 2.0)),
				Vector2i.ONE * diameter), BLUR_CIRCLE,
				Color(1.0, 1.0, 1.0, force / circle_size))
	
	amount = int(glitter_rate * _starting_amount)
	_mat.initial_velocity_max = _starting_velocity_max + circle_size * 15.0


func _unhandled_input(event: InputEvent) -> void:
	# Mouse-based input
	if event is InputEventMouse:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed and active:
					if glitter_manager.queue_rotate_emitter:
						glitter_manager.queue_rotate_emitter = false
						glitter_manager.rotate_glitter_emitter()
					emitting = true
				else:
					emitting = false
		global_position = get_global_mouse_position()
	# Touch-based input
	elif event is InputEventScreenTouch:
		if event.pressed and active:
			if glitter_manager.queue_rotate_emitter:
				glitter_manager.queue_rotate_emitter = false
				glitter_manager.rotate_glitter_emitter()
		else:
			emitting = false
		global_position = event.position
	elif event is InputEventScreenDrag:
		global_position = event.position
