extends Node2D

var fade = false

func _process(delta):
	$VideoPlayer.rect_position.x = (get_viewport().size.x / 2) - ($VideoPlayer.rect_size.x / 2)
	$Fade.margin_right = get_viewport().size.x
	if fade:
		$Fade.modulate.a += 1 * delta
	if $Fade.modulate.a >= 1:
		get_tree().change_scene("res://Title/Title Screen.tscn")

func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Title/Title Screen.tscn")

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			fade = true
	if event is InputEventJoypadButton:
		if event.pressed:
			fade = true
	if event is InputEventScreenTouch:
		if event.pressed:
			fade = true
