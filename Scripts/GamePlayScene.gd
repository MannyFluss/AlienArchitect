extends Node3D
class_name GenericGameScene

#this will be passed between scenes

var myCurrentSave : GeneralSaveResource

func setSaveData(_saveData : GeneralSaveResource)->void:
	myCurrentSave = _saveData
	
func _enter_tree() -> void:
	var currentSave : GeneralSaveResource = SaveSystem.loadSave(SaveSystem.currentKey)
	
	if currentSave == null:
		push_error("save key"+ SaveSystem.currentKey +"failed to load.")
	setSaveData(currentSave)

	
	

func writeChanges()->void:
	SaveSystem.writeSave(myCurrentSave,SaveSystem.currentKey)

#target scene, save beforeHand
func goToNextScene(filePath : StringName)->void:

	#change this later
	writeChanges()
	get_tree().change_scene_to_file(filePath)
