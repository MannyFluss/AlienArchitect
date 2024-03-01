extends Node3D
class_name Building


@export
var myResource : BuildingResource

@export
var test : PackedScene

signal BuildingPlaced

func _ready() -> void:
	if test!= null:
		var to_add : Node3D = test.instantiate()
		$Models.add_child(to_add)
		
		
func placeMe(newParent:Node3D)->void:
	position=Vector3.ZERO
	emit_signal("BuildingPlaced")
	reparent(newParent)
	
	
