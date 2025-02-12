extends Node


var current_room = null
var player = null


func initialize(starting_room, player) -> String:
	self.player = player
	return change_room(starting_room)


func process_command(input: String) -> String:
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error: no words were parsed!"
	
	var first_first = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
	
	match first_first:
		"go":
			return go(second_word)
		"take":
			return take(second_word)
		"drop":
			return drop(second_word)
		"inventory":
			return inventory()
		"help":
			return help()
		_:
			return "Unrecognized command - please try again."
			


func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
		
	if current_room.exits.keys().has(second_word):
		var exit = current_room.exits[second_word]
		var change_response = change_room(exit.get_other_room(current_room))
		var response_strings = PackedStringArray(["You go %s." % second_word, change_response])
		var response_string = "\n".join(response_strings)
		return response_string
	else:
		return "This room has no exit in that direction."


func take(second_word: String) -> String:
	if second_word == "":
		return "Take what?"
	for item in current_room.items:
		if second_word.to_lower() == item.item_name.to_lower():
			current_room.remove_item(item)
			player.take_item(item)
			return "You take the " + item.item_name
	return "There is no item like that in this room."


func drop(second_word) -> String:
	if second_word == "":
		return "Drop what?"
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			player.drop_item(item)
			current_room.add_item(item)
			return "You drop the " + item.item_name
	return "You don't have that item."


func inventory() -> String:
	return player.get_inventory_list()


func help() -> String:
	return "You can use these commands: go [location], take [item], drop [item], inventory, help"

func change_room(new_room: GameRoom) -> String:
	current_room = new_room
	#var exit_string = PackedStringArray(new_room.exits.keys())
	#var exits = " ".join(exit_string)
	#var strings = PackedStringArray([
	#	"You are now in: " + new_room.room_name + ". It is " + new_room.room_description,
	#	"Exits: " + exits,
	#])
	#var string = "\n".join(strings)
	return new_room.get_full_description()
