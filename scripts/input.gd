extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Focus on the input field
	grab_focus()


func _on_text_submitted(_new_text: String) -> void:
	# Clear the input field
	clear()
