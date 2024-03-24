extends Node3D
class_name GenericGameScene

#this will be passed between scenes

var myCurrentSave : GeneralSaveResource

func interpretSaveData(_saveData : GeneralSaveResource)->void:
	myCurrentSave = _saveData
	
func _ready() -> void:
	var currentSave : GeneralSaveResource = SaveSystem.loadSave(SaveSystem.currentKey)
	if currentSave == null:
		push_error("save key"+ SaveSystem.currentKey +"failed to load.")
	interpretSaveData(currentSave)
	myCurrentSave.printCards()
	


#target scene, save beforeHand
func goToNextScene(filePath : StringName)->void:
	SaveSystem.writeSave(myCurrentSave,SaveSystem.currentKey)
	get_tree().change_scene_to_file(filePath)
