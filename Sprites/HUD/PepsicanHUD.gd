extends Sprite

func _ready():
	position.x = get_viewport().size.x / 2
	position.y = get_viewport().size.y / 2
	rotation_degrees = rand_range(180,240)
	scale = Vector2(0.75,0.75)

var timer = 0

func _process(delta):
	timer += 1 * delta
	var pos = get_tree().get_current_scene().get_node("HUD/Left/Pepsican").position
	position = position.linear_interpolate(pos,10 * delta)
	scale = scale.linear_interpolate(Vector2(0.25,0.25),10 * delta)
	rotation_degrees = lerp(rotation_degrees,0,10 * delta)
	if timer > 1:
		queue_free()
