extends PanelContainer


const INPUT_RESPONSE = preload("res://scenes/input_response.tscn")


@export var max_lines_remebered = 30


var max_scroll_length := 0
var should_zebra := false

@onready var scroll = $Scroll
@onready var scrollbar = scroll.get_v_scroll_bar()
@onready var history_rows = $Scroll/HistoryRows


func _ready() -> void:
	scrollbar.connect("changed", _handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value


func create_response(response_text: String):
	var response = INPUT_RESPONSE.instantiate()
	_add_response_to_game(response)
	response.set_text(response_text)


func create_response_with_input(response_text: String, input_text: String):
	var input_response = INPUT_RESPONSE.instantiate()
	_add_response_to_game(input_response)
	input_response.set_text(response_text, input_text)


func _handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length


func _delete_history_beyond_limit():
	# Counts rows if more than max_lines_remebered deletes oldest rows
	if history_rows.get_child_count() > max_lines_remebered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remebered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()


func _add_response_to_game(response: Control):
	history_rows.add_child(response)
	if not should_zebra:
		response.zebra.hide()
	should_zebra = !should_zebra
	_delete_history_beyond_limit()
