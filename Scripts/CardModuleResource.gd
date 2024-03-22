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
	
	
