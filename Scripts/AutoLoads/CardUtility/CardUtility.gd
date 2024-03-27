extends Node


var baseCard : PackedScene= preload("res://Prefabs/Card/Card.tscn")

#note card will be an orphan
#add modules to cards based off buildingScene possible.
#
func generateCard(buildingScene:PackedScene)->Card:
	
	var newBuilding : Building = buildingScene.instantiate() as Building
	assert(newBuilding!=null,"buildingScene is not building")
	newBuilding.queue_free()
	var newCard : Card = baseCard.instantiate() as Card
	assert(newCard!=null,"cardScene is not card")
	
	newCard.myBuildingScene = buildingScene
	return newCard
