extends CardModule


func _ready() -> void:
	GlobalEventBus.connect("tileHighlighted",onTileHighlighted)
	GlobalEventBus.connect("tileUnhighlighted",onTileUnhighlighted)

func onTileHighlighted(tile : Tile)->void:
	if myCard.myStatus == myCard.cardStatus.CURRENTLY_SELECTED:
		print("show cardPreview")

func onTileUnhighlighted(tile : Tile)->void:
	if myCard.myStatus == myCard.cardStatus.CURRENTLY_SELECTED:
		print("hide cardPreview")
