extends GenericGameScene
class_name GamePlayScene

@export
var myDeck : Deck 
@export
var myBoard : Board
@export 
var myGameState : GameState

func _on_button_pressed() -> void:
	goToNextScene("res://Scenes/ShopScene/ShopScene.tscn")
	
func _ready() -> void:
	pass
	
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
