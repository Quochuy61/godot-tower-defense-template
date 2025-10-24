extends Area2D

@export var range: float = 200
@export var fire_rate: float = 1.0
@export var bullet_scene: PackedScene

var target: Area2D = null

func _ready():
	$FireTimer.wait_time = fire_rate
	$FireTimer.connect("timeout", Callable(self, "_on_fire_timer_timeout"))
	add_to_group("turret")

func _physics_process(_delta):
	var enemies = get_tree().get_nodes_in_group("enemy")
	var nearest = null
	var nearest_dist = INF
	for e in enemies:
		if not is_instance_valid(e): continue
		var d = global_position.distance_to(e.global_position)
		if d < range and d < nearest_dist:
			nearest = e
			nearest_dist = d
	target = nearest

func _on_fire_timer_timeout():
	if target and is_instance_valid(target):
		fire()

func fire():
	if not bullet_scene: return
	var b = bullet_scene.instantiate()
	b.global_position = global_position
	b.look_at(target.global_position)
	get_tree().current_scene.add_child(b)
