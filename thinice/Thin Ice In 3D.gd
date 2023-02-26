extends Position3D

var funni = 0

func _process(delta):
	funni += delta
	$Legs.rotation_degrees.x = 0 + sin(funni * 10) * 10
	$Legs/Torso/Head.rotation_degrees.x = 0 + sin(funni * 10) * 10
	$Legs/LeftArm.rotation_degrees.x = 0 + sin(funni * 10) * 40
	$Legs/RightArm.rotation_degrees.x = 0 + sin(funni * 10) * -40
