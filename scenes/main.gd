extends Node

## to store:
# van fuel
# awakeness
# player score
var score: int = 3:
	set(value):
		score = value
		# update ui
		$CanvasLayer/GUI/HBoxContainer/ScoreLabel.text = "score: %s" % score

# update score from main



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score += 1
	pass
