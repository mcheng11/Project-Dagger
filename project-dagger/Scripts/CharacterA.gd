# CharacterA.gd
extends Node2D

var move_speed: float = 200.0
var jump_force: float = 500.0
var double_jump: bool = false
var hitbox_size: Vector2 = Vector2(30, 60)

@onready var sprite: AnimatedSprite2D = $"."

func use_ability(controller: CharacterBody2D) -> void:
	if not controller.is_on_floor():
		controller.velocity.y = 800.0
		print("USED ABILITY")


# Called every frame by the Player Controller
func update_animation(velocity: Vector2) -> void:
	# Only animate horizontal walking
	if velocity.x != 0:
		sprite.play("walk")

		# Flip when walking left
		sprite.flip_h = velocity.x < 0
	else:
		pass
		# Idle when not moving horizontally
		#sprite.play("walk")
