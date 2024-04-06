extends MarginContainer
class_name TagPurchase

var myScene : ShopScene

var myResource : tagResource

func registerScene(_myScene : ShopScene)->void:
	myScene = _myScene
	if myScene == null:
		push_error("something has went very wrong event has no corresponding scene")
	
#not working idk just doing it manually rn
func _enter_tree() -> void:
	return


func _ready() -> void:
	pass
	
func setBasedOnResource(_res : tagResource)->void:
	myResource = _res
	%Title.text = "[center]"+ _res.name
	%TextureRect.texture = _res.icon
	%Descriptor.text = _res.description
	%Purchase.text = "purchase " + str(_res.cost) + " credits"
	
func _on_purchase_pressed() -> void:
	if myScene.myCurrentSave.myGameStateResource.currencyCount >= myResource.cost:
		myScene.myCurrentSave.myGameStateResource.currencyCount -= myResource.cost
		GlobalEventBus.emit_signal("TagPurchased",self)
		queue_free()
	else:
		pass
