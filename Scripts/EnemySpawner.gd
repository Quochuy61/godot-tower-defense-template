extends Node2D

@export var enemy_scene: PackedScene
@export var path: Path2D
@export var spawn_delay: float = 2.0

var timer := 0.0

func _process(delta: float):
	timer += delta
	if timer >= spawn_delay:
		timer = 0
		spawn_enemy()

func spawn_enemy():
	var follow = PathFollow2D.new()
	path.add_child(follow)

	var enemy = enemy_scene.instantiate()
	follow.add_child(enemy)

	enemy.path_follow = follow
