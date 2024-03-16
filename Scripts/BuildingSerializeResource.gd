extends Resource
class_name BuildingSerailizeResource

var myBuildingScene : PackedScene


func registerCard(_card : Card)->void:
	myBuildingScene = _card.myBuildingScene.duplicate(true)
