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
		"use":
			return use(second_word)
		"talk":
			return talk(second_word)
		"give":
			return give(second_word)
		"help":
			return help()
		_:
			return "Unrecognized command - please try again."


func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
		
	if current_room.exits.keys().has(second_word):
		var exit = current_room.exits[second_word]
		if exit.is_locked:
			return "The way %s is currently locked!" % second_word
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


func use(second_word) -> String:
	if second_word == "":
		return "Use what?"
		
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			match item.item_type:
				Types.ItemTypes.KEY:
					for exit in current_room.exits.values():
						if exit == item.use_value:
							exit.is_locked = false
							player.drop_item(item)
							return "You use %s to unlock a door to %s" % [item.item_name, exit.get_other_room(current_room).room_name]
					return "That item does not unlock any doors in this room."
				_:
					return "Error - tried to use an item with an invalid type."
	
	return "You don't have that item."


func talk(second_word: String) -> String:
	if second_word == "":
		return "Talk to whom?"
	
	for npc in current_room.npcs:
		if npc.npc_name.to_lower() == second_word:
			var dialog = npc.post_quest_dialog if npc.has_received_quest_item else npc.initial_dialog
			return npc.npc_name + ": \"" + dialog + "\""
	
	return "That person does not exist in this room."


func give(second_word: String) -> String:
	if second_word == "":
		return "Give what?"
	
	var has_item := false
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			has_item = true
		
	if not has_item:
		return "You don't have that item."
	
	for npc in current_room.npcs:
		if npc.quest_item != null and second_word.to_lower() == npc.quest_item.item_name.to_lower():
			npc.has_received_quest_item = true
			
			if npc.quest_reward != null:
				var reward = npc.quest_reward
				if "is_locked" in reward:
					reward.is_locked = false
				else:
					printerr("Warning: tried to have a quest reward type that is not implemented!")
					
			for item in player.inventory:
				if second_word.to_lower() == item.item_name.to_lower():
					player.drop_item(item)
			
			return "You give a %s to the %s." % [second_word, npc.npc_name]
	
	return "Nobody here wants that item."


func help() -> String:
	return "You can use these commands: go [location], take [item], drop [item], inventory, use [item], talk [person], give [item], help"

func change_room(new_room: GameRoom) -> String:
	current_room = new_room
	return new_room.get_full_description()
