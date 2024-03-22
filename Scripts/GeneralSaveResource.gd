extends Resource
class_name GeneralSaveResource 

#this will be a save resource to save everything

@export
var myCards : Array[CardSaveResource]=[]


func registerCards(_cards : Array[CardSaveResource])->void:
	myCards = _cards.duplicate(true)
	
