extends Node3D

var tileInstance : PackedScene = preload("res://Prefabs/Tiles/Tile.tscn")

@export
var distanceBetweenTiles := 2.0

var myTiles : Dictionary = {}

func _ready()->void:
	generateBoard([Vector2(0,0),Vector2(1,0),Vector2(0,1),Vector2(1,1)])
	

func generateBoard(tiles : Array[Vector2])->void:
	for coordinate : Vector2 in tiles:
		addTile(coordinate)

func addTile(coordinate : Vector2)->void:
	if (myTiles.has(coordinate)):
		printerr("warning " + str(coordinate) + " already has tile. No tile being added")
		return
	var newTile : Tile = tileInstance.instantiate()
	newTile.placeTile(coordinate,distanceBetweenTiles)
	add_child(newTile)
	myTiles[coordinate] = newTile
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta:float)->void:
	
	pass
