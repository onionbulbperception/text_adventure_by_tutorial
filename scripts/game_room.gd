@tool
extends PanelContainer
class_name GameRoom


@export var room_name : String = "Room Name" : set = set_room_name
@export_multiline var room_description : String = "This is the description of the room." : set = set_room_description


var exits: Dictionary = {}
var items: Array = []


func set_room_name(new_name: String):
	$MarginContainer/Rows/RoomName.text = new_name
	room_name = new_name


func set_room_description(new_description: String):
	$MarginContainer/Rows/RoomDescription.text = new_description
	room_description = new_description


func add_item(item: Item):
	items.append(item)


func get_full_description() -> String:
	var description = PackedStringArray([
		get_room_description(),
		get_item_description(),
		get_exit_description(),
	])
	var full_description = "\n".join(description)
	return full_description


func get_room_description() -> String:
	return "You are now in: " + room_name + ". It is " + room_description


func get_item_description() -> String:
	if items.size() == 0:
		return "No items to pick up."
	
	var item_string = ""
	for item in items:
		item_string += item.item_name + " "
	
	return "Items: " + item_string


func get_exit_description() -> String:
	var exit_string = PackedStringArray(exits.keys())
	return "Exits: " +  " ".join(exit_string)


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
