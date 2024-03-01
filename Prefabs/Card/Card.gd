extends Area3D
class_name Card

enum cardStatus{
	UNKNOWN,
	IN_HAND,
	CURRENTLY_SELECTED,
}

var myStatus :cardStatus = cardStatus.IN_HAND


func _ready() -> void:
	pass
	#$CanvasLayer/CardGraphics/SubViewportContainer/SubViewport/Control/ColorRect.color = Color(randf(),randf(),randf())
	#$CanvasLayer/CardGraphics/SubViewportContainer/SubViewport/Control/ColorRect/ColorRect.color = Color(randf(),randf(),randf())

func _process(delta: float) -> void:
	pass

func highlight()->void:
	var myTween : Tween = get_tree().create_tween()
	myTween.tween_property($CardRender,"scale",Vector3(1.2,1.2,1.2),.05).set_ease(Tween.EASE_IN)

func unhighlight()->void:
	var myTween : Tween = get_tree().create_tween()
	myTween.tween_property($CardRender,"scale",Vector3(1.0,1.0,1.0),.05).set_ease(Tween.EASE_OUT)

func SelectCard(selectorNode : Node3D)->void:
	reparent(selectorNode)
	position = Vector3.ZERO
	unhighlight()
	myStatus = cardStatus.CURRENTLY_SELECTED

func addCardToHand(hand : Hbox3D)->void:
	reparent(hand)
	myStatus = cardStatus.IN_HAND
	unhighlight()

func _on_mouse_entered() -> void:
	if myStatus == cardStatus.IN_HAND:
		highlight()

func _on_mouse_exited() -> void:
	if myStatus == cardStatus.IN_HAND:
		unhighlight()
