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


func _on_input_component_input_pressed(location: Vector2) -> void:
	var space_state : PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	
	var rayOrigin : Vector3 = $IsometricCamera.project_ray_origin(location)
	var rayEnd : Vector3 = rayOrigin + $IsometricCamera.project_ray_normal(location) * 50
	
	#$SelectorCast.global_position = rayOrigin
	#$SelectorCast.target_position = rayEnd
	
	var query := PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd,$SelectorCast.collision_mask,[])
	query.collide_with_areas = true
	var intersection := space_state.intersect_ray(query)
	
	if myState == InteractionState.NONE and intersection:
		var pickedCard : Card = intersection["collider"]  as Card
		if pickedCard is Card:
			pickUpCard(pickedCard)


func _on_input_component_input_released(location: Vector2, timeHeld: float) -> void:
	if %SelectedCard.get_child_count() > 0:
		myHand.addCardToHand(%SelectedCard.get_child(0))
	pass # Replace with function body.



func pickUpCard(card : Card)->void:
		if %SelectedCard.get_child_count()==0:
			card.reparent(%SelectedCard)
			card.position = Vector3.ZERO
			
func placeCard(card : Card)->void:
		if %SelectedCard.get_child_count()==0:
			card.reparent(%SelectedCard)


func _on_input_component_input_held(location: Vector2, delta: float) -> void:
	var rayOrigin : Vector3 = $IsometricCamera.project_ray_origin(location)
	var rayEnd : Vector3 = rayOrigin + $IsometricCamera.project_ray_normal(location) * distanceHeldFromCamera
	%SelectedCard.global_position = rayEnd
	pass # Replace with function body.
