@tool
extends Node3D
class_name Hbox3D

@export
var spacing : Vector3 = Vector3(1, 0, 0)

@export
var center_align: bool = false

# New export variable for rotation angle in degrees
@export
var rotation_angle: float = 10.0  # Rotation angle in degrees between each child

func _enter_tree() -> void:
	update_positions()

func _process(delta: float) -> void:
	update_positions()

func update_positions() -> void:
	var offset := Vector3.ZERO
	var num_children := get_child_count()

	if center_align and num_children > 0:
		offset = -spacing * (num_children - 1) / 2.0

	# Calculate the total rotation to start from the first child
	var total_rotation_offset:float = rotation_angle * (num_children - 1) / 2.0

	for i in range(num_children):
		var child := get_child(i)
		if child is Node3D:  # Make sure the child is a 3D node
			child.position = lerp(child.position, offset + spacing * i, .3)
			
			# Apply rotation to fan out like cards
			# Assuming the rotation is around the Y-axis
			var rotation_d:float = -total_rotation_offset + rotation_angle * i
			var rotation_radians:float = deg_to_rad(rotation_d)
			child.rotation.z = lerp(child.rotation.z, rotation_radians, .3)


