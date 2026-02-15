extends CanvasLayer

@export var fuel_bar: ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.fuel_changed.connect(_on_fuel_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fuel_changed(value: float):
	fuel_bar.value = value
