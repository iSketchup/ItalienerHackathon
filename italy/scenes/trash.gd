extends Node2D

var velocity := Vector2.ZERO
var time := 0.0

@export var float_strength := 12.0
@export var float_speed := 2.0
@export var lifetime := 12.0


func setup(direction: int, speed: float) -> void:
	velocity = Vector2(direction * speed, 0)


func _process(delta: float) -> void:
	time += delta

	position += velocity * delta
	position.y += sin(time * float_speed) * float_strength * delta

	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouseclickleft"):
		print("trash clicked")
		queue_free()
	return
