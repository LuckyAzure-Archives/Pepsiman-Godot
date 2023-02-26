extends Position2D

var dunno = 0
var flyspeed = 0

func _process(delta):
	flyspeed += delta
	position.y -= flyspeed
	dunno += delta * 0.75
	$Legs.scale.y = 1 + sin(dunno * 5) * 0.05
	$Legs/Torso.scale.y = 1 - sin(dunno * 5) * 0.05
	$Legs/Torso.rotation_degrees = sin(dunno * 2.5) * 2
	$Legs/Torso/Head.rotation_degrees = sin(dunno * 2.5) * -2
	$Legs/Torso/Leftarm.rotation_degrees = sin(dunno * 20 - 1) * 10
	$Legs/Torso/Rightarm.rotation_degrees = sin(dunno * 15 - 1) * -10


func _backup(delta):
	dunno += delta * 0.75
	$Legs.scale.y = 1 + sin(dunno * 5) * 0.05
	$Legs/Torso.scale.y = 1 - sin(dunno * 5) * 0.05
	$Legs/Torso.rotation_degrees = sin(dunno * 2.5) * 2
	$Legs/Torso/Head.rotation_degrees = sin(dunno * 2.5) * -2
	$Legs/Torso/Leftarm.rotation_degrees = sin(dunno * 5 - 1) * 4
	$Legs/Torso/Rightarm.rotation_degrees = sin(dunno * 5 - 1) * -4
