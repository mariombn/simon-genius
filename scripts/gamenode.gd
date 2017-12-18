extends Node

onready var timerDelay = get_node("delay")
onready var timerDeplayTour = get_node("delayTurn")
onready var lblFeedback = get_node("feedback/panelFeedback/Label")
onready var lblPontos = get_node("feedback/panelPontos/pontos")

var pontos = 0
var countPlay = 0
var sequence = []
var objSpritNormal = []
var objSpritPress  = []
var sequencePlayer = []
var lastSequence = false
var estado = 0
var countPlayerTouch = 0

const BLUE = 0
const RED = 1
const GREEN = 2
const YELLOW = 3
const WAITING = 0
const PLAYING = 1


func _ready():
	timerDelay.set_wait_time(global.velocidade)
	randomize()
	var count = 0
	while count <= 3:
		var strColor = getColorName(count)
		strColor = "buttonsPlayer/" + strColor + "Touch/"
		objSpritNormal.append(get_node(strColor).get_texture())
		objSpritPress.append(get_node(strColor).get_texture_pressed())
		count += 1

func gameOver():
	estado = WAITING
	eneableButtons(false)
	lblFeedback.set_text("Game Over!")
	global.saveRecord(pontos)
	get_node("resetGame").start()

func newSequence():
	timerDeplayTour.stop()
	eneableButtons(false)
	countPlayerTouch = 0
	lblFeedback.set_text("Aguarde!")
	sequence.append(int(rand_range(0,4)))
	timerDelay.start()

func touchButton(color):
	if estado == PLAYING:
		soundButton(color)
		if testPlayerTouch(countPlayerTouch, color):
			countPlayerTouch += 1
			if sequence.size() == countPlayerTouch:
				estado = WAITING
				pontos += 1
				lblPontos.set_text(str(pontos))
				timerDeplayTour.start()
		else:
			gameOver()


func testPlayerTouch(count, color):
	if estado == PLAYING:
		if sequence[count] == color:
			return true
		else:
			return false

func play():
	if lastSequence == true:
		downAllButton()
		timerDelay.stop()
		estado = PLAYING
		eneableButtons(true)
		lblFeedback.set_text("Jogue!")
		lastSequence = false
	else:
		downAllButton()
		upButton(sequence[countPlay])
		soundButton(sequence[countPlay])
		
		if (sequence.size() -1) <= countPlay:
			countPlay = 0
			lastSequence  = true
		else:
			countPlay += 1


func soundButton(color):
	var strColor = getColorName(color)
	strColor = "buttonsPlayer/" + strColor + "Touch/" + strColor + "Sound"
	get_node(strColor).play()

func upButton(color):
	var strColor = getColorName(color)
	strColor = "buttonsPlayer/" + strColor + "Touch/"
	get_node(strColor).set_texture(objSpritPress[color])

func downAllButton():
	var count = 0
	while count <= 3:
		var strColor = getColorName(count)
		strColor = "buttonsPlayer/" + strColor + "Touch/"
		get_node(strColor).set_texture(objSpritNormal[count])
		count += 1

func eneableButtons(status):
	var count = 0
	if status:
		while count <= 3:
			var strColor = getColorName(count)
			strColor = "buttonsPlayer/" + strColor + "Touch/"
			get_node(strColor).set_texture_pressed(objSpritPress[count])
			count += 1
	else:
		while count <= 3:
			var strColor = getColorName(count)
			strColor = "buttonsPlayer/" + strColor + "Touch/"
			get_node(strColor).set_texture_pressed(objSpritNormal[count])
			count += 1

func getColorName(color):
	if color == BLUE:
		return "blue"
	elif color == RED:
		return "red"
	elif color == YELLOW:
		return "yellow"
	elif color == GREEN:
		return "green"
	else:
		return false


func _on_blueTouch_pressed():
	touchButton(0)

func _on_redTouch_pressed():
	touchButton(1)

func _on_greenTouch_pressed():
	touchButton(2)

func _on_yellowTouch_pressed():
	touchButton(3)

func _on_delay_timeout():
	play()

func _on_resetGame_timeout():
	get_tree().change_scene("res://scenes/mainmenu.tscn")

func _on_delayTurn_timeout():
	newSequence()

func _on_startGame_timeout():
	newSequence()
	get_node("startGame").stop()
