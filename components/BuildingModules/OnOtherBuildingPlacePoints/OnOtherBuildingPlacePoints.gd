extends BuildingModule


# Called when the node enters the scene tree for the first time.
@export
var money : int = 1

func _ready() -> void:
	GlobalEventBus.connect("buildingPlaced",OnBuildingPlaced)

signal finished

func OnBuildingPlaced(building : Building)->void:
	if building == myBuilding:
		return
		
	var serviceQueue : EventQueue = EventQueueServiceLocator.getEventQueue()
	var myEvent : QueueEvent = QueueEvent.new(self, _callback ,finished)
	serviceQueue.pushEventFront(myEvent)
	
func _callback()->void:
	GameStateUtility.emit_signal("generatedScore",money,myBuilding)
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(myBuilding,"scale",Vector3(1.3,1.3,1.3),.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(myBuilding,"scale",Vector3(1.0,1.0,1.0),.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	await tween.finished
	
	finished.emit()
