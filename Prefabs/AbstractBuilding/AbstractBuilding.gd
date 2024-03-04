extends Node3D
class_name Building


const modulePath : String = "res://components/BuildingModules/"

@export
var myResource : BuildingResource

#so here there will be a lot of signals that need to be implemented
#modules will listen to signals and react accordingly.
signal buildingPlaced

func _enter_tree() -> void:
	if myResource == null:
		push_error("error myResource is null")
	if myResource.Model!= null:
		var to_add : Node3D = myResource.Model.instantiate()
		$Models.add_child(to_add)
		
		
func placeMe(newParent:Node3D)->void:
	position=Vector3.ZERO
	newParent.add_child(self)
	emit_signal("buildingPlaced")
	
	
	
func loadModulePackage(moduleContainer : BuildingModuleContainer)->void:
	for module : BuildingModuleResource in moduleContainer.buildingModules:
		loadModule(module)
	
	
func loadModule(module : BuildingModuleResource)->void:
	var moduleName :String = module.moduleName
	var options :Dictionary = module.options
	var path : String = modulePath+moduleName+"/"+moduleName+".tscn"
	#
	if FileAccess.file_exists(path)==false:
		push_warning(str(path)+" does not exist. aborting")
		return
	#attempt to create the module
	var newModule:BuildingModule = load(path).instatiate() as BuildingModule
	#invalid scene type loaded
	if newModule==null:
		push_warning(str(path)+" is not of type BuildingModule. Aborting")
		return
	$Modules.add_child(newModule)
	
	
	
	#var moduleToAdd 
	
	
	
	

