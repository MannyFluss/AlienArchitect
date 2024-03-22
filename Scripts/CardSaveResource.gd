extends Resource
class_name CardSaveResource

#this can be expanded later
@export
var cardModules : Array[CardModuleResource]=[]

@export
var cardScenePath : String

@export
var buildingScenePath : String


static func registerCard(_card : Card )->CardSaveResource:
	var toReturn : CardSaveResource = CardSaveResource.new()
	toReturn.cardScenePath = _card.scene_file_path
	var thing : Node = _card.myBuildingScene.instantiate()
	toReturn.buildingScenePath = thing.scene_file_path
	thing.queue_free()
	for module in _card.get_node("Modules").get_children():
		if module is CardModule:
			var newMod : CardModuleResource = CardModuleResource.new()
			newMod.registerCard(module)
			toReturn.cardModules.append(newMod)
	
	return toReturn

static func regenerateCard(_res : CardSaveResource)->Card:
	var cardToReturn : Card = load(_res.cardScenePath).instantiate() as Card 
	cardToReturn.myBuildingScene = load(_res.buildingScenePath)
	if cardToReturn==null:return null
	#applying options
	
	for module in _res.cardModules:
		cardToReturn.loadModule(module)

	return cardToReturn
	
