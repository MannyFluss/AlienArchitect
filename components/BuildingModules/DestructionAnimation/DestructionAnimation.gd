extends BuildingModule

var verticalOffset : float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	myBuilding.connect("buildingDestroyed",onBuildingDestroyed)
	


func onBuildingDestroyed()->void:
	var destroyParticles : ExplosionParticles = $DestructionParticle.duplicate()
	get_tree().current_scene.add_child(destroyParticles)
	destroyParticles.global_position = myBuilding.global_position
	destroyParticles.activate()
