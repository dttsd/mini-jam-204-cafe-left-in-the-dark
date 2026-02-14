extends CanvasModulate


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_character_health_changed(health: float) -> void:
	#self.color = Color.RED.darkened( clamp(remap(health, 100,0,1,0), 0, 1) )
	pass # Replace with function body.
