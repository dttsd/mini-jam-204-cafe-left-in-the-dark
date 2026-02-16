extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		print("esc pressed")
		# if hiding menu, show
		if visible == false:
			show()
			get_tree().paused = true
		else:
			hide()
			get_tree().paused = false
	


func _on_continue_button_pressed() -> void:
	hide()
	get_tree().paused = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()
