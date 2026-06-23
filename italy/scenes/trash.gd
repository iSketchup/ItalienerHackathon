class_name Trash
extends Area2D

var velocity := Vector2.ZERO
var time := 0.0
var was_clicked := false

@export var float_strength := 12.0
@export var float_speed := 2.0
@export var lifetime := 12.0

signal scored(points: int)


func _ready() -> void:
	$Label.visible = false


func setup(direction: int, speed: float) -> void:
	velocity = Vector2(direction * speed, 0)


func _process(delta: float) -> void:
	time += delta

	position += velocity * delta
	position.y += sin(time * float_speed) * float_strength * delta

	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()


func get_point_value() -> int:
	return 67


func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if was_clicked:
		return

	if event.is_action_pressed("mouseclickleft"):
		was_clicked = true

		var points := get_point_value()
		scored.emit(points)

		$Label.text = "+%d" % points
		$Label.visible = true

		$AnimatedSprite2D.visible = false
		$CollisionShape2D.set_deferred("disabled", true)

		await get_tree().create_timer(0.4).timeout
		queue_free()
