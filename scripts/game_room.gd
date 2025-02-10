extends PanelContainer
class_name GameRoom


@export var room_name = "Room Name"
@export var room_description = "This is the description of the room."


var exits: Dictionary = {}


func connect_exit(direction: String, room: GameRoom):
	match direction:
		"west":
			exits[direction] = room
			room.exits["east"] = self
		"east":
			exits[direction] = room
			room.exits["west"] = self
		"north":
			exits[direction] = room
			room.exits["south"] = self
		"south":
			exits[direction] = room
			room.exits["north"] = self
		_:
			printerr("Tried to connect invalid direction: %s", direction)
