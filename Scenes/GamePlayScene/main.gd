extends GenericGameScene
class_name GamePlayScene

@export
var myDeck : Deck 
@export
var myBoard : Board
@export 
var myGameState : GameState

func _on_button_pressed() -> void:
	endRound()
	
	
	
func _ready() -> void:
	#setup goes here, event and such things
	
	myDeck.drawCards(myGameState.myGameStateResource.startingDrawCardCount)
	
	setupEvent()


func setupEvent()->void:
	var newEvent : Event = Event.getRandomEvent(self)
	newEvent.registerScene(self)
	add_child(newEvent)
	await newEvent.tree_exited
	print("event over")
	
func _enter_tree() -> void:
	super._enter_tree()
	interpretSaveData()

func interpretSaveData()->void:
	myDeck.createDeckFromSaveResource(myCurrentSave)
	myBoard.regenerateModules(myCurrentSave.myBoardModules.duplicate(true))
	if myCurrentSave.myGameStateResource != null:
		myGameState.myGameStateResource = myCurrentSave.myGameStateResource.duplicate(true)
	else:
		push_error("save resource has no gamestate resource")

func endRound()->void:
	myCurrentSave.myGameStateResource.roundCount += 1
	goToNextScene("res://Scenes/ShopScene/ShopScene.tscn")
	
