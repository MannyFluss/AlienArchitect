extends BuildingModule
#dont think needs class name

signal done

func _ready()->void:
	myBuilding.connect("buildingPlaced",OnBuildingPlaced)
	
func OnBuildingPlaced()->void:
	var myEvent : QueueEvent = QueueEvent.new(self, _callback , done)
	EventQueueServiceLocator.getEventQueue().pushEventFront(myEvent)
	
	

func _callback()->void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(myBuilding,"scale",Vector3(1.3,1.3,1.3),.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(myBuilding,"scale",Vector3(1.0,1.0,1.0),.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	GameStateUtility.emit_signal("generatedScore",myOptions["money"],myBuilding)
	await tween.finished
	
	done.emit()
