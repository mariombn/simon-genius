extends Node

var savefile = File.new()
var savepath = "user://savegame.save"
var savedata = [0, 0]

const VEL_FACIL = 1
const VEL_MEDIO = 0.5
const VEL_DIFICIL = 0.1

var velocidade = 0.5

func _ready():
	if not savefile.file_exists(savepath):
		save()
	read()
	print(savedata[0])

func save():
	savefile.open(savepath, File.WRITE)
	savefile.store_var(savedata)
	savefile.close()
	
func read():
	savefile.open(savepath, File.READ)
	savedata = savefile.get_var()
	savefile.close()
	
func saveRecord(pontos):
	if savedata[1] < pontos:
		savedata[1] = pontos
	savedata[0] = pontos
	save()
