extends Node3D
class_name BuildingModule

#base script for defining all functionality of buildings
#this script should be inherited from for other building modules
#can be used for basically anything, particles, points, new behaviors
@export
var myOptions:Dictionary={}

var myBuilding : Building

func registerBuilding(_myBuilding : Building, opts:Dictionary)->void:
	myBuilding = _myBuilding
	for key:String in opts.keys():
		if myOptions.has(key):
			myOptions[key] = myOptions[key]
			
			
	
	
	
