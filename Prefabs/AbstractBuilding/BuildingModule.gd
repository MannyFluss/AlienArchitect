extends Node3D
class_name BuildingModule

#base script for defining all functionality of buildings
#this script should be inherited from for other building modules
#can be used for basically anything, particles, points, new behaviors
@export
var myOptions:Dictionary={}

var myBuilding : Building

func registerBuilding(_myBuilding : Building, opts:Dictionary={})->void:
	myBuilding = _myBuilding
	for key:String in opts.keys():
		if myOptions.has(key):
			myOptions[key] = opts[key]

func _enter_tree() -> void:
	if myBuilding == null:
		#automatically search for building
		var currNode : Node = get_parent()
		while currNode != get_tree().current_scene:
			if currNode is Building:
				registerBuilding(currNode)
				return
			currNode = currNode.get_parent()
		push_error("myBuilding was not registered")
