extends BuildingModule


# Called when the node enters the scene tree for the first time.
@export
var money : int = 1

func _ready() -> void:
	GlobalEventBus.connect("buildingPlaced",OnBuildingPlaced)
	pass # Replace with function body.



func OnBuildingPlaced(building : Building)->void:
	if building == myBuilding:
		return
		
	var serviceQueue : EventQueue = EventQueueServiceLocator.getEventQueue()
	var tween : Tween = get_tree().create_tween()
	
	var myEvent : QueueEvent = QueueEvent.new(self, emitSignal ,tween.finished)
	tween.tween_property(myBuilding,"scale",Vector3(1.3,1.3,1.3),.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(myBuilding,"scale",Vector3(1.0,1.0,1.0),.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	serviceQueue.pushEventFront(myEvent)
	

func emitSignal()->void:
	GameStateUtility.emit_signal("generatedScore",money,myBuilding)
