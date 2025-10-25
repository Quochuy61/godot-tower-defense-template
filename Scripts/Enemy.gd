extends Area2D

@export var health: int = 3
@export var move_speed: float = 100.0
var path_follow: PathFollow2D

func _ready() -> void:
	add_to_group("enemy")

func _process(delta: float) -> void:
	if path_follow:
		path_follow.progress += move_speed * delta
		global_position = path_follow.global_position

		if path_follow.progress_ratio >= 1.0:
			queue_free()

func take_damage() -> void:
	health -= 1
	modulate = Color(1, 0.3, 0.3)
	if health <= 0:
		queue_free()
	else:
		await get_tree().create_timer(0.2).timeout
		modulate = Color(1, 1, 1)
 
