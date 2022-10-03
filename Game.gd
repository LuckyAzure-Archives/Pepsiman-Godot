extends Spatial

var cameraoffset = Vector3(0,2.9,2.6)
var camz = 0

var posy = 0

func _ready():
	match OS.get_name():
		"Android":
			$MobileControls.show()

func _process(delta):
	var camerapos = $Camera.translation
	var camerarotate = $Camera.rotation_degrees
	var pepsipos = $pepsiman.translation
	$Camera.translation.x = lerp(camerapos.x,(pepsipos.x * 1) + cameraoffset.x,delta * 10)
	$Camera.translation.y = lerp(camerapos.y,posy + ((pepsipos.y - posy) * 0.25) + cameraoffset.y,delta * 10)
	$Camera.translation.z = lerp(camerapos.z,pepsipos.z + cameraoffset.z,delta * 100)
	
	$Camera.rotation_degrees.x = lerp(camerarotate.x,-20 + ($pepsiman.fall) + ((pepsipos.y - posy) * 0.80),delta * 10)
	$Camera.rotation_degrees.z = lerp(camerarotate.z,camz,delta * 10)
	
	if $Camera.rotation_degrees.x < -90:
		$Camera.rotation_degrees.x = -90
	if $Camera.rotation_degrees.x > 90:
		$Camera.rotation_degrees.x = 90
