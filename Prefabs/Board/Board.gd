extends Node3D
class_name Board

var tileInstance : PackedScene = preload("res://Prefabs/Tiles/Tile.tscn")

signal buildingCreated(_building : Building, _tile : Tile)

@export
var distanceBetweenTiles := 2.0

#hashmap <vector2,tile>
var myTiles : Dictionary = {}

func _ready()->void:
	generateBoard([Vector2(0,0),Vector2(1,0),Vector2(0,1),Vector2(1,1)])
	
func getBuilding(target : Vector2)->Building:
	if myTiles.has(target):
		var targetTile : Tile = myTiles[target]
		return targetTile.getBuilding()
	return null

func generateBoard(tiles : Array[Vector2])->void:
	for coordinate : Vector2 in tiles:
		addTile(coordinate)

func addTile(coordinate : Vector2)->void:
	if (myTiles.has(coordinate)):
		printerr("warning " + str(coordinate) + " already has tile. No tile being added")
		return
	var newTile : Tile = tileInstance.instantiate()
	newTile.placeTile(coordinate,distanceBetweenTiles,self)
	add_child(newTile)
	myTiles[coordinate] = newTile
	

func canBuildingBePlaced(coordinate : Vector2)->bool:
	if (myTiles.has(coordinate)==false):
		return false
	if myTiles[coordinate].hasBuilding():
		return false
	else:
		return false

		
