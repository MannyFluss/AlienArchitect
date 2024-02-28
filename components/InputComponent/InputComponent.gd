extends Node


signal InputPressed(location : Vector2)
signal InputHeld(location : Vector2, delta : float)
signal InputReleased(location : Vector2, timeHeld : float)

var heldTime := 0.0


#swiping variables



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MainTap"):
		emit_signal("InputPressed",get_viewport().get_mouse_position())
		
		heldTime = 0.0
	if Input.is_action_pressed("MainTap"):
		emit_signal("InputHeld",get_viewport().get_mouse_position(), delta)
		heldTime += delta
	if Input.is_action_just_released("MainTap"):
		emit_signal("InputReleased",get_viewport().get_mouse_position(),heldTime)

	
