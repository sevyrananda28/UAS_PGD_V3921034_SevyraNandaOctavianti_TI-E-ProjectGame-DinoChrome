extends Label

var last_score

func _input(event):
	if visible:
		if event.is_action_pressed("ui_up"):
			get_tree().reload_current_scene()
			visible = not visible
			
			if last_score > Global.hi_score:
				Global.hi_score = last_score
