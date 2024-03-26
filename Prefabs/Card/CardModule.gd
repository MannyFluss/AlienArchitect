extends Node3D
class_name CardModule

@export
var myName :String = ""

@export
var myOptions : Dictionary = {}

@export
var autoRegister:bool = true

var myCard : Card


func registerCard(_myCard : Card, opts:Dictionary={})->void:
	myCard = _myCard
	for key:String in opts.keys():
		if myOptions.has(key):
			myOptions[key] = opts[key]
	
func _enter_tree() -> void:
	if myCard == null and autoRegister:
		#automatically search for building
		var currNode : Node = get_parent()
		while currNode != get_tree().current_scene:
			if currNode is Card:
				registerCard(currNode)
				return
			currNode = currNode.get_parent()
		push_error("myBuilding was not registered")
		queue_free()
