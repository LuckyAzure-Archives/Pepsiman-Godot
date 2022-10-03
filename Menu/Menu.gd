extends Node2D

func _process(delta):
	$Texts.margin_right = get_viewport().size.x
	if Input.is_action_just_released("ui_accept"):
		get_tree().change_scene("res://Game.tscn")


func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			get_tree().change_scene("res://Game.tscn")
