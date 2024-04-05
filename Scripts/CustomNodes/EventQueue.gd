extends Node
class_name EventQueue 

@onready
var testReference : deleteMe = $"../SampleEventer" as deleteMe

var myEventQueue : Array[QueueEvent]

var active : bool = false

@export
var debugEnabled : bool = false

func _ready()->void:
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
	if myEventQueue.is_empty():
		myEventQueue.push_front(_event)
		active=true
		executeQueue()
	else:
		myEventQueue.push_front(_event)
		
func executeQueue()->void:
	if active==true:
		push_error("queue is already active")
		return
		
	active = true
	while(myEventQueue.is_empty()==false):
		var currentEvent:QueueEvent = myEventQueue[0]
		if debugEnabled:
			print("current event is: " + str(currentEvent))
		myEventQueue.pop_front()
		currentEvent.callerFunction.call()
		await currentEvent.eventFinished
	
	active = false


