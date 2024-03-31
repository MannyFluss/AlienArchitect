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
func _enter_tree() -> void:
	add_to_group("Decks")

func _ready() -> void:
	#addCardToDeck(generateCard(destroyBuilding))
	#addCardToDeck(generateCard(destroyBuilding))
	#addCardToDeck(generateCard(debugBuilding))
	#addCardToDeck(generateCard(debugBuilding))
	#addCardToDeck(generateCard(debugBuilding))
	#addCardToDeck(generateCard(debugBuilding))
	#
	#SaveSystem.writeSave(createSaveResource(),"pee")
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

func drawCards(count : int)->void:
	for i in range(count):
		await get_tree().create_timer(.15).timeout
		drawRandomCardToHand()
	
#this does too much for now will change later
func createSaveResource()->GeneralSaveResource:
	var toReturn : GeneralSaveResource = GeneralSaveResource.new()
	var cardResourceArray : Array[CardSaveResource] = []
	for child in $Cards.get_children():
		if child is Card:
			cardResourceArray.append(CardSaveResource.registerCard(child))
	toReturn.registerCards(cardResourceArray)
	return toReturn

func createCardSaveArray()->Array[CardSaveResource]:
	var cardResourceArray : Array[CardSaveResource] = []
	for child in $Cards.get_children():
		if child is Card:
			cardResourceArray.append(CardSaveResource.registerCard(child))
	return cardResourceArray
func saveDeck(saveName:String)->void:
	SaveSystem.writeSave(createSaveResource(),saveName)


func createDeckFromSave(loadName:String)->void:
	var save : GeneralSaveResource = SaveSystem.loadSave(loadName)
	if save==null:return
	for card in save.myCards:
		var newCard : Card = CardSaveResource.regenerateCard(card)
		addCardToDeck(newCard)
		
func createDeckFromSaveResource(save:GeneralSaveResource)->void:
	if save==null:return
	for card in save.myCards:
		var newCard : Card = CardSaveResource.regenerateCard(card)
		addCardToDeck(newCard)
		
func generateDeckDebug()->void:
	clearDeck()
	
func clearDeck()->void:
	for child in $Cards.get_children():
		child.queue_free()

func emptyDeck()->bool:
	return $Cards.get_child_count()==0

func addCardToDeck(toAdd : Card)->void:
	$Cards.add_child(toAdd)

func printCards()->void:
	print($Cards.get_children())

#it might be bad to do this checking performance wise, can smoothen later
func generateCard(buildingScene:PackedScene)->Card:
	return CardUtility.generateCard(buildingScene)


