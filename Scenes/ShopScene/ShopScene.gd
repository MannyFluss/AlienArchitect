extends GenericGameScene
class_name ShopScene


@export
var myDeck : Deck
@export
var myBoard : Board

var preloadedTagScene : PackedScene = preload("res://Prefabs/Tags/Tag.tscn")



func _on_button_pressed() -> void:
	
	finishShop()


func interpretSave(_save : GeneralSaveResource)->void:
	
	myDeck.createDeckFromSaveResource(_save)
	#myBoard.regenerateModules(_save.myBoardModules)
	

func _ready() -> void:
	setGraphics()
	interpretSave(myCurrentSave)
	setTags()
	GlobalEventBus.connect("TagPurchased",onTagPurchased)
	

func _on_button_2_pressed() -> void:
	myDeck.addCardToDeck(myDeck.generateCard(myDeck.debugBuilding))
	pass # Replace with function body.


func _on_re_roll_pressed() -> void:
	pass # Replace with function body.

func setGraphics()->void:
	%MoneyCount.text = "Money Count: "+str(myCurrentSave.myGameStateResource.currencyCount)
	%BluePrintCount.text = "Blueprint Count: "+str(myCurrentSave.myGameStateResource.BluePrintCount)

func setTags()->void:
	var count:int = myCurrentSave.myGameStateResource.tagShopCount
	for tag in %TagContainer.get_children():
		tag.queue_free()
		
	for i in range(count):
		var tag : TagPurchase = preloadedTagScene.instantiate() as TagPurchase
		tag.registerScene(self)
		tag.setBasedOnResource(getRandomEvent())
		%TagContainer.add_child(tag)
	
func getRandomEvent()->tagResource:
	const basePath : String = "res://Resources/Tags/"
	var dir : DirAccess = DirAccess.open(basePath)
	if dir:
		var choice : int = randi_range(0,dir.get_files().size()-1)
		var chosenDirectory:String = dir.get_files()[choice]
		var absolutePath : String = basePath+chosenDirectory
		if FileAccess.file_exists(absolutePath):
			var toReturn : tagResource = load(absolutePath) as tagResource
			return toReturn
		push_error(absolutePath + " does not exist")
		#push_error("res://Prefabs/Events/DebugEvent/DebugEvent.tscn") 
		return null
	else:
		return null

func refreshTags()->void:
	#%TagContainer.
	
	pass



func onTagPurchased(tag : TagPurchase)->void:
	var upgrader : upgradeHandler  = $HandleUpgrades
	
	upgrader.handleUpgrade(tag)
	setGraphics()



func _on_next_round_pressed() -> void:
	finishShop()

func finishShop()->void:
	
	
	myCurrentSave.myCards = myDeck.createCardSaveArray() 
	#myCurrentSave.myBoardModules = myBoard.serializeModules()
	goToNextScene("res://Scenes/GamePlayScene/main.tscn")
