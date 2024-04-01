extends CardModule

var myPreview : Node3D = null

signal unhighlight


var myData : PlacementPreviewResource

@export
var myPreviewModel : PackedScene

func _ready() -> void:
	GlobalEventBus.connect("tileHighlighted",onTileHighlighted)
	GlobalEventBus.connect("tileUnhighlighted",onTileUnhighlighted)
	if myOptions.has("data"):
		myData = myOptions["data"]
	else:
		push_error("placement preview lacks data resource, will cause issues")
		push_error("to fix, go to options, add key data, supply PlacementPreviewResource")
		

func onTileHighlighted(tile : Tile)->void:
	if myCard.myStatus == myCard.cardStatus.CURRENTLY_SELECTED:
		var adjacentTiles : Array[Tile] = tile.getAdjacentTiles(myData.tiles)
		for target in adjacentTiles:
			if myCard.ableToBePlayed(tile,null):
				call_thread_safe("previewModel",target)
		
		
func onTileUnhighlighted(tile : Tile)->void:
	if myCard.myStatus == myCard.cardStatus.CURRENTLY_SELECTED:
		emit_signal("unhighlight")


func previewModel(tile : Tile)->void:
	
	var spawnTween : Tween = get_tree().create_tween()
	
	var modelDuplicate : Node3D = myPreviewModel.instantiate() as Node3D
	
	
	get_tree().current_scene.add_child(modelDuplicate)
	modelDuplicate.global_position = tile.global_position
	modelDuplicate.scale = Vector3(0.01,0.01,0.01)
	spawnTween.tween_property(modelDuplicate,"scale",Vector3.ONE,randf_range(.3,.4)).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	
	await unhighlight
	
	var despawnTween : Tween = get_tree().create_tween()
	despawnTween.tween_property(modelDuplicate,"scale",Vector3(0.01,0.01,0.01),.4).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	
	await despawnTween.finished
	
	modelDuplicate.queue_free()
