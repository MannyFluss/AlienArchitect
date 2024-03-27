extends Node3D
class_name Tile

#assume that a board has always created a tile
var myParentBoard : Board

var myCoordinates : Vector2

func _ready() -> void:
	add_to_group("tiles")

func placeTile(location : Vector2, offset := 2.0, _board : Board=null)->void:
	
	position.x = location.x * offset
	position.z = location.y * offset
	myCoordinates = location
	myParentBoard = _board
	
	
func placeBuilding(toPlace : Building)->void:
	if hasBuilding()==false:
		toPlace.placeMe($MyBuilding)
		if checkSignalSafety("buildingCreated"): myParentBoard.emit_signal("buildingCreated",toPlace,self)
	else:
		printerr("building failed to place, something likely went very wrong")
		pass


func hasBuilding()->bool:
	return not $MyBuilding.get_child_count()==0
	
	
func getBuilding()->Building:
	if hasBuilding() == false: return null
	
	return $MyBuilding.get_child(0)

func checkSignalSafety(signalName : StringName)->bool:
	if myParentBoard==null:
		return false
	if myParentBoard.has_signal(signalName)==false:
		push_warning("board does not have " +signalName+" as a signal... aborting")
		return false
	return true
	
func getAdjacentTiles(tiles : Array[Vector2])->Array[Tile]:
	var toReturn : Array[Tile] = []
	
	
	for coord in tiles:
		var newTile : Tile = myParentBoard.getTile(myCoordinates+coord)
		if newTile:
			toReturn.append(newTile)
			
	return toReturn


func _on_mouse_entered() -> void:
	pass



func _on_mouse_exited() -> void:
	pass
	
