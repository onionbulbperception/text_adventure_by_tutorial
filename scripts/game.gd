extends Control


const Responce = preload("res://scenes/response.tscn")
const InputResponse = preload("res://scenes/input_response.tscn")


@export var max_lines_remebered = 30


var max_scroll_length := 0


@onready var command_processor = $CommandProcessor
@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
@onready var scroll = $Background/MarginContainer/Rows/GameInfo/Scroll
@onready var scrollbar = scroll.get_v_scroll_bar()


func _ready() -> void:
	scrollbar.connect("changed", handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value
	var starting_message = Responce.instantiate()
	starting_message.text = "You find yourself in a house, with no memory of how you got there. You need to find your way out. You can type 'help' to see your available commands."
	add_responce_to_game(starting_message)


func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length


func _on_input_text_submitted(new_text: String) -> void:
	# If user tries to give empty input
	if new_text.is_empty():
		return
	
	# Create instance of history rows and add a node to it as a child
	# Send info to command processor to handle the input
	var input_responce = InputResponse.instantiate()
	var responce = command_processor.process_command(new_text)
	input_responce.set_text(new_text, responce)
	add_responce_to_game(input_responce)


func add_responce_to_game(responce: Control):
	history_rows.add_child(responce)
	delete_history_beyond_limit()


func delete_history_beyond_limit():
	# Counts rows if more than max_lines_remebered deletes oldest rows
	if history_rows.get_child_count() > max_lines_remebered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remebered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
