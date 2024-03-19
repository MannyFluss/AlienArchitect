extends BuildingModule
#dont think needs class name


func _ready()->void:
	myBuilding.connect("buildingPlaced",OnBuildingPlaced)
	
func OnBuildingPlaced()->void:
	GameStateUtility.emit_signal("generatedScore",myOptions["money"],myBuilding)
	pass
