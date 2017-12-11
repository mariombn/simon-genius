extends Node

onready var lblVelocidade = get_node("infos/btnChangeNivel/lblNivel")

func _ready():
	if global.velocidade == global.VEL_MEDIO:
		lblVelocidade.set_text("Normal")
	elif global.velocidade == global.VEL_FACIL:
		lblVelocidade.set_text("Fácil")
	elif global.velocidade == global.VEL_DIFICIL:
		lblVelocidade.set_text("Dificil")

func _on_btnChangeNivel_pressed():
	if global.velocidade == global.VEL_DIFICIL:
		global.velocidade = global.VEL_MEDIO
		lblVelocidade.set_text("Normal")
	elif global.velocidade == global.VEL_MEDIO:
		global.velocidade = global.VEL_FACIL
		lblVelocidade.set_text("Fácil")
	elif global.velocidade == global.VEL_FACIL:
		global.velocidade = global.VEL_DIFICIL
		lblVelocidade.set_text("Dificil")

func _on_btnVoltar_pressed():
	get_tree().change_scene("res://scenes/mainmenu.tscn")
