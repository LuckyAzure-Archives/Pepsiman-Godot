extends Spatial

var setlight = 0
var lightenergy = 0

func _ready():
	pass

func _process(delta):
	music(delta)
	platforms(delta)
	glitchyplatforms(delta)
	energy = lerp(energy,0,10 * delta)
	$WorldEnvironment.environment.background_color.r = energy
	lightenergy = lerp(lightenergy,setlight,10 * delta)
	$WorldEnvironment.environment.ambient_light_energy = lightenergy

var count = 0

func platforms(delta):
	count += 1 * delta
	$MovingPlatform.translation.x = sin(count * 2) * 2
	$MovingPlatform2.translation.x = sin(-count * 2) * 2

var pos = 0
var energy = 0
var timer = 0

func music(delta):
	var glitch = get_tree().get_current_scene().get_node("HUD/GlitchyEffect")
	var pepsimanpos = get_tree().get_current_scene().get_node("pepsiman").translation
	var audiopos = $Music.get_playback_position()
	if timer > 0:
		timer -= 1 * delta
	else:
		timer = 0
	
	if Input.is_action_just_pressed("ui_accept"):
		print(pepsimanpos.z)
	if audiopos >= 10 and audiopos <= 18 and timer == 0:
		timer = 1.2
		beatglitch()
		$MoveLight.translation.z = pepsimanpos.z - 20
	if audiopos >= 18 and audiopos <= 19.5 and timer == 0:
		timer = 0.6
		beatglitch()
		$MoveLight.translation.z = pepsimanpos.z - 20
	if audiopos >= 19.5 and audiopos <= 20 and timer == 0:
		timer = 1.2
		beatglitch()
		$MoveLight.translation.z = pepsimanpos.z - 20
	if audiopos >= 20 and audiopos <= 28 and timer == 0:
		timer = 1.2
		energy = 0.2
		print(pepsimanpos.z)
		glitch.Amount = 240
		get_tree().get_current_scene().camz += 90
		$MoveLight.translation.z = pepsimanpos.z - 20
	if audiopos >= 27.5 and audiopos <= 29:
		glitch.WaveAmount += 0.01
	if audiopos >= 29 and audiopos <= 30:
		get_tree().get_current_scene().camz = 0
	if audiopos >= 29.5 and audiopos <= 33 and timer == 0:
		timer = 0.35
		energy = 0.2
	if audiopos >= 33 and audiopos <= 34 and timer == 0:
		timer = 0.25
		get_tree().get_current_scene().camz += 90
		energy = 0.75
	if audiopos >= 34 and audiopos <= 38 and timer == 0:
		timer = 0.35
		energy = 0.2
	if audiopos >= 38 and audiopos <= 39 and timer == 0:
		timer = 0.25
		get_tree().get_current_scene().camz += 90
		energy = 0.75
	if audiopos >= 39 and audiopos <= 47 and timer == 0:
		timer = 0.35
		energy = 0.2
	if audiopos >= 47 and audiopos <= 49.25:
		get_tree().get_current_scene().get_node("pepsiman").translation = Vector3(0, 1, -774)
		get_tree().get_current_scene().get_node("pepsiman").fall = 0
		get_tree().get_current_scene().posy = 10
		get_tree().get_current_scene().camz = 0
	if audiopos >= 49.25 and audiopos <= 58:
		get_tree().get_current_scene().camz = sin(audiopos * 4) * 25
		$Lights.translation = pepsimanpos
		$Lights.rotation_degrees.y += 250 * delta
		get_tree().get_current_scene().cameraoffset = Vector3(0,4.9,6)
	if audiopos >= 50.75 and audiopos <= 57 and timer == 0:
		timer = 0.80
		glitch.WaveAmount = 1
		glitch.Amount = 100
		platactivate = true
	if audiopos >= 58 and audiopos <= 59 and timer == 0:
		timer = 0.25
		get_tree().get_current_scene().camz = 0
		get_tree().get_current_scene().cameraoffset = get_tree().get_current_scene().cameraoffset * 0.8
	if audiopos >= 59.25 and audiopos <= 70:
		get_tree().get_current_scene().camz = sin(audiopos * 4) * 25
		$Lights.translation = pepsimanpos
		$Lights.rotation_degrees.y += 250 * delta
		get_tree().get_current_scene().cameraoffset = Vector3(0,4.9,6)

func beatglitch():
	var glitch = get_tree().get_current_scene().get_node("HUD/GlitchyEffect")
	glitch.WaveAmount = 1
	glitch.Amount = 500
	energy = 1

var type = 3
var platactivate = false
var plattimer = [0,0,0,0]
var platpos = [0,0,0,0]
var platposy = [0,0,0,0]
var platfallspd = [0,0,0,0]

func glitchyplatforms(delta):
	for n in 4:
		plattimer[n] = lerp(plattimer[n],0,15 * delta)
		if plattimer[n] < 0.000000001:
			platposy[n] -= platfallspd[n]
			platfallspd[n] = lerp(platfallspd[n],1,1 * delta)
	if platactivate:
		if type > 2:
			type = 0
		else:
			type += 1
		platposy[type] = 0
		platfallspd[type] = 0
		plattimer[type] = 10
		match type:
			0: platpos[type] = rand_range(-2,2)
			1: platpos[type] = rand_range(-5,2)
			2: platpos[type] = rand_range(-2,2)
			3: platpos[type] = rand_range(-2,5)
		platactivate = false
	$Glitch1.translation.y = platposy[0] + plattimer[0]
	$Glitch2.translation.y = platposy[1] + plattimer[1]
	$Glitch3.translation.y = platposy[2] + plattimer[2]
	$Glitch4.translation.y = platposy[3] + plattimer[3]
	$Glitch1.translation.x = platpos[0] + (sin(count * 50) * plattimer[0])
	$Glitch2.translation.x = platpos[1] + (sin(count * 50) * plattimer[1])
	$Glitch3.translation.x = platpos[2] + (sin(count * 50) * plattimer[2])
	$Glitch4.translation.x = platpos[3] + (sin(count * 50) * plattimer[3])
