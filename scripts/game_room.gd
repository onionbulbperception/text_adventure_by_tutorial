@tool
extends PanelContainer
class_name GameRoom


@export var room_name : String = "Room Name" : set = set_room_name
@export_multiline var room_description : String = "This is the description of the room." : set = set_room_description


var exits: Dictionary = {}


func set_room_name(new_name: String):
	$MarginContainer/Rows/RoomName.text = new_name
	room_name = new_name


func set_room_description(new_description: String):
	$MarginContainer/Rows/RoomDescription.text = new_description
	room_description = new_description


func connect_exit(direction: String, room: GameRoom):
	var exit = Exit.new()
	exit.room_1 = self
	exit.room_2 = room
	exits[direction] = exit
	match direction:
		"west":
			room.exits["east"] = exit
		"east":
			room.exits["west"] = exit
		"north":
			room.exits["south"] = exit
		"south":
			room.exits["north"] = exit
		_:
			printerr("Tried to connect invalid direction: %s", direction)
