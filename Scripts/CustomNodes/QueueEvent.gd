extends Resource
class_name QueueEvent

var caller : Node
var callerFunction : Callable
var eventFinished : Signal


func _init(_caller: Node, _callerFunction:Callable,_eventFinished:Signal)->void:
	caller=_caller
	callerFunction=_callerFunction
	eventFinished=_eventFinished
	
