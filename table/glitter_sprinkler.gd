class_name GlitterSprinkler
extends GPUParticles2D


const BLUR_CIRCLE = preload("uid://d2j0j2at25l4n")
const BASE_FORCE = 1.0
const BASE_CIRCLE_SIZE = 10.0

const MARGIN = 5.0

@export var starting_angle: float = 1.0

var circle_size: float = 1.0
var glitter_rate: float = 1.0
 
var _mat: ParticleProcessMaterial = process_material
var _starting_amount: float = amount
var _starting_velocity_max: float = process_material.initial_velocity_max

var _direction: Vector2 = Vector2.ZERO

@onready var covering_texture: CoveringTexture = $"../../../CoveringTexture"
@onready var screen: Camera2D = $"../../../Screen"


func _ready() -> void:
	_direction = Vector2.from_angle(PI / 4.0 * starting_angle)


func _process(delta: float) -> void:
	if visible:
		global_position += _direction
		
		var zoom: float = 1.0 / screen.zoom.x
		var size: Vector2 = get_viewport_rect().size
		var growth: Vector2 = Vector2(zoom * size.x - size.x, zoom * size.y - size.y) / 2.0
		var view_rect: Rect2 = get_viewport_rect().grow_individual(
				growth.x, growth.y, growth.x, growth.y)
		
		if global_position.x + MARGIN > view_rect.end.x:
			_direction = _direction.bounce(Vector2.LEFT)
		elif global_position.x - MARGIN < view_rect.position.x:
			_direction = _direction.bounce(Vector2.RIGHT)
		elif global_position.y + MARGIN > view_rect.end.y:
			_direction = _direction.bounce(Vector2.UP)
		elif global_position.y - MARGIN < view_rect.position.y:
			_direction = _direction.bounce(Vector2.DOWN)
	
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
