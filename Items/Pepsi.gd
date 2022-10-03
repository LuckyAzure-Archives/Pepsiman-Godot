extends Sprite3D


func _on_Item_PepsiCan_area_entered(area):
	if area.name == "Char_Pepsiman":
		get_tree().get_current_scene().get_node("HUD").Pepsican()
		queue_free()
