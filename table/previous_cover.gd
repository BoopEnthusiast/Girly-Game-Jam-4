extends Sprite2D


@onready var sub_viewport: SubViewport = $"../.."
@onready var screen: Camera2D = $"../Screen"


func _ready() -> void:
	position = get_window().size / 2.0


func _on_finished_covering() -> void:
	var viewport_texture: ViewportTexture = sub_viewport.get_texture()
	var image: Image = viewport_texture.get_image()
	texture = ImageTexture.create_from_image(image)
	scale = Vector2.ONE / screen.zoom
