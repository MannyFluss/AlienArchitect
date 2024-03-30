extends Event
class_name EndScreen




func _ready() -> void:
	myScene.gainCurrency(5)
	%MoneyLabel.text = "[center] Money Earned: " + str(myScene.getCurrency())



func _on_button_pressed() -> void:
	myScene.endRound()

