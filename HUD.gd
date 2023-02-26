extends CanvasLayer

var pepsis = 0

func _process(delta):
	$Right.position.x = get_viewport().size.x
	$GlitchyEffect.margin_right = get_viewport().size.x
	#distancemeter(delta)
	pepsicancounter()

func distancemeter(delta):
	var pepsipos = get_tree().get_current_scene().get_node("pepsiman").translation
	var start = get_tree().get_current_scene().get_node("Map/Start").translation
	var end = get_tree().get_current_scene().get_node("Map/End").translation
	var length = start.z - end.z
	$Right/Distance/Dist_Man.position.x = -42 - (((pepsipos.z - start.z) / length) * 84)

func pepsicancounter():
	var text = str(pepsis)
	$Left/PepsiCounter.text = str(pepsis)

var pepsican_path = preload("res://Sprites/HUD/PepsicanHUD.tscn")

func Pepsican():
	$Pepsican.play()
	pepsis += 1
	var pepsican = pepsican_path.instance()
	add_child(pepsican)
	
