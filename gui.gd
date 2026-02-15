extends CanvasLayer

@export var fuel_bar: ProgressBar
@export var awake_bar: ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.fuel_changed.connect(_on_fuel_changed)
	Global.awake_changed.connect(_on_awakeness_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fuel_changed(value: float):
	fuel_bar.value = value

func _on_awakeness_changed(value: float):
	awake_bar.value = value
