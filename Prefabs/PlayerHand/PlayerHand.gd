extends Node3D
class_name PlayerHand

# Called when the node enters the scene tree for the first time.
signal cardAddedToHand(card:Card)



func addCardToHand(card : Card)->void:
	card.addCardToHand($Spacer)
	emit_signal("cardAddedToHand",card)


