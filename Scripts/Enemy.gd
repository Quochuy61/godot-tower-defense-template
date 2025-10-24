extends Area2D

@export var speed: float = 120.0  # tốc độ di chuyển
var path_follow: PathFollow2D = null

func _ready():
	add_to_group("enemy")

func _process(delta: float):
	if path_follow:
		path_follow.progress += speed * delta
		global_position = path_follow.global_position
		# Khi đi hết đường
		if path_follow.progress_ratio >= 1.0:
			get_tree().call_group("base", "take_damage", 1)
			queue_free()
