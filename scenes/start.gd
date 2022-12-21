extends Label

func _ready():
	get_tree().paused = true
	
	
func _input(event):
	if visible:
		if event.is_action_pressed("ui_up") and get_tree().paused:
			visible = not visible
			get_tree().paused = false
