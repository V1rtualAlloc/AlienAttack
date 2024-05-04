extends CharacterBody2D

signal took_damage

var speed: int = 300

var rocket_scene: PackedScene = preload("res://scenes/rocket.tscn")

@onready var rocket_shot_sound: AudioStreamPlayer = $RocketShotSound

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
		
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	global_position = global_position.clamp(Vector2.ZERO, screen_size)

func shoot():
	var rocket_instance = rocket_scene.instantiate()
	$RocketContainer.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80
	rocket_shot_sound.play()

func take_damage():
	#took_damage.emit()
	emit_signal("took_damage")

func die():
	queue_free()
