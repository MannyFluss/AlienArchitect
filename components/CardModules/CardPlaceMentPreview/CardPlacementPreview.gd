extends CardModule

var myPreview : Node3D = null

signal unhighlight

func _ready() -> void:
	GlobalEventBus.connect("tileHighlighted",onTileHighlighted)
	GlobalEventBus.connect("tileUnhighlighted",onTileUnhighlighted)

func onTileHighlighted(tile : Tile)->void:
	if myCard.myStatus == myCard.cardStatus.CURRENTLY_SELECTED:
		#var previewObject : Node3D = myCard.myBuildingInformation.Model
		call_thread_safe("previewModel",tile)
		

func onTileUnhighlighted(_tile : Tile)->void:
	if myCard.myStatus == myCard.cardStatus.CURRENTLY_SELECTED:
		emit_signal("unhighlight")


func previewModel(tile : Tile)->void:
	
	var spawnTween : Tween = get_tree().create_tween()
	
	var modelDuplicate : Node3D = myCard.myBuildingInformation.Model.instantiate() as Node3D
	
	get_tree().current_scene.add_child(modelDuplicate)
	modelDuplicate.global_position = tile.global_position
	modelDuplicate.scale = Vector3(0.01,0.01,0.01)
	spawnTween.tween_property(modelDuplicate,"scale",Vector3.ONE,.4).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	
	await unhighlight
	
	var despawnTween : Tween = get_tree().create_tween()
	despawnTween.tween_property(modelDuplicate,"scale",Vector3(0.01,0.01,0.01),.4).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	
	await despawnTween.finished
	
	modelDuplicate.queue_free()
	
