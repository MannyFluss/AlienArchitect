extends MarginContainer
class_name TagPurchase

var myScene : GamePlayScene

var myResource : tagResource

func registerScene(_myScene : GamePlayScene)->void:
	myScene = _myScene
	if myScene == null:
		push_error("something has went very wrong event has no corresponding scene")
	
#not working idk just doing it manually rn
func _enter_tree() -> void:
	if myScene == null:
		var currNode : Node = get_parent()
		while currNode != get_tree().current_scene:
			if myScene is GamePlayScene:
				registerScene(myScene)
				return
			currNode = currNode.get_parent()
		push_error("myScene was not registered")
		queue_free()

func _ready() -> void:
	pass
