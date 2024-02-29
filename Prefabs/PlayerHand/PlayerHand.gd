extends Node3D
class_name PlayerHand

# Called when the node enters the scene tree for the first time.


func addCardToHand(card : Card)->void:
	card.reparent($Spacer)
	pass
