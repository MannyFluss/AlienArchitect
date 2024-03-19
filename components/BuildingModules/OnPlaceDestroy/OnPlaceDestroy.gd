extends BuildingModule

@export
var destructionComponent : DestroyBuildings

func _ready() -> void:
	myBuilding.connect("buildingPlaced",destroyTime)

func destroyTime()->void:
	if destructionComponent:
		var numberDestroyed : int = destructionComponent.destroyBuildings()
		GameStateUtility.emit_signal("generatedScore",numberDestroyed,myBuilding)
		
