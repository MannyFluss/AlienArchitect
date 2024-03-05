extends Area3D
class_name Card

enum cardStatus{
	UNKNOWN,
	IN_HAND,
	CURRENTLY_SELECTED,
	DELETING,
	IN_DECK,
}

var myStatus : cardStatus = cardStatus.UNKNOWN

#this contains all of the information we need to create this card dynamically
@export
var myBuildingScene : PackedScene

var myBuildingInformation : BuildingResource

func _ready() -> void:
	var myBuildingInstance : Building = myBuildingScene.instantiate() as Building
	if myBuildingInstance is Building:
		setCardGraphics(myBuildingInstance.myResource)
		myBuildingInformation = myBuildingInstance.myResource.duplicate(true)
		myBuildingInstance.queue_free()
	else:
		assert(false,"myBuildingScene is not set properly.")
	#$CanvasLayer/CardGraphics/SubViewportContainer/SubViewport/Control/ColorRect.color = Color(randf(),randf(),randf())
	#$CanvasLayer/CardGraphics/SubViewportContainer/SubViewport/Control/ColorRect/ColorRect.color = Color(randf(),randf(),randf())


func setCardGraphics(res : BuildingResource)->void:
	%CostLabel.text = "[center]"+str(res.bluePrintCost)
	%DescriptorLabel.text = "[center]"+res.description
	#%ArtTexture to be implemented
	%TitleLabel.text = "[center]"+res.name
#implement animation here for destruction
func destroy()->void:
	myStatus = cardStatus.DELETING
	queue_free()

func ableToBePlayed(_tile : Tile, _gameState : GameState)->bool:
	if _tile.hasBuilding()==true: return false
	if GameState!=null:
		return _gameState.checkCardPlayability(myBuildingInformation)
	#add game state stuff here, basically take away money
	return true

func playCard(_tile : Tile, _gameState : GameState)->void:
	#place building, update game state
	var myBuildingInstance : Building = myBuildingScene.instantiate() as Building
	_tile.placeBuilding(myBuildingInstance)
	
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


#this is moving the card
func addToHand(hand : Hbox3D)->void:
	if is_inside_tree():
		reparent(hand)
	else:
		hand.add_child(self)
		#hand.addCardToHand(self)
	myStatus = cardStatus.IN_HAND
	unhighlight()

func _on_mouse_entered() -> void:
	if myStatus == cardStatus.IN_HAND:
		highlight()

func _on_mouse_exited() -> void:
	if myStatus == cardStatus.IN_HAND:
		unhighlight()
