extends Resource
class_name BoardModuleSaveResource


@export
var moduleScenePath : String
@export
var moduleOptions : Dictionary = {}

static func registerModule(_module : BoardModule)->BoardModuleSaveResource:
	var toReturn : BoardModuleSaveResource = BoardModuleSaveResource.new()
	toReturn.moduleScenePath = _module.scene_file_path
	toReturn.moduleOptions = _module.myOptions.duplicate(true)
	
	return toReturn

static func regenerateModule(_res : BoardModuleSaveResource)->BoardModule:
	var moduleToReturn : BoardModule = load(_res.moduleScenePath).instantiate() as BoardModule
	if moduleToReturn==null:return null
	moduleToReturn.myOptions = _res.moduleOptions.duplicate(true)
	
	return moduleToReturn
