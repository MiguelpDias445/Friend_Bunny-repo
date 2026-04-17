extends CharacterBody2D

@onready var target = $"../Player"

var speed = 30.0
var direction: Vector2 = Vector2.ZERO

var random = RandomNumberGenerator.new()

var wander_direction = Vector2.ZERO
var wander_timer = 0.0

func _ready() -> void:
	random.randomize()

func _physics_process(delta: float) -> void:
	if target and position.distance_squared_to(target.position) < 10000: # 100^2
		direction = (target.position - position).normalized()
	else:
		wander_timer -= delta

		if wander_timer <= 0:
			var new_dir = Vector2(
				random.randf_range(-1, 1),
				random.randf_range(-1, 1)
			)

			wander_direction = new_dir.normalized() if new_dir.length() > 0 else Vector2.RIGHT
			wander_timer = random.randf_range(1.0, 3.0)

		direction = wander_direction

	velocity = direction * speed
	move_and_slide()

	animation()


func animation():
	var sprite = $AnimatedSprite2D

	if direction == Vector2.ZERO:
		return

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			if sprite.animation != "left" or sprite.flip_h:
				sprite.play("left")
				sprite.flip_h = false
		else:
			if sprite.animation != "left" or not sprite.flip_h:
				sprite.play("left")
				sprite.flip_h = true
	else:
		if direction.y > 0:
			if sprite.animation != "down":
				sprite.play("down")
		else:
			if sprite.animation != "up":
				sprite.play("up")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		velocity = Vector2.ZERO
		move_and_slide()

		set_physics_process(false)

		await get_tree().create_timer(0.1).timeout
		get_tree().change_scene_to_file("res://scenes/Death/death.tscn")
