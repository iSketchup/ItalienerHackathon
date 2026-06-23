extends Node2D

@export var trash_scene: PackedScene = preload("res://scenes/trash.tscn")

@export var spawn_area := Rect2(Vector2(200, 100), Vector2(500, 300))

@export var min_spawn_time := 0.5
@export var max_spawn_time := 1.5

@export var min_speed := 40.0
@export var max_speed := 90.0

var rng := RandomNumberGenerator.new()
var spawn_timer := 0.0

var score := 0

@onready var score_label: Label = $ScoreLabel


func _ready() -> void:
	rng.randomize()
	_update_score_label()
	_reset_spawn_timer()


func _process(delta: float) -> void:
	spawn_timer -= delta

	if spawn_timer <= 0.0:
		_spawn_trash()
		_reset_spawn_timer()


func _spawn_trash() -> void:
	var trash := trash_scene.instantiate() as Trash
	add_child(trash)

	trash.position = Vector2(
		rng.randf_range(spawn_area.position.x, spawn_area.end.x),
		rng.randf_range(spawn_area.position.y, spawn_area.end.y)
	)

	trash.scored.connect(_on_trash_scored)

	var direction := 1
	

	var speed := rng.randf_range(min_speed, max_speed)
	trash.setup(direction, speed)


func _on_trash_scored(points: int) -> void:
	score += points
	_update_score_label()


func _update_score_label() -> void:
	score_label.text = "Score: %d" % score


func _reset_spawn_timer() -> void:
	spawn_timer = rng.randf_range(min_spawn_time, max_spawn_time)
