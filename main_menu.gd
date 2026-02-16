extends CanvasLayer

@onready var regex = RegEx.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	regex.compile("\\[.*?\\]")
	
	# select first button so controller can navigate
	$Control/MarginContainer/VBoxContainer/VBoxContainer/BeginButton.grab_focus.call_deferred()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_begin_button_pressed() -> void:
	
	
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
	pass # Replace with function body.

func _on_credits_button_pressed() -> void:
	# todo
	pass # Replace with function body.


func _on_begin_button_mouse_entered() -> void:
	#$Control/MarginContainer/VBoxContainer/VBoxContainer/BeginButton.text 
	pass # Replace with function body.


func _on_begin_button_mouse_exited() -> void:
	#var text = $Control/MarginContainer/VBoxContainer/VBoxContainer/BeginButton
	pass # Replace with function body.
