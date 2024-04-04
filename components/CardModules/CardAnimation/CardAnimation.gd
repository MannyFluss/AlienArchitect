extends CardModule

@export
var animationDistanceThreshold : float = 100
@export
var cameraSwayFactor : int = 1
@export
var cardSwayFactor : int = 20
var lastPosition2D : Vector2 = Vector2(0,0)



func _physics_process(delta: float) -> void:
	if myCard.myStatus == myCard.cardStatus.CURRENTLY_SELECTED:
		shrinkingAnimation()
		artCameraLean()
		lastPosition2D = unprojectPosition(self)
		
	


func artCameraLean()->void:
	var cardVelocity : Vector2 = (unprojectPosition(self) - lastPosition2D).normalized() * cameraSwayFactor
	myCard.myArtCamera.rotation_degrees = lerp(myCard.myArtCamera.rotation_degrees,
		Vector3(cardVelocity.y,cardVelocity.x,0),.1)
		
	cardVelocity = (unprojectPosition(self) - lastPosition2D).normalized() * cardSwayFactor
	
	myCard.my3DSprite.rotation_degrees = lerp(myCard.my3DSprite.rotation_degrees,
		Vector3(cardVelocity.y,cardVelocity.x,0),.05)
	#myCard.my3DSprite.rotation_degrees = Vector3(90,90,0) 
	
#this will also modulate the color
func shrinkingAnimation()->void:
	var closestTile : Tile = getClosestTile(get_tree().get_nodes_in_group("tiles"))
	var distanceToClosestTile : float = unprojectPosition(closestTile).distance_to(unprojectPosition(self)) - 85
	var remapTarget : float = remap(distanceToClosestTile,0.1,animationDistanceThreshold+.1 ,0,.8)
	remapTarget = clampf(remapTarget - .1,0.01,1.0)
	myCard.scale = lerp(myCard.scale,Vector3(remapTarget,remapTarget,1),.1)
	#myCard.my3DSprite.modulate.a = lerpf(myCard.my3DSprite.modulate.a ,remapTarget -.3 ,.1)
	

func getClosestTile(tiles : Array[Node])->Tile:
	var camera : Camera3D = get_viewport().get_camera_3d()
	var cardUnprojected : Vector3 = global_transform.origin
	var card2D : Vector2 = camera.unproject_position(cardUnprojected)
	
	var closest:Tile = null
	var closestDistance:float = 1000000000
	for tile:Node in tiles:
		if tile is Tile:
			var tileUnprojected : Vector3 = tile.global_transform.origin
			var tile2D : Vector2 = camera.unproject_position(tileUnprojected)
			
			var dist:float = tile2D.distance_squared_to(card2D)
			
			if dist < closestDistance:
				closestDistance = dist
				closest = tile
			 
	return closest

func unprojectPosition(target : Node3D)->Vector2:
	var camera : Camera3D = get_viewport().get_camera_3d()
	return camera.unproject_position(target.global_transform.origin)

