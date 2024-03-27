extends CardModule

var myPreview : Node3D = null

func _ready() -> void:
	GlobalEventBus.connect("tileHighlighted",onTileHighlighted)
	GlobalEventBus.connect("tileUnhighlighted",onTileUnhighlighted)

func onTileHighlighted(tile : Tile)->void:
	if myCard.myStatus == myCard.cardStatus.CURRENTLY_SELECTED:
		#var previewObject : Node3D = myCard.myBuildingInformation.Model
		var modelDuplicate : Node3D = myCard.myBuildingInformation.Model.instantiate() as Node3D
		print(modelDuplicate)
		get_tree().current_scene.add_child(modelDuplicate)
		modelDuplicate.global_position = tile.global_position
		

func onTileUnhighlighted(tile : Tile)->void:
	if myCard.myStatus == myCard.cardStatus.CURRENTLY_SELECTED:
		print("hide cardPreview")


