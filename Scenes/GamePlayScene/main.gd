extends GenericGameScene
class_name GamePlayScene

@export
var myDeck : Deck 
@export
var myBoard : Board

func _on_button_pressed() -> void:
	goToNextScene("res://Scenes/ShopScene/ShopScene.tscn")
	
func _ready() -> void:
	pass
	
func _enter_tree() -> void:
	super._enter_tree()
	myDeck.createDeckFromSaveResource(myCurrentSave)
	myBoard.regenerateModules(myCurrentSave.myBoardModules.duplicate(true))
