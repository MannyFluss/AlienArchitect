extends Node3D


# Called when the node enters the scene tree for the first time.



func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_input_component_input_pressed(location: Vector2) -> void:
	var space_state : PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	
	var rayOrigin : Vector3 = $IsometricCamera.project_ray_origin(location)
	var rayEnd : Vector3 = rayOrigin + $IsometricCamera.project_ray_normal(location) * 50
	
	#$SelectorCast.global_position = rayOrigin
	#$SelectorCast.target_position = rayEnd
	
	var query := PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd,$SelectorCast.collision_mask,[])
	query.collide_with_areas = true
	var intersection := space_state.intersect_ray(query)
	
	if not intersection.is_empty():
		print("you hit a thing")
	
