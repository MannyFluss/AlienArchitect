extends Node3D
class_name Building


var modulePath : String = "res://components/BuildingModules/"

@export
var myResource : BuildingResource

func _enter_tree() -> void:
	if myResource == null:
		push_error("error myResource is null")
	if myResource.Model!= null:
		var to_add : Node3D = myResource.Model.instantiate()
		$Models.add_child(to_add)
		
		
func placeMe(newParent:Node3D)->void:
	position=Vector3.ZERO
	newParent.add_child(self)
	
func loadModulePackage(moduleContainer : BuildingModuleContainer)->void:
	for module : BuildingModuleResource in moduleContainer.buildingModules:
		loadModule(module)
	
	
func loadModule(module : BuildingModuleResource)->void:
	var moduleName :String = module.moduleName
	var options :Dictionary = module.options
	var path : String = modulePath+moduleName+"/"+moduleName+".tscn"
	if FileAccess.file_exists(path)==false:return
		
	

