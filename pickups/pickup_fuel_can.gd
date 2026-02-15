extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
	pass # Replace with function body.

func _on_area_entered(area:Area2D):
	#print("area entered by ", area)
	#print(area.get_groups())
	if area.is_in_group("grab area"):
		highlight(true)
	pass
func _on_area_exited(area:Area2D):
	#print("area exited by ", area)
	if area.is_in_group("grab area"):
		highlight(false)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func highlight(state: bool):
	modulate = Color.WHITE * 1.5 if state else Color.WHITE
	print("highlighting ", state, " ", self)
	pass
