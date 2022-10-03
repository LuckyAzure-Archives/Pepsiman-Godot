extends KinematicBody

const horizontalspeed = 4

const speed = 15
const gravity = 25
const jumpstrength = 10

var fall = 0

func _process(delta):
	movement_input()
	movement(delta)
	animation()
	death(delta)

var MoveInput = Vector2(0,0)
var Jump = 0
var Slide = 0
var fastfall = 0

func movement_input():

	if Input.is_action_pressed("Left"):
		MoveInput.x = -1
	elif Input.is_action_pressed("Right"):
		MoveInput.x = 1
	else:
		MoveInput.x = 0
	if Input.is_action_pressed("Jump"):
		MoveInput.y = 1
	else:
		MoveInput.y = 0
	if Input.is_action_just_pressed("Jump"):
		Jump = true
	else:
		Jump = false
	if Input.is_action_just_pressed("Slide"):
		Slide = true
	else:
		Slide = false
	if Input.is_action_pressed("Down"):
		fastfall = true
	else:
		fastfall = false

var Anim = "Running"
var Animmem

func animation():
	if Animmem != Anim:
		get_node("Model/AnimationPlayer").play(Anim)
		Animmem = Anim

var scrspeed = 0

var Move = Vector3(0,0,0)
var Sliding = 0

func movement(delta):
	Move = Vector3(0,0,0)
	Move.x = MoveInput.x * horizontalspeed
	
	if !is_on_floor():
		if fall > 0 and (MoveInput.y == 0 or fastfall):
			fall -= gravity * delta
		fall -= gravity * delta
	else:
		fall = -1
		if Jump and keep_sliding == 0:
			fall = jumpstrength
			Sliding = false
			$Jump.play()
	Move.y += fall
	
	if Slide and is_on_floor() and !Sliding:
		$Slide.play()
		$Hitbox.disabled = true
		$Hitbox2.disabled = false
		Sliding = true
		Anim = "Slide"
	
	
	if Sliding:
		if Move.y < -3:
			Sliding = false
		if !get_node("Model/AnimationPlayer").is_playing() and keep_sliding == 0:
			if Anim == "Slide Over":
				Sliding = false
			else:
				$Hitbox.disabled = false
				$Hitbox2.disabled = true
				Anim = "Slide Over"
		scrspeed = lerp(scrspeed,speed,0.5 * delta)
	else:
		$Hitbox.disabled = false
		$Hitbox2.disabled = true
		scrspeed = lerp(scrspeed,speed,1 * delta)
	
	Move.z -= scrspeed
	
	if is_on_floor():
		if !Sliding:
			Anim = "Running"
	elif Move.y > 3:
		Anim = "Jump"
	elif Move.y < -3:
		Anim = "Fall"
	
	Move = move_and_slide(Move, Vector3.UP)
	
	if is_on_wall() and abs(Move.z) < scrspeed - 2:
		scrspeed = -10
		$Bonk.play()
	
	var angle = 0 - (45 * MoveInput.x)
	$Model.rotation_degrees.y = lerp($Model.rotation_degrees.y,angle,delta * 10)
	
	if is_on_floor():
		get_tree().get_current_scene().posy = translation.y

var dies = false

func death(delta):
	if !dies:
		if fall < -25:
			dies = true
			$Scream.play()
	elif fall >= -25:
		dies = false
	if fall < -75:
		get_tree().change_scene("res://Menu/Menu.tscn")

var keep_sliding = 0

func _on_SlideChecker_body_entered(body):
	if body.collision_layer == 1:
		keep_sliding += 1


func _on_SlideChecker_body_exited(body):
	if body.collision_layer == 1:
		keep_sliding -= 1

