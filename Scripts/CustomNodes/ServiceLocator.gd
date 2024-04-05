extends Node
class_name EventQueueServiceLocator

static var myEventQueue : EventQueue

static func getEventQueue()-> EventQueue:
	assert(myEventQueue!=null,"event queue is null")
	return myEventQueue

static func register(toRegister : EventQueue)->void:
	myEventQueue = toRegister
	pass
