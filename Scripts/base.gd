extends Node2D

var hp: int = 10

func _ready():
	add_to_group("base")

func take_damage(amount: int):
	hp -= amount
	print("Base HP: ", hp)
	if hp <= 0:
		game_over()

func game_over():
	print("GAME OVER!")
	get_tree().reload_current_scene()
