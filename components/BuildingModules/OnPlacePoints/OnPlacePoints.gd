extends BuildingModule
#dont think needs class name


func _ready()->void:
	myOptions["money"] = 1
	myBuilding.connect("buildingPlaced",OnBuildingPlaced)
	
func OnBuildingPlaced()->void:
	GameStateUtility.emit_signal("generatedScore",myOptions["money"],myBuilding)
	pass
