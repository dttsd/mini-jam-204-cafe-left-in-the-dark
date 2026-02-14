extends StaticBody2D

@export var speed: float = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self.constant_linear_velocity = Vector2.RIGHT * speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2.RIGHT * speed * delta
	pass
