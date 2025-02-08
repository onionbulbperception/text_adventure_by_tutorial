extends Control


const InputResponse = preload("res://scenes/input_response.tscn")


@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows


func _on_input_text_submitted(_new_text: String) -> void:
	# Create instance of history rows and add a node to it as a child
	# Godot 3.x, the PackedScene class had an instance()
	# Godot 4.x, the method name is now instantiate()
	var input_responce = InputResponse.instantiate()
	history_rows.add_child(input_responce)
