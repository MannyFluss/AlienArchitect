extends Node

const SAVE_PATH_BASE := "user://DeckSaves/"

func writeSave(toSave : GeneralSaveResource, saveName : String )->void:
	
	
	var dir : DirAccess = DirAccess.open(SAVE_PATH_BASE)
	if not dir:
		DirAccess.make_dir_absolute(SAVE_PATH_BASE)
	ResourceSaver.save(toSave,getPathFromSaveName(saveName),ResourceSaver.FLAG_NONE)
	print_debug("successfully saved file at " + getPathFromSaveName(saveName))

func loadSave(saveName:String)->GeneralSaveResource:
	if ResourceLoader.exists(getPathFromSaveName(saveName)):
		var SaveResource  := ResourceLoader.load(getPathFromSaveName(saveName),"GeneralSaveResource")
		if SaveResource is GeneralSaveResource:
			print_debug("successfully loaded file at " + getPathFromSaveName(saveName))

			return SaveResource
	print_debug("file failed to load at " + getPathFromSaveName(saveName))
	
	return null

func getPathFromSaveName(saveName:String)->String:
	return SAVE_PATH_BASE + saveName + ".tres"
