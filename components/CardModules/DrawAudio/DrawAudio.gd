extends CardModule


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	myCard.connect("cardDrawn",onCardDrawn)
	

func onCardDrawn()->void:
	$AudioStreamPlayer3D.play()
