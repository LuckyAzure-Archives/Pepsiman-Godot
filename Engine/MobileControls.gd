extends CanvasLayer

func _process(delta):
	$Actions.position.x = get_viewport().size.x
