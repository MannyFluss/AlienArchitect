extends Node3D
class_name Building


@export
var myResource : BuildingResource

func _ready() -> void:
	if myResource == null:
		push_error("error myResource is null")
	
	if myResource.Model!= null:
		var to_add : Node3D = myResource.Model.instantiate()
		$Models.add_child(to_add)
		
		
func placeMe(newParent:Node3D)->void:
	position=Vector3.ZERO
	newParent.add_child(self)
	
	
