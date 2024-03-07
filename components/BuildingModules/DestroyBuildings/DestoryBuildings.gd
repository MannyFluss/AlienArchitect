extends BuildingModule
class_name DestroyBuildings


#returns how many buildings were destroyed
func destroyBuildings()->int:
	var countDestroyed:int =0
	for target : Vector2 in myOptions["Targets"]:
		var targetBuilding : Building = myBuilding.getNeighboringBuilding(target)
		if targetBuilding==null:
			continue
		#attempt destroy has side effect of destroying
		if targetBuilding.attemptDestroy()==true:
			countDestroyed+=1
	return countDestroyed
