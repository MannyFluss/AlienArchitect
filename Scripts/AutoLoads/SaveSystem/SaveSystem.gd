extends Node

#I dont like this but it will do for now
var currentKey : String = ""

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
			seed(SaveResource.randomSeed)
			print_debug("successfully loaded file at " + getPathFromSaveName(saveName))

			return SaveResource
	print_debug("file failed to load at " + getPathFromSaveName(saveName))
	
	return null

func getAllSaveKeys()->Array[String]:
	var toReturn:Array[String] = []
	var dir : DirAccess = DirAccess.open(SAVE_PATH_BASE)
	if not dir:
		push_error("no save file directory exists")
		return []
	if dir:
		dir.list_dir_begin()
		var file_name : String = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				#print("Found file: " + file_name)
				toReturn.append(file_name.substr(0,file_name.length()-5))
			file_name = dir.get_next()
	
	
	return toReturn
	



func getPathFromSaveName(saveName:String)->String:
	return SAVE_PATH_BASE + saveName + ".tres"
