extends Control


const InputResponse = preload("res://scenes/input_response.tscn")


@export var max_lines_remebered = 30


var max_scroll_length := 0


@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
@onready var scroll = $Background/MarginContainer/Rows/GameInfo/Scroll
@onready var scrollbar = scroll.get_v_scroll_bar()


func _ready() -> void:
	scrollbar.connect("changed", handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value


func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length


func _on_input_text_submitted(new_text: String) -> void:
	# If user tries to give empty input
	if new_text.is_empty():
		return
	
	# Create instance of history rows and add a node to it as a child
	# Godot 3.x, the PackedScene class had an instance()
	# Godot 4.x, the method name is now instantiate()
	var input_responce = InputResponse.instantiate()
	input_responce.set_text(new_text, "This is a response")
	history_rows.add_child(input_responce)
	
	# Counts rows if more than max_lines_remebered deletes oldest rows
	if history_rows.get_child_count() > max_lines_remebered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remebered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
