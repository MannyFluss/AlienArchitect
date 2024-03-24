extends Node3D
class_name BoardModule



#base script for defining all functionality of buildings
#this script should be inherited from for other building modules
#can be used for basically anything, particles, points, new behaviors
@export
var myOptions:Dictionary={}

var myBoard : Board

func registerBoard(_myBoard : Board, opts:Dictionary={})->void:
	myBoard = _myBoard
	for key:String in opts.keys():
		if myOptions.has(key):
			myOptions[key] = opts[key]

func _enter_tree() -> void:
	if myBoard == null:
		#automatically search for building
		var currNode : Node = get_parent()
		while currNode != get_tree().current_scene:
			if currNode is Board:
				registerBoard(currNode)
				return
			currNode = currNode.get_parent()
		push_error("myBuilding was not registered")
		queue_free()
