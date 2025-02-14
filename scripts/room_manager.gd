extends Node


func _ready() -> void:
	$ShedRoom.connect_exit_unlocked("west", $BackOfInnRoom)
	
	$BackOfInnRoom.connect_exit_unlocked("path", $VillageSquareRoom)
	
	$VillageSquareRoom.connect_exit_unlocked("east", $InnDoorRoom)
	$VillageSquareRoom.connect_exit_unlocked("north", $TownGateRoom)
	$VillageSquareRoom.connect_exit_unlocked("west", $FieldRoom)
	
	$InnDoorRoom.connect_exit_unlocked("inside", $InnRoom)
	
	var innkeeper = load_npc("innkeeper")
	$InnRoom.add_npc(innkeeper)
	$InnRoom.connect_exit_unlocked("south", $"InnsKitchenRoom")

	
	var exit = $InnsKitchenRoom.connect_exit_locked("south", $BackOfInnRoom)
	var key = load_item("key")
	key.use_value = exit
	$InnsKitchenRoom.add_item(key)
	
	var guard = load_npc("guard")
	$TownGateRoom.add_npc(guard)
	$TownGateRoom.connect_exit_unlocked("forest", $ForestRoom, "gate")


func load_item(item_name: String):
	return load("res://items/" + item_name + ".tres")

func load_npc(npc_name: String):
	return load("res://npcs/" + npc_name + ".tres")
