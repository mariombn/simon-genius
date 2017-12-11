extends Node

onready var openAnim = get_node("openAnum")


func _ready():
	pass

func _on_btnNewGame_pressed():
	get_tree().change_scene("res://scenes/gamenode.tscn")

func _on_btnRecord_pressed():
	get_tree().change_scene("res://scenes/records.tscn")

func _on_btnSettings_pressed():
	get_tree().change_scene("res://scenes/settings.tscn")

func _on_btnAbout_pressed():
	get_tree().change_scene("res://scenes/sobre.tscn")
