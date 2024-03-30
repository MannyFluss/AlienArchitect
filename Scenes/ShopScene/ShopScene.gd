extends GenericGameScene
class_name ShopScene


@export
var myDeck : Deck
@export
var myBoard : Board


func _on_button_pressed() -> void:
	
	finishShop()


func interpretSave(_save : GeneralSaveResource)->void:
	myDeck.createDeckFromSaveResource(_save)
	#myBoard.regenerateModules(_save.myBoardModules)
	

func _ready() -> void:
	setGraphics()
	interpretSave(myCurrentSave)


func _on_button_2_pressed() -> void:
	myDeck.addCardToDeck(myDeck.generateCard(myDeck.debugBuilding))
	pass # Replace with function body.


func _on_re_roll_pressed() -> void:
	pass # Replace with function body.

func setGraphics()->void:
	%MoneyCount.text = "Money Count: "+str(myCurrentSave.myGameStateResource.currencyCount)
	%BluePrintCount.text = "Blueprint Count: "+str(myCurrentSave.myGameStateResource.BluePrintCount)

func setTagsCount()->void:
	var count:int = myCurrentSave.myGameStateResource.tagShopCount
	
	



func _on_next_round_pressed() -> void:
	finishShop()

func finishShop()->void:
	myCurrentSave.myCards = myDeck.createCardSaveArray() 
	#myCurrentSave.myBoardModules = myBoard.serializeModules()
	goToNextScene("res://Scenes/GamePlayScene/main.tscn")
