extends Resource
class_name BuildingSaveResource


@export
var pathToScene : String = ""
@export
var pathToModelScene : String = ""
@export
var myModules : Array[ModuleSaveResource] = []

func registerBuilding(building : Building)->void:
	var modules : Array[Node]= building.getMyModules()
	for mod in modules:
		if mod is BuildingModule:
			myModules.append(mod.serializeMe())

	pathToScene = building.scene_file_path
	pathToModelScene = building.getMyModelPath()
	
func regenerateBuilding(res : BuildingSaveResource)->PackedScene:
	var newBuilding : PackedScene = null
	if ResourceLoader.exists(res.pathToScene):
		newBuilding = load(res.pathToScene).instantiate() 
		return newBuilding
	return null


# func regenerateBuilding(res : BuildingSaveResource)->Building:
# 	var newBuilding : Building = null
# 	var newModel : PackedScene = null
	
# 	if ResourceLoader.exists(res.pathToScene):
# 		newBuilding = load(res.pathToScene).instantiate() as Building
# 	if newBuilding == null:
# 		push_error("building failed to initialize. Aborting")
# 		return null
		
# 	if ResourceLoader.exists(res.pathToModelScene):
# 		newModel = load(res.pathToModelScene).instantiate()
# 	if newModel == null:
# 		push_error("building model has failed to instantiate. Aborting")
# 		return null
# 	newBuilding.myResource.Model = newModel
# 	for module in res.myModules:
# 		var newModule : BuildingModule = module.regenerateModule(module)
# 		if newModule != null:
# 			newBuilding.loadModuleInstance(newModule)
# 		else:
# 			push_error("module failed to load")

# 	return newBuilding
	
#static func regenerateModule(res : ModuleSaveResource)->BuildingModule:
	#var toReturn :BuildingModule= null
	#if ResourceLoader.exists(res.pathToScene):
		#toReturn  = load(res.pathToScene).instantiate() as BuildingModule
		#
	#return toReturn
