extends Node


func _ready() -> void:
	$ShedRoom.connect_exit_unlocked("west", $BackOfInnRoom)
	
	$BackOfInnRoom.connect_exit_unlocked("path", $VillageSquareRoom)
	
	$VillageSquareRoom.connect_exit_unlocked("east", $InnDoorRoom)
	$VillageSquareRoom.connect_exit_unlocked("north", $TownGateRoom)
	$VillageSquareRoom.connect_exit_unlocked("west", $FieldRoom)
	
	var sword = load_item("guard_sword")
	#sword.use_value = exit
	$FieldRoom.add_item(sword)
	
	$InnDoorRoom.connect_exit_unlocked("inside", $InnRoom)
	
	var innkeeper = load_npc("innkeeper")
	$InnRoom.add_npc(innkeeper)
	$InnRoom.connect_exit_unlocked("south", $"InnsKitchenRoom")

	
	var exit = $InnsKitchenRoom.connect_exit_locked("south", $BackOfInnRoom)
	var key = load_item("inn_kitchen_key")
	key.use_value = exit
	$InnsKitchenRoom.add_item(key)
	
	exit = $TownGateRoom.connect_exit_locked("forest", $ForestRoom, "gate")
	var guard = load_npc("guard")
	$TownGateRoom.add_npc(guard)
	guard.quest_reward = exit


func load_item(item_name: String):
	return load("res://items/" + item_name + ".tres")

func load_npc(npc_name: String):
	return load("res://npcs/" + npc_name + ".tres")
