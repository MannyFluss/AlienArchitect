extends BuildingModule



func _ready() -> void:
	myBuilding.connect("buildingPlaced",upgradeTime)
	

func upgradeTime()->void:
	var countDestroyed:int =0
	for target : Vector2 in myOptions["Targets"]:
		var targetBuilding : Building = myBuilding.getNeighboringBuilding(target)
		if targetBuilding==null:
			continue
