extends CanvasLayer
class_name LoadGameMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#for file
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_item_rect_changed() -> void:
	queue_free()
