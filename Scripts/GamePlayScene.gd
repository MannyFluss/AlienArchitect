extends Node3D
class_name GenericGameScene

#this will be passed between scenes

var myCurrentSave : GeneralSaveResource

func interpretSaveData(_saveData : GeneralSaveResource)->void:
	myCurrentSave = _saveData
	
func _enter_tree() -> void:
	var currentSave : GeneralSaveResource = SaveSystem.loadSave(SaveSystem.currentKey)
	
	if currentSave == null:
		push_error("save key"+ SaveSystem.currentKey +"failed to load.")
	interpretSaveData(currentSave)
	
	#myCurrentSave.printCards()
	# print("my modules in new scene")
	# print(myCurrentSave.myBoardModules)
	
	


#target scene, save beforeHand
func goToNextScene(filePath : StringName)->void:
	# print("my modulues")
	# print(myCurrentSave.myBoardModules)
	SaveSystem.writeSave(myCurrentSave,SaveSystem.currentKey)
	get_tree().change_scene_to_file(filePath)
