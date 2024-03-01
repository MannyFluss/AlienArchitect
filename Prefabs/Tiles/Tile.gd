extends Node3D
class_name Tile


var myCoordinates : Vector2

signal buildingPlaced(_building : Building)

signal buildingPlacedFail(_building : Building)


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func placeTile(location : Vector2, offset := 2.0)->void:
	position.x = location.x * offset
	position.z = location.y * offset
	myCoordinates = location
	
	
func AttemptToPlaceBuilding(toPlace : Building)->void:
	if $MyBuilding.get_child_count()==0:
		toPlace.placeMe($MyBuilding)
		emit_signal("buildingPlaced")
	else:
		emit_signal("buildingPlacedFail")
	
	pass
	
	
