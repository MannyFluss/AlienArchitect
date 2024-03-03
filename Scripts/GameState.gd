extends Node
class_name GameState

signal cardPlayed(_card:Card)

#make all of these part of a resource eventually
signal levelCompleted

signal quotaSet(amount:int)
signal newMunicipalityScore(amount:int)


@export
var bluePrintCount:int = 10
@export
var quota:int=0

var currentMunicipalityScore:int=0




var levelCompleteFlag := false

func _ready() -> void:
	GameStateUtility.connect("generatedScore",onGeneratedScore)
	emit_signal("quotaSet",quota)
	
	
	
func onGeneratedScore(amount:int,building:Building)->void:
	increaseScore(amount)
	
func increaseScore(amount:int)->void:
	currentMunicipalityScore += amount
	emit_signal("newMunicipalityScore",currentMunicipalityScore)
	if currentMunicipalityScore >= quota && levelCompleteFlag==false:
		levelCompleteFlag=true
		emit_signal("levelCompleted")
