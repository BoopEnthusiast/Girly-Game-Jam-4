extends Popup


@onready var label: Label = $PanelContainer/Label


func _ready() -> void:
	Events.show_error_on_touch.connect(_on_show_error)


func _on_show_error(text: String) -> void:
	visible = true
	size = Vector2.ONE
	label.text = text
	position = Vector2i(Events.click_position) - Vector2i(int(float(size.x) / 2.0), size.y)
