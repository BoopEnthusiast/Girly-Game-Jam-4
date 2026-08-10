class_name CoveringTexture
extends Sprite2D


signal finished_covering()

const RESOLUTION_FACTOR = 8.0
const LUMINANCE_CUTOFF = 0.99

var luminance: float = 1.0

@onready var progress_bar: ProgressBar = $"../UI/ProgressBar"
@onready var screen: Camera2D = $"../Screen"


func _ready() -> void:
	setup_new_layer()
	scale = Vector2.ONE * RESOLUTION_FACTOR
	progress_bar.min_value = LUMINANCE_CUTOFF


func setup_new_layer():
	var viewport_size: Vector2 = get_viewport_rect().size * (1.0 / screen.zoom.x)
	var texture_size := Vector2i(viewport_size / RESOLUTION_FACTOR)
	position = (get_viewport_rect().size - viewport_size) / 2.0
	
	var drawable := DrawableTexture2D.new()
	drawable.setup(texture_size.x, texture_size.y, DrawableTexture2D.DRAWABLE_FORMAT_RGBAF)
	texture = drawable


func _on_check_cover_timeout() -> void:
	# Get texture image
	var image: Image = texture.get_image()
	
	var pixels: PackedColorArray = image.get_data().to_color_array()
	var lum: float = 0.0
	
	for color: Color in pixels:
		lum += color.get_luminance()
	
	lum /= image.get_size().x * image.get_size().y
	luminance = lum
	progress_bar.value = abs(luminance - 1.0) + LUMINANCE_CUTOFF
	if luminance <= LUMINANCE_CUTOFF:
		finished_covering.emit()
