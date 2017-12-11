extends Node

onready var lblUltima = get_node("infos/lblUltimaPontuacaoValor")
onready var lblMelhor = get_node("infos/lblMelhorPontuacaoValor1")

func _ready():
	print(global.savedata[0])
	print(global.savedata[1])
	lblUltima.set_text(str(global.savedata[0]))
	lblMelhor.set_text(str(global.savedata[1]))


func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/mainmenu.tscn")
