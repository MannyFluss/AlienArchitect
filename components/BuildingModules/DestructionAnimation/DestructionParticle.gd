extends GPUParticles3D
class_name ExplosionParticles

# Called when the node enters the scene tree for the first time.
func activate() -> void:
	visible = true
	restart()
	connect("finished",queue_free)
