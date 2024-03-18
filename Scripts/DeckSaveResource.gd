extends Resource
class_name DeckSaveResource

var myBuildings : Array[BuildingSaveResource] = []


func registerDeck(deck : Deck)->void:
	var allCards : Array[Node] = deck.getCards()
	for card in allCards:
		if card is Building:
			myBuildings.append(card.serializeMe())
	
