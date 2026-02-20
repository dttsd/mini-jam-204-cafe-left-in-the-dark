extends Control

@export var ScoreLabel: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("SCORE WAS ", Global.score)
	ScoreLabel.text = "[wave amp=50.0 freq=5.0 connected=1]%s[/wave]" % Global.score
	
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ScoreLabel.text = "[wave amp=50.0 freq=5.0 connected=1]%s[/wave]" % Global.score
	pass


func _on_btn_try_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
	pass # Replace with function body.


func _on_btn_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	pass # Replace with function body.


func _on_child_entered_tree(node: Node) -> void:
	print("LOADED DEATH SCENE!")
	pass # Replace with function body.


func _on_tree_entered() -> void:
	print(" DEATHNODE ENTERED TREE!")
	pass # Replace with function body.
