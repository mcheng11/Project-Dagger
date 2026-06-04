# CharacterA.gd
extends Node2D

var move_speed: float = 200.0
var jump_force: float = 500.0
var double_jump: bool = false
var hitbox_size: Vector2 = Vector2(30, 60)

func use_ability(controller: CharacterBody2D) -> void:
	if not controller.is_on_floor():
		controller.velocity.y = 800.0
		print("USED ABILITY")
