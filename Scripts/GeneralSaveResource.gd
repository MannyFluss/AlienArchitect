extends Resource
class_name GeneralSaveResource 

#this will be a save resource to save everything

@export
var myCards : Array[CardSaveResource]=[]

@export
var myBoardModules : Array[BoardModuleSaveResource]=[]

@export
var myGameStateResource : GameStateResource

@export
var randomSeed : float = 0

func registerCards(_cards : Array[CardSaveResource])->void:
	myCards = _cards.duplicate(true)
	
func registerBoardModules(_boardModules : Array[BoardModuleSaveResource])->void:
	myBoardModules = _boardModules.duplicate(true)

func registerGameStateResource(_res : GameStateResource)->void:
	myGameStateResource = _res.duplicate(true)


func printCards()->void:
	for card : CardSaveResource in myCards:
		print(card)
