extends Node3D
class_name Deck
#gotta rethink this too tired atm
var baseCard : PackedScene= preload("res://Prefabs/Card/Card.tscn")

#this might need to be reworked later?
@export
var myHand : PlayerHand

var debugBuilding : PackedScene = preload("res://Prefabs/Buildings/DefaultBuilding/DefaultBuilding.tscn")
var destroyBuilding : PackedScene = preload("res://Prefabs/Buildings/DestroyerBuilding/DestroyerBuilding.tscn")

#make a resource/json for large amounts of cards to save


func _ready() -> void:
	#addCardToDeck(generateCard(destroyBuilding))
	#addCardToDeck(generateCard(destroyBuilding))
	###addCardToDeck(generateCard(debugBuilding))
	#addCardToDeck(generateCard(debugBuilding))
	#addCardToDeck(generateCard(debugBuilding))
	#addCardToDeck(generateCard(debugBuilding))
	
	var test : DeckSaveResource = loadDeck("freak")
	deckResourceToCards(test)
	drawRandomCardToHand()
	drawRandomCardToHand()
	drawRandomCardToHand()

	pass
	
func drawRandomCardToHand()->void:
	if emptyDeck(): return
	if myHand == null:
		push_warning("no myHand aborting")
		return
	
	var cardToDraw : Card = drawCard()
	myHand.addCardToHand(cardToDraw)


#side effect, random_child is now an orphan
func drawCard()->Card:
	assert(not emptyDeck(),"deck is empty cannot draw card")
	var child_count:int = $Cards.get_child_count() # Get the total number of child nodes
	
	var random_index:int = randi() % child_count # Generate a random index
	var random_child:Card = $Cards.get_child(random_index)
	$Cards.remove_child(random_child)
	
	return random_child
	
func generateDeckDebug()->void:
	clearDeck()
	
func clearDeck()->void:
	for child in $Cards.get_children():
		child.queue_free()

func emptyDeck()->bool:
	return $Cards.get_child_count()==0

func addCardToDeck(toAdd : Card)->void:
	$Cards.add_child(toAdd)

func generateCard(buildingScene:PackedScene)->Card:
	return CardUtility.generateCard(buildingScene)
	
func getCards()->Array[Node]:
	return $Cards.get_children()

func serializeMe()->DeckSaveResource:
	var newResource : DeckSaveResource = DeckSaveResource.new()
	newResource.registerDeck(self)
	return newResource
	
func saveDeck(saveName:String)->void:
	SaveSystem.writeDeckToSave(serializeMe(),saveName)
	
func loadDeck(saveName:String)->DeckSaveResource:
	return SaveSystem.loadDeck(saveName)
	
func deckResourceToCards(res: DeckSaveResource)->void:
	for building : BuildingSaveResource in res.myBuildings:
		var newBuilding : PackedScene = building.regenerateBuilding(building)
		if building != null:
			addCardToDeck(CardUtility.generateCard(newBuilding))
		else:
			push_error("building failed to regenerate")
	

