# CharacterB.gd
extends Node2D

var move_speed: float = 280.0
var jump_force: float = 450.0
var double_jump: bool = true
var hitbox_size: Vector2 = Vector2(24, 52)

func use_ability(controller: CharacterBody2D) -> void:
	var dir := Input.get_axis("move_left", "move_right")
	controller.velocity.x = dir * 800.0
