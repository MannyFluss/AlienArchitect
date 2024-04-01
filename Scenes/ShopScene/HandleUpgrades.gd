extends Node
class_name upgradeHandler


@onready
var shopScene : ShopScene = $".."
# Called when the node enters the scene tree for the first time.
const upgradeBluePrintCount = 1


func handleUpgrade(tag : TagPurchase)->void:
	#ref to save
	var saveFile : GeneralSaveResource = shopScene.myCurrentSave
	match tag.myResource.internal_id:
		1:
			saveFile.myGameStateResource.BluePrintCount += upgradeBluePrintCount
		
