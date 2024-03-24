extends GenericGameScene
class_name GamePlayScene

@export
var myDeck : Deck 

func _on_button_pressed() -> void:
	goToNextScene("res://Scenes/ShopScene/ShopScene.tscn")
	
	pass # Replace with function body.

func _ready() -> void:
	super._ready()
	myDeck.createDeckFromSaveResource(myCurrentSave)
