extends Node


enum ItemTypes {
	KEY,
	QUEST_ITEM,
}

const COLOR_NPC = Color("#52dee5")
const COLOR_ITEM = Color("#b38cb4")
const COLOR_SPEECH = Color("#b6c649")
const COLOR_LOCATION = Color("#4f4789")
const COLOR_SYSTEM = Color("#f06543")


func wrap_npc_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [COLOR_NPC.to_html(), text]


func wrap_item_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [COLOR_ITEM.to_html(), text]


func wrap_speech_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [COLOR_SPEECH.to_html(), text]


func wrap_location_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [COLOR_LOCATION.to_html(), text]


func wrap_system_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [COLOR_SYSTEM.to_html(), text]
