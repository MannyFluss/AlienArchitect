extends Node


const SAVE_PATH_BASE := "user://DeckSaves/"

func writeDeckToSave(deckToSave : Array[BuildingSerailizeResource], saveName : String )->void:
	var toSave : PackedBuildingSerializer = PackedBuildingSerializer.new()
	toSave.register(deckToSave)
	
	var dir : DirAccess = DirAccess.open(SAVE_PATH_BASE)
	if not dir:
		DirAccess.make_dir_absolute(SAVE_PATH_BASE)
	ResourceSaver.save(toSave,getPathFromSaveName(saveName),ResourceSaver.FLAG_NONE)

func loadDeck(saveName:String)->Array[BuildingSerailizeResource]:
	if ResourceLoader.exists(getPathFromSaveName(saveName)):
		var packedBuildings  := ResourceLoader.load(getPathFromSaveName(saveName),"PackedBuildingSerializer")
		if packedBuildings is PackedBuildingSerializer:
			return packedBuildings.myCards
		
	return []



func getPathFromSaveName(saveName:String)->String:
	return SAVE_PATH_BASE + saveName + ".tres"
