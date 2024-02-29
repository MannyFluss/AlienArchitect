extends Area3D
class_name Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/CardGraphics/SubViewportContainer/SubViewport/Control/ColorRect.color = Color(randf(),randf(),randf())
	$CanvasLayer/CardGraphics/SubViewportContainer/SubViewport/Control/ColorRect/ColorRect.color = Color(randf(),randf(),randf())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_mouse_entered() -> void:
	pass # Replace with function body.


func _on_area_mouse_exited() -> void:
	pass # Replace with function body.
