extends Node


# Called when the node enters the scene tree for the first time.

func _physics_process(delta: float) -> void:
	var targetCamera : Camera3D = get_viewport().get_camera_3d()
	if targetCamera==null:
		return
	var targetPosition : Vector3 = targetCamera.global_position
	var targetRotation : Vector3 = targetCamera.global_rotation
	$ShaderBlock.position = targetPosition - (targetCamera.basis.z.normalized() * 1.5) 
	$ShaderBlock.rotation = targetRotation
	
