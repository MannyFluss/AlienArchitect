extends Node
class_name GameState

signal cardPlayed(_card:Card)

#make all of these part of a resource eventually
signal levelCompleted

signal quotaSet(amount:int)
signal newMunicipalityScore(amount:int)
signal bluePrintCountSet(amount:int)


@export
var bluePrintCount:int = 10
@export
var quota:int=0

var currentMunicipalityScore:int=0

var levelCompleteFlag := false

func _enter_tree() -> void:
	add_to_group("GameState")

func _ready() -> void:
	GameStateUtility.connect("generatedScore",onGeneratedScore)
	connect("cardPlayed",onCardPlayed)

	emit_signal("quotaSet",quota)
	emit_signal("bluePrintCountSet",bluePrintCount)
	
	
	
func onGeneratedScore(amount:int,_building:Building)->void:
	increaseScore(amount)
	
	
func increaseScore(amount:int)->void:
	currentMunicipalityScore += amount
	emit_signal("newMunicipalityScore",currentMunicipalityScore)
	if currentMunicipalityScore >= quota && levelCompleteFlag==false:
		levelCompleteFlag=true
		emit_signal("levelCompleted")

func checkCardPlayability(cardInformation:BuildingResource)->bool:
	if cardInformation.bluePrintCost <= bluePrintCount: return true
	return false



func cardPlayedUpdate(cardInformation:BuildingResource)->void:
	bluePrintCount -= cardInformation.bluePrintCost
	emit_signal("bluePrintCountSet",bluePrintCount)

	pass

func onCardPlayed(_card:Card)->void:
	cardPlayedUpdate(_card.myBuildingInformation)
