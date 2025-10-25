extends Area2D

@export var speed: float = 600.0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	add_to_group("bullet")
	connect("area_entered", Callable(self, "_on_area_entered"))
	
	# 🔥 Xoay đạn ngay khi tạo
	if direction != Vector2.ZERO:
		rotation = direction.angle()

func _process(delta: float) -> void:
	global_position += direction * speed * delta
	
	# Xoay trong quá trình bay (nếu cần update động)
	rotation = direction.angle()
	
	# Xoá nếu bay ra khỏi màn
	if global_position.x < -500 or global_position.y < -500 or global_position.x > 3000 or global_position.y > 3000:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.take_damage()
		queue_free()
