extends Node


# Called when the node enters the scene tree for the first time.

func _enter_tree() -> void:
	#connect()
	
	pass
	
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#this is lazy but for now just move to current camera's position
#func _process(delta: float) -> void:
	#if get_viewport().get_camera_3d()!=null:
		#%ShaderBlock.global_position = get_viewport().get_camera_3d().global_position
		#%ShaderBlock.global_rotation = get_viewport().get_camera_3d().global_rotation
		#%ShaderBlock.global_position -= get_viewport().get_camera_3d().basis.z
		#
	#else:
		#pass
