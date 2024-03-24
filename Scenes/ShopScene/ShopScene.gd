extends GenericGameScene
class_name ShopScene


@export
var myDeck : Deck

func _on_button_pressed() -> void:
	
	myCurrentSave.myCards = myDeck.createCardSaveArray() 
	goToNextScene("res://Scenes/GamePlayScene/main.tscn")


func interpretSave(_save : GeneralSaveResource)->void:
	myDeck.createDeckFromSaveResource(_save)

func _ready() -> void:
	#super._ready()
	interpretSave(myCurrentSave)


func _on_button_2_pressed() -> void:
	myDeck.addCardToDeck(myDeck.generateCard(myDeck.debugBuilding))
	pass # Replace with function body.
