extends Node


var current_room = null


func initialize(starting_room) -> String:
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
		"help":
			return help()
		_:
			return "Unrecognized command - please try again."
			


func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
		
	if current_room.exits.keys().has(second_word):
		var change_response = change_room(current_room.exits[second_word])
		var response_strings = PackedStringArray(["You go %s." % second_word, change_response])
		var response_string = "\n".join(response_strings)
		return response_string
	else:
		return "This room has no exit in that direction."


func help() -> String:
	return "You can use these commands: go [location], help"

func change_room(new_room: GameRoom) -> String:
	current_room = new_room
	var exit_string = PackedStringArray(new_room.exits.keys())
	var exits = " ".join(exit_string)
	var strings = PackedStringArray([
		"You are now in: " + new_room.room_name + ". It is " + new_room.room_description,
		"Exits: " + exits,
	])
	var string = "\n".join(strings)
	return string
