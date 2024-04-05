extends Node3D
class_name Building


const modulePath : String = "res://components/BuildingModules/"

@export
var myResource : BuildingResource

#so here there will be a lot of signals that need to be implemented
#modules will listen to signals and react accordingly.
signal buildingPlaced

signal buildingDestroyed

func getNeighboringBuilding(target : Vector2)->Building:
	var myBoard:Board = getMyBoard()
	if myBoard:
		var myTile : Tile = getMyTile()
		if myTile == null:
			push_warning("building has no tile")
			return null
		return myBoard.getBuilding(myTile.myCoordinates + target)
	return null

func _enter_tree() -> void:
	if myResource == null:
		push_error("error myResource is null")
	if myResource.Model!= null:
		var to_add : Node3D = myResource.Model.instantiate()
		$Models.add_child(to_add)
	
	loadModulePackage(myResource.myModules)
		
		
func placeMe(newParent:Node3D)->void:
	position=Vector3.ZERO
	newParent.add_child(self)
	emit_signal("buildingPlaced")
	GlobalEventBus.emit_signal("buildingPlaced",self)
	
func getMyTile()->Tile:
	var curr :Node = get_parent()
	while curr!= get_tree().current_scene:
		if curr is Tile:
			return curr
		curr = curr.get_parent()
	return null
	
func loadModulePackage(moduleContainer : BuildingModuleContainer)->void:
	if moduleContainer==null:
		#push_error("no modules configured for building "+ str(self))
		return
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
	var newModule:BuildingModule = load(path).instantiate() as BuildingModule
	#invalid scene type loaded
	if newModule==null:
		push_warning(str(path)+" is not of type BuildingModule. Aborting")
		return
	newModule.registerBuilding(self,options)
	$Modules.add_child(newModule)
	

		
		
	
	pass

func attemptDestroy()->bool:
	destroy()
	return true

func destroy()->void:
	emit_signal("buildingDestroyed")
	queue_free()
	pass
	
func getMyBoard()->Board:
	var curr : Node = get_parent()
	while curr != get_tree().current_scene:
		if curr is Board:
			return curr
		curr=curr.get_parent()
	
	return null
	
	
	

