extends Resource
class_name ModuleSaveResource

@export
var pathToScene : String = ""

@export
var options : Dictionary = {}

func registerModule(module : BuildingModule)->void:
	pathToScene = module.scene_file_path
	options = module.myOptions.duplicate(true)
	
func regenerateModule(res : ModuleSaveResource)->BuildingModule:
	var toReturn :BuildingModule= null
	if ResourceLoader.exists(res.pathToScene):
		toReturn  = load(res.pathToScene).instantiate() as BuildingModule
		
	return toReturn
