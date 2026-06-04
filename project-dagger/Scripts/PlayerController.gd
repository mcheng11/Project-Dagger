extends CharacterBody2D

const GRAVITY := 900.0

const CHARACTERS := [
	preload("res://Scenes/CharacterA.tscn"),
	preload("res://Scenes/character_b.tscn"),
]


var current_character: Node2D = null
var current_index: int = 0
var can_jump: bool = false

@onready var character_slot := $CharacterSlot
@onready var collision := $CollisionShape2D

func _ready() -> void:
	swap_to(0)

func swap_to(index: int) -> void:
	if current_character:
		current_character.queue_free()
	current_index = index
	current_character = CHARACTERS[index].instantiate()
	character_slot.add_child(current_character)
	_apply_hitbox(current_character.hitbox_size)
	print("Swapped to character: ", index)  # add this

func _apply_hitbox(size: Vector2) -> void:
	var shape := CapsuleShape2D.new()
	shape.radius = size.x / 2.0
	shape.height = size.y
	collision.shape = shape

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("swap_character"):
		var next := (current_index + 1) % CHARACTERS.size()
		swap_to(next)
	if event.is_action_pressed("ability") and current_character:
		current_character.use_ability(self)

func _physics_process(delta: float) -> void:
	if not current_character:
		return
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		can_jump = true
	var dir := Input.get_axis("move_left", "move_right")
	velocity.x = dir * current_character.move_speed
	if Input.is_action_just_pressed("jump") and can_jump:
		velocity.y = -current_character.jump_force
		can_jump = false
		if current_character.double_jump:
			can_jump = true
	move_and_slide()
