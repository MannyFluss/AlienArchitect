extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween : Tween = get_tree().create_tween()
	%MainMenuLogo.pivot_offset = size/2
	tween.tween_property(%MainMenuLogo,"scale",Vector2(1.1,1.1),2.0)
	
	
	pass # Replace with function body.

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
