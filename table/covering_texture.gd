class_name CoveringTexture
extends Sprite2D


var luminance: float = 1.0

@onready var progress_bar: ProgressBar = $ProgressBar


func _ready() -> void:
	setup_new_layer()


func setup_new_layer():
	var viewport_size: Vector2 = get_viewport_rect().size
	var size := Vector2i(viewport_size / 8.0)
	
	var drawable := DrawableTexture2D.new()
	drawable.setup(size.x, size.y, DrawableTexture2D.DRAWABLE_FORMAT_RGBAF)
	#_texture_mutex.lock()
	texture = drawable
	#_texture_mutex.unlock()


func _on_check_cover_timeout() -> void:
	# Get texture image
	var image: Image = texture.get_image()
	
	var pixels: PackedColorArray = image.get_data().to_color_array()
	var lum: float = 0.0
	
	for color: Color in pixels:
		lum += color.get_luminance()
	
	lum /= image.get_size().x * image.get_size().y
	print(lum)
	luminance = lum
	progress_bar.value = luminance
