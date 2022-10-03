extends Spatial

var cameraoffset = Vector3(0,1.75,2.5)
var timer = 0
var anim = 0

var animtimer = 0

func _ready():
	$Model/AnimationPlayer.play("Running")

func _process(delta):
	$"2D/Espuma".position.x = (get_viewport().size.x / 2) - 160
	$"Press Start".margin_right = get_viewport().size.x
	$Text.margin_right = get_viewport().size.x
	$Dark.margin_right = get_viewport().size.x
	timer += 1 * delta
	var camerapos = $Camera.translation
	var pepsipos = $Model.translation
	$Camera.translation.x = lerp(camerapos.x,pepsipos.x + cameraoffset.x,delta * 5)
	$Camera.translation.y = lerp(camerapos.y,pepsipos.y + cameraoffset.y,delta * 5)
	if anim == 0:
		if pepsipos.z > -110:
			if pepsipos.z < -40:
				$Camera.translation.z = lerp(camerapos.z,pepsipos.z + cameraoffset.z + (sin(timer * 4) * 0.5),delta * 10)
			if pepsipos.z < -36:
				$Camera.rotation_degrees.y = lerp($Camera.rotation_degrees.y,0,delta * 5)
			$Model.translation.z -= 10 * delta
		if pepsipos.z <= -110:
			if anim == 0:
				$Model/AnimationPlayer.play("Ouch")
				$Bonk.play()
				anim = 1
				$Model.translation.z = -109.5
				$Camera.translation.z -= 5
	if anim == 1:
		animtimer += 1 * delta
		$Camera.translation.z = lerp($Camera.translation.z,-106,delta * 10)
		if animtimer > 1:
			anim = 2
			$Text.show()
			$"Press Start".show()
			$Hurt.play()
	
	if anim == 2 and Input.is_action_just_pressed("ui_accept"):
		anim = 3
		animtimer = 0
		$Model.rotation_degrees.y += 180
		$Model/AnimationPlayer.play("Spua")
		EspumaSound.play()
	
	if anim < 2 and Input.is_action_just_pressed("ui_accept"):
		$Text.show()
		$"Press Start".show()
		$Model/AnimationPlayer.play("Ouch Loop")
		anim = 2
		$Model.translation.z = -109.5
		$Camera.translation.z = -106
		$Camera.rotation_degrees.y = 0
	
	if anim == 2:
		$"Press Start".show()
	if anim == 3:
		animtimer += 1 * delta
		if animtimer > 1.2:
			anim = 4
			$Text.hide()
			$"Press Start".hide()
			$Dark.show()
			$"2D/Espuma".show()
			$"2D/Espuma".play()
		$Music.volume_db -= 20 * delta
		$"Press Start".modulate.v = 0.5 - sin(timer * 12) * 0.5

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if anim == 2:
				anim = 3
				animtimer = 0
				$Model.rotation_degrees.y += 180
				$Model/AnimationPlayer.play("Spua")
				EspumaSound.play()
			if anim < 2:
				$Text.show()
				$"Press Start".show()
				$Model/AnimationPlayer.play("Ouch Loop")
				anim = 2
				$Model.translation.z = -109.5
				$Camera.translation.z = -106
				$Camera.rotation_degrees.y = 0

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ouch":
		$Model/AnimationPlayer.play("Ouch Loop")


func _on_Espuma_animation_finished():
	get_tree().change_scene("res://Menu/Menu.tscn")
