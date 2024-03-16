extends Resource
class_name PackedBuildingSerializer

@export
var myCards : Array[BuildingSerailizeResource]

func register(_myCards : Array[BuildingSerailizeResource]) -> void:
	myCards = _myCards.duplicate(true)