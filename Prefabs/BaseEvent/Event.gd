extends CanvasLayer
class_name Event

var myScene : GamePlayScene

func registerScene(_myScene : GamePlayScene)->void:
	myScene = _myScene
	if myScene == null:
		push_error("something has went very wrong event has no corresponding scene")


#not working idk just doing it manually rn
func _enter_tree() -> void:
	if myScene == null:
		#automatically search for building
		var currNode : Node = get_parent()
		while currNode != get_tree().current_scene:
			if myScene is GamePlayScene:
				registerScene(myScene)
				return
			currNode = currNode.get_parent()
		push_error("myScene was not registered")
		queue_free()

func endEvent()->void:
	queue_free()

static func getRandomEvent(_myScene : GamePlayScene)->Event:
	const basePath = "res://Prefabs/Events/"
	var dir : DirAccess = DirAccess.open(basePath)
	if dir:
		var choice : int = randi_range(0,dir.get_directories().size()-1)
		var chosenDirectory:String = dir.get_directories()[choice]
		var absolutePath : String = basePath+chosenDirectory+"/"+chosenDirectory+".tscn"
		if FileAccess.file_exists(absolutePath):
			var toReturn : Event = load(absolutePath).instantiate() as Event
			return toReturn
		push_error(absolutePath + " does not exist")
		#push_error("res://Prefabs/Events/DebugEvent/DebugEvent.tscn") 
		return null
	else:
		return null
