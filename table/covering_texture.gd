class_name CoveringTexture
extends Sprite2D


var luminance: float = 1.0
#var _lum_lock := Mutex.new()
#
#var _update_thread := Thread.new()
#var _update_semaphore := Semaphore.new()
#var _deletion_mutex := Mutex.new()
#var _should_delete := false
#var _texture_mutex := Mutex.new()

@onready var progress_bar: ProgressBar = $ProgressBar


func _ready() -> void:
	#_update_thread.start(_update_cover_threaded)
	setup_new_layer()


#func _exit_tree() -> void:
	#_deletion_mutex.lock()
	#_should_delete = true
	#_deletion_mutex.unlock()
	#_update_semaphore.post()
	#_update_thread.wait_to_finish()


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
	#return
	#_update_semaphore.post()
	#_lum_lock.lock()
	#progress_bar.value = luminance
	#_lum_lock.unlock()
#
#
#func _update_cover_threaded() -> void:
	#while true:
		## Wait until it should update
		#_update_semaphore.wait()
		#
		## Check if it should be deleted
		#_deletion_mutex.lock()
		#var should_delete: bool = _should_delete
		#_deletion_mutex.unlock()
		#if should_delete:
			#return
		#
		## Get texture image
		#_texture_mutex.lock()
		#var image: Image = texture.get_image()
		#_texture_mutex.unlock()
		#
		#var pixels: PackedColorArray = image.get_data().to_color_array()
		#var lum: float = 0.0
		#
		#for color: Color in pixels:
			#lum += color.get_luminance()
		#
		#lum /= image.get_size().x * image.get_size().y
		#print(lum)
		#_lum_lock.lock()
		#luminance = lum
		#_lum_lock.unlock()
