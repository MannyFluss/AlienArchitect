extends Area3D
class_name Card

enum cardStatus{
	UNKNOWN,
	IN_HAND,
	CURRENTLY_SELECTED,
	DELETING,
	IN_DECK,
	IN_SHOP,
}
@export
var myStatus : cardStatus = cardStatus.UNKNOWN

#this contains all of the information we need to create this card dynamically
@export
var myBuildingScene : PackedScene
@export
var myArtCamera : Camera3D
@export
var my3DSprite : Sprite3D

var myBuildingInformation : BuildingResource

@export
var moduleContainer : Node3D

#goes off right before building is placed
signal preBuildingPlaced(newBuilding : Building)

signal postBuildingPlaced(newBuilding : Building)

signal cardDrawn

func _ready() -> void:
	var myBuildingInstance : Building = myBuildingScene.instantiate() as Building
	$cardArtRendering.own_world_3d = true
	
	if myBuildingInstance is Building:
		setCardGraphics(myBuildingInstance.myResource)
		myBuildingInformation = myBuildingInstance.myResource.duplicate(true)
		#error because it doesnt actually exist
		for module : CardModuleResource in myBuildingInformation.myCardModules:
			var newMod : CardModule = CardModuleResource.regenerateCard(module)
			$Modules.add_child(newMod)
		myBuildingInstance.queue_free()
		
		#in here we can also set the card preview animations
		
	else:
		assert(false,"myBuildingScene is not set properly.")


func setCardGraphics(res : BuildingResource)->void:
	%CostLabel.text = "[center]"+str(res.bluePrintCost)
	%DescriptorLabel.text = "[center]"+res.description
	%TitleLabel.text = "[center]"+res.name
	#if this crashes here, buildingResource needs to be assigned a model
	var modelDuplicate : Node3D = res.Model.duplicate().instantiate() as Node3D
	
	%ModelMarker.add_child(modelDuplicate)
	
#implement animation here for destruction
func destroy()->void:
	myStatus = cardStatus.DELETING
	queue_free()

#this will need to be changed
#this is kinda bad whatever
func ableToBePlayed(_tile : Tile, _gameState : GameState)->bool:
	if _tile.hasBuilding()==true: return false
	_gameState = get_tree().get_first_node_in_group("gamestate")
	if _gameState!=null:
		return _gameState.checkCardPlayability(myBuildingInformation)
	#add game state stuff here, basically take away money
	return true

func playCard(_tile : Tile, _gameState : GameState)->void:
	#place building, update game state
	var myBuildingInstance : Building = myBuildingScene.instantiate() as Building
	emit_signal("preBuildingPlaced",myBuildingInstance)
	#this is where we need to edit that building, before its placed
	_tile.placeBuilding(myBuildingInstance)
	
	emit_signal("postBuildingPlaced",myBuildingInstance)
	



func highlight()->void:
	var myTween : Tween = get_tree().create_tween()
	myTween.set_parallel()
	myTween.tween_property(self,"scale",Vector3(1.2,1.2,1.2),.05).set_ease(Tween.EASE_IN)
	myTween.tween_property($CardRender,"rotation_degrees",Vector3.ZERO,.05).set_ease(Tween.EASE_IN)
	

func unhighlight()->void:
	var myTween : Tween = get_tree().create_tween()
	myTween.set_parallel()
	myTween.tween_property(self,"scale",Vector3(1.0,1.0,1.0),.05).set_ease(Tween.EASE_OUT)
	myTween.tween_property($CardRender,"rotation_degrees",Vector3.ZERO,.05).set_ease(Tween.EASE_IN)
	myTween.tween_property($CardRender,"modulate",Color.WHITE,.05)


func SelectCard(selectorNode : Node3D)->void:
	reparent(selectorNode)
	position = Vector3.ZERO
	unhighlight()
	myStatus = cardStatus.CURRENTLY_SELECTED
	



#this is moving the card
func addToHand(hand : Hbox3D)->void:
	if is_inside_tree():
		reparent(hand)
		position = hand.position + Vector3(0,-10,0)
	else:
		hand.add_child(self)
		position = hand.position + Vector3(0,-10,0)
		#hand.addCardToHand(self)
	myStatus = cardStatus.IN_HAND
	unhighlight()
	emit_signal("cardDrawn")

func loadModule(_module : CardModuleResource)->void:
	var newModule : CardModule = load(_module.modulePath).instantiate() as CardModule
	if newModule==null:return
	$Modules.add_child(newModule)
	


func _on_mouse_entered() -> void:
	if myStatus == cardStatus.IN_HAND or myStatus == cardStatus.IN_SHOP:
		highlight()

func _on_mouse_exited() -> void:
	if myStatus == cardStatus.IN_HAND or myStatus == cardStatus.IN_SHOP:
		unhighlight()
