extends CharacterBody2D

const SPEED = 400.0
const VERTICAL_SPEED = 200.0  # Kecepatan naik/turun
const JUMP_VELOCITY = -900.0  # Anda masih bisa menggunakannya jika perlu

@onready var sprite_2d = $Sprite2D
@onready var spriteStartLine = $"../StartLine/AnimatedSprite2D"
func _physics_process(delta: float) -> void:
	# Animasi
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"

	# Mengendalikan gerakan vertikal
	var vertical_direction := Input.get_axis("up", "down")  # Gantilah "up" dan "down" sesuai input yang Anda gunakan
	if vertical_direction != 0:
		velocity.y = vertical_direction * VERTICAL_SPEED
	else:
		velocity.y = 0  # Tidak ada gerakan vertikal

	# Mengendalikan gerakan horizontal
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

	# Opsional: Anda bisa mengatur animasi terpisah untuk gerakan naik/turun
	if velocity.y != 0:
		sprite_2d.animation = "jumping"  # Misalnya, Anda dapat menggunakan animasi "jumping" untuk naik/turun

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Finish line reached!")
	if body.is_in_group("player"):
		print("Finish line reached!")
		get_tree().change_scene_to_file("res://scenes/finish.tscn")


func _on_start_line_body_entered(body: Node2D) -> void:
	print("start")
	if body.is_in_group("player"):
		spriteStartLine.animation = "moving"
