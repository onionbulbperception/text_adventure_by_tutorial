extends Resource
class_name NPC


@export var npc_name : String = "NPC Name"
@export var quest_item : Resource
@export_multiline var initial_dialog: String
@export_multiline var post_quest_dialog: String


var has_received_quest_item := false
var quest_reward = null
