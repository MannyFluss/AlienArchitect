extends Node3D
#this is going to be a bit dirty of a script but thats ok maybe clean up later
enum InteractionState  {
	NONE,
	CARDHELD,
}

@onready
var distanceHeldFromCamera :float=25

var myState : InteractionState = InteractionState.NONE


@onready
var myHand : PlayerHand = $PlayerHand as PlayerHand
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
		var intersects :Dictionary = getSelectorCastFromScreen(mouseLocation,[getSelectedCard()])
		if intersects:
			#place that shit
			print("implement placement here")
			pass
		else:
			myHand.addCardToHand(getSelectedCard())
	pass




func _on_input_component_input_pressed(location: Vector2) -> void:
	var intersection := getSelectorCastFromScreen(location)
	if myState == InteractionState.NONE and intersection:
		var pickedCard : Card = intersection["collider"]  as Card
		if pickedCard is Card:
			pickUpCard(pickedCard)




func _on_input_component_input_released(location: Vector2, timeHeld: float) -> void:
	attemptToPlaceCard(location)

	pass # Replace with function body.


func pickUpCard(card : Card)->void:
	if not cardSelected():
		card.SelectCard(%SelectedCard)
		



func cardSelected()->bool:
	return not %SelectedCard.get_child_count()==0 

func getSelectedCard()->Card:
	return %SelectedCard.get_child(0)


func _on_input_component_input_held(location: Vector2, delta: float) -> void:
	var rayOrigin : Vector3 = $IsometricCamera.project_ray_origin(location)
	var rayEnd : Vector3 = rayOrigin + $IsometricCamera.project_ray_normal(location) * distanceHeldFromCamera
	%SelectedCard.global_position = rayEnd
	pass # Replace with function body.
