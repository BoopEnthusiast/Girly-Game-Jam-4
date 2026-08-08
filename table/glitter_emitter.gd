class_name GlitterEmitter
extends GPUParticles2D


const BLUR_CIRCLE = preload("uid://d2j0j2at25l4n")
const CIRCLE_SIZE = 15

@onready var covering_texture: CoveringTexture = $"../CoveringTexture"


func _process(delta: float) -> void:
	if emitting:
		var drawable: DrawableTexture2D = covering_texture.texture
		drawable.blit_rect(Rect2i(Vector2i(global_position / 8.0 - Vector2.ONE * (CIRCLE_SIZE / 2.0)),
				Vector2i.ONE * CIRCLE_SIZE), BLUR_CIRCLE, Color(1.0, 1.0, 1.0, 2.0 * delta))


func _input(event: InputEvent) -> void:
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
