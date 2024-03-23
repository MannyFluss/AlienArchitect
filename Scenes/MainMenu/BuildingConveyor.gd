extends Node3D


# Called when the node enters the scene tree for the first time.
@export
var rotationSpeed : float = 1.0

func _ready() -> void:
	for child : Node3D in $Conveyor.get_children():
		child.position = Vector3(7*roll(),0,7*roll())
	getRandomBuilding().position = Vector3.ZERO

func _process(delta: float) -> void:
	$DirectionalLight3D.rotate_y(delta*rotationSpeed)
	
func roll()->int:
	
	if randf() >= .5:
		return -1
	return 1


func _on_timer_timeout() -> void:
	var middle : Node3D = findCurrentMiddle()
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(middle,"position",Vector3(7*roll(),0,7*roll()),0.5).set_ease(Tween.EASE_OUT_IN)
	var newMiddle:Node3D = getRandomBuilding()
	tween.tween_property(newMiddle,"position",Vector3.ZERO,0.5).set_ease(Tween.EASE_IN_OUT)
	
	
func findCurrentMiddle()->Node3D:
	for child : Node3D in $Conveyor.get_children():
		if child.position == Vector3.ZERO: return child
	return $Conveyor.get_child(0)
func getRandomBuilding()->Node3D:
	return $Conveyor.get_child(randi_range(0,$Conveyor.get_child_count()-1)) as Node3D
	
	
