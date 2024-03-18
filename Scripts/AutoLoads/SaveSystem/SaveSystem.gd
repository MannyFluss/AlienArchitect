extends Node


const SAVE_PATH_BASE := "user://DeckSaves/"

func writeDeckToSave(deckToSave : DeckSaveResource, saveName : String )->void:
	var dir : DirAccess = DirAccess.open(SAVE_PATH_BASE)
	if not dir:
		DirAccess.make_dir_absolute(SAVE_PATH_BASE)
	ResourceSaver.save(deckToSave,getPathFromSaveName(saveName),ResourceSaver.FLAG_NONE)
	print_debug("deck saved to " + getPathFromSaveName(saveName))



func loadDeck(saveName:String)->DeckSaveResource:
	if ResourceLoader.exists(getPathFromSaveName(saveName)):
		var packedBuildings  := ResourceLoader.load(getPathFromSaveName(saveName),"PackedBuildingSerializer")
		if packedBuildings is DeckSaveResource:
			print_debug("deck loading from " + getPathFromSaveName(saveName))

			return packedBuildings
	print_debug("deck failed to load from " + getPathFromSaveName(saveName))
	
	return null



func getPathFromSaveName(saveName:String)->String:
	return SAVE_PATH_BASE + saveName + ".tres"
