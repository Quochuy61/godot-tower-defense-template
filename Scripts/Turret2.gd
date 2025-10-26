extends Node2D

@export var bullet_scene: PackedScene
@export var FIRE_RATE: float = 2
@export var DETECTION_RANGE: float = 400

var timer: float = 0.0
var target: Area2D = null

func _process(delta: float) -> void:
	timer += delta
	if timer >= FIRE_RATE:
		timer = 0.0
		find_target()
		if target:
			shoot(target)

func find_target() -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")
	var closest: Node2D = null
	var min_distance: float = DETECTION_RANGE

	for enemy in enemies:
		if enemy and enemy.is_inside_tree():
			var dist = global_position.distance_to(enemy.global_position)
			if dist < min_distance:
				min_distance = dist
				closest = enemy

	target = closest

func shoot(enemy: Node2D) -> void:
	if bullet_scene == null or enemy == null:
		return

	var bullet = bullet_scene.instantiate()
	get_tree().get_root().add_child(bullet)  # thêm thẳng vào root để khỏi lệch toạ độ
	
	bullet.global_position = global_position
	bullet.direction = (enemy.global_position - global_position).normalized()
	look_at(enemy.global_position)
