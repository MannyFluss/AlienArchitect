extends Resource
class_name CardModuleResource

@export
var moduleName:String="Default"
@export
var modulePath:String=""
@export
var options : Dictionary = {}

func registerCard(_card : CardModule)->void:
	moduleName = _card.myName
	modulePath = _card.scene_file_path
	options = _card.myOptions.duplicate()

#create regenerate function
static func regenerateCard(_cardModule:CardModuleResource)->CardModule:
	var toReturn : CardModule = load(_cardModule.modulePath).instantiate() as CardModule
	toReturn.myOptions = _cardModule.options.duplicate(true)
	return toReturn
	
	
