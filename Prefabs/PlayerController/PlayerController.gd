extends Node3D
class_name PlayerController
#this is going to be a bit dirty of a script but thats ok maybe clean up later
enum InteractionState  {
	ACTIVE,
	CARDHELD,
	DISABLED,
}




@onready
var distanceHeldFromCamera :float=25

var myState : InteractionState = InteractionState.ACTIVE

@export
var gameState : GameState

@onready
var myHand : PlayerHand = $PlayerHand as PlayerHand




func disableInteraction()->void:
	myState = InteractionState.DISABLED
	
func enableInteraction()->void:
	myState = InteractionState.ACTIVE

func _ready() -> void:
	if gameState==null:push_error("gameState not configured. Will cause issues.")
#shoots ray from camera to select first thing, basically mouse pick.

func getSelectorCastFromScreen(location : Vector2,ignoreList:Array[RID]=[])->Dictionary:
	var space_state : PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	
	var rayOrigin : Vector3 = $IsometricCamera.project_ray_origin(location)
	var rayEnd : Vector3 = rayOrigin + $IsometricCamera.project_ray_normal(location) * 50

	var query := PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd,$SelectorCast.collision_mask,ignoreList)
	query.collide_with_areas = true
	var intersection : Dictionary = space_state.intersect_ray(query)
	return intersection

func attemptToPlaceCard(mouseLocation: Vector2)->void:
	if cardSelected():
		##force intersection to only check for type tile
		var intersects : Dictionary = getSelectorCastFromScreen(mouseLocation,[getSelectedCard()])
		
		var targetTile : Tile
		if intersects.has("collider"): targetTile=intersects["collider"] as Tile
		
		if targetTile and getSelectedCard().ableToBePlayed(targetTile,gameState):
				
			getSelectedCard().playCard(targetTile,gameState)
			cardPlayed()
			pass
		else:
			deselectCard()




func _on_input_component_input_pressed(location: Vector2) -> void:
	var intersection := getSelectorCastFromScreen(location)
	if myState == InteractionState.ACTIVE and intersection:
		var pickedCard : Card = intersection["collider"]  as Card
		if pickedCard is Card:
			selectCard(pickedCard)

func _on_input_component_input_released(location: Vector2, timeHeld: float) -> void:
	attemptToPlaceCard(location)

func selectCard(card : Card)->void:
	if not cardSelected():card.SelectCard(%SelectedCard)

func deselectCard()->void:
	if cardSelected():myHand.addCardToHand(getSelectedCard())

func cardSelected()->bool:
	return not %SelectedCard.get_child_count()==0 
	
func cardPlayed()->void:
	var toDiscard:Card = getSelectedCard()
	gameState.emit_signal("cardPlayed",toDiscard)
	toDiscard.destroy()
	
	

func getSelectedCard()->Card:
	return %SelectedCard.get_child(0)

func _on_input_component_input_held(location: Vector2, delta: float) -> void:
	var rayOrigin : Vector3 = $IsometricCamera.project_ray_origin(location)
	var rayEnd : Vector3 = rayOrigin + $IsometricCamera.project_ray_normal(location) * distanceHeldFromCamera
	%SelectedCard.global_position = rayEnd
	pass # Replace with function body.
