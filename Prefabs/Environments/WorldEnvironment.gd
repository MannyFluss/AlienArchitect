extends WorldEnvironment

@export
var rotationSpeed :Vector3 = Vector3(randf_range(-.01,.01),randf_range(-.01,.01),randf_range(-.01,.01))
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	environment.sky_rotation = Vector3(randf_range(0,360),randf_range(0,360),randf_range(0,360))
	
	#var myThing : ShaderMaterial = environment.sky.sky_material 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	environment.sky_rotation += rotationSpeed * delta
	pass
