extends Control


@onready var game_info = $Background/MarginContainer/Columns/Rows/GameInfo
@onready var command_processor = $CommandProcessor
@onready var room_manager = $RoomManager
@onready var player = $Player


func _ready() -> void:
	var side_panel = $Background/MarginContainer/Columns/SidePanel
	command_processor.room_changed.connect(Callable(side_panel, "handle_room_changed"))
	command_processor.room_updated.connect(Callable(side_panel, "handle_room_updated"))
	
	game_info.create_response(Types.wrap_system_text("Welcome to the unnamed text adventure! You can type 'help' to see available commands."))
	
	var starting_room_response = command_processor.initialize(room_manager.get_child(0), player)
	game_info.create_response(starting_room_response)


func _on_input_text_submitted(new_text: String) -> void:
	# If user tries to give empty input
	if new_text.is_empty():
		return
	
	var response = command_processor.process_command(new_text)
	game_info.create_response_with_input(response, new_text)
