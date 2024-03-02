extends Node

#gotta rethink this too tired atm
var baseCard : PackedScene= preload("res://Prefabs/Card/Card.tscn")
@export
var myCards : Array[BuildingResource]

#this might need to be reworked later?
@export
var myHand : PlayerHand
#make a resource/json for large amounts of cards to save

func drawRandomCardToHand()->void:
	if emptyDeck(): return
	if myHand == null:
		push_warning("no myHand aborting")
		return
	
	var cardToDraw : Card = drawCard()

	myHand.addCardToHand(cardToDraw)


func drawCard()->Card:
	assert(not emptyDeck(),"deck is empty cannot draw card")
	var toReturn : BuildingResource = myCards.pick_random()
	myCards.erase(toReturn)
	return null
	

	






func emptyDeck()->bool:
	return myCards.size()==0
