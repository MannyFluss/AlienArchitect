extends Node
class_name EventQueue 



var myEventQueue : Array[QueueEvent]

var active : bool = false

@export
var debugEnabled : bool = false

#for now it will just register itself
func _ready()->void:
	EventQueueServiceLocator.register(self)
	pass
	#var newEvent : QueueEvent = QueueEvent.new(testReference,testReference.testingFunction,testReference.timeout)
	#var newEvent2 : QueueEvent = QueueEvent.new(testReference,testReference.testingFunction,testReference.timeout)
	#var newEvent3 : QueueEvent = QueueEvent.new(testReference,testReference.testingFunction,testReference.timeout)
	#
	#myEventQueue.append(newEvent)
	#myEventQueue.append(newEvent2)
	#myEventQueue.append(newEvent3)
	#
	#executeQueue()
	#

func pushEventFront(_event : QueueEvent)->void:
	
	print("event pushed " + str(_event))
	if myEventQueue.is_empty():
		myEventQueue.push_front(_event)
		executeQueue()
	else:
		myEventQueue.push_front(_event)
		
func executeQueue()->void:
	
	if active==true:
		push_warning("queue is already active")
		return
	active = true
	
	while(myEventQueue.is_empty()==false):
		
		
		var currentEvent:QueueEvent = myEventQueue[0]
		if debugEnabled:
			print("current event is: " + str(currentEvent))
			
		currentEvent.callerFunction.call()
		myEventQueue.pop_front()
		
		await currentEvent.eventFinished
	
	active = false


