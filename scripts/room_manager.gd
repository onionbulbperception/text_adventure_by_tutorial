extends Node


func _ready() -> void:
	var key = Item.new()
	key.initialize("a key", Types.ItemTypes.KEY)
	
	$ShedRoom.connect_exit_unlocked("west", $BackOfInnRoom)
	
	$BackOfInnRoom.connect_exit_unlocked("path", $VillageSquareRoom)
	
	$VillageSquareRoom.connect_exit_unlocked("east", $InnRoom)
	$VillageSquareRoom.connect_exit_unlocked("north", $TownGateRoom)
	$VillageSquareRoom.connect_exit_unlocked("west", $FieldRoom)
	
	$InnDoorRoom.connect_exit_unlocked("inside", $InnRoom)
	
	$InnRoom.connect_exit_unlocked("south", $"InnsKitchenRoom")
	
	var exit = $InnsKitchenRoom.connect_exit_locked("south", $BackOfInnRoom)
	key.use_value = exit
	$InnsKitchenRoom.add_item(key)
	
	$TownGateRoom.connect_exit_unlocked("forest", $ForestRoom, "gate")
	
