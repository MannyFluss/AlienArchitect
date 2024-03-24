extends Node3D
class_name DefaultSaveScene

# Called when the node enters the scene tree for the first time.
@export
var myBoard : Board
@export
var myDeck : Deck
@export
var myGameState : GameState

func createSaveData()->void:
	var newSaveData : GeneralSaveResource = GeneralSaveResource.new()
	newSaveData.randomSeed = randf()
	newSaveData.registerBoardModules(myBoard.serializeModules())
	newSaveData.registerCards(myDeck.createCardSaveArray())
	newSaveData.myGameStateResource = myGameState.myGameStateResource.duplicate(true)
	var key : String = str(hash(newSaveData.randomSeed))
	SaveSystem.writeSave(newSaveData,key)
	
