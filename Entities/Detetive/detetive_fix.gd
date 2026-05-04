extends CharacterBody2D

@export var speed = 200

func _physics_process(delta):
	var input_direction = Vector2.ZERO
	
	if Input.is_action_pressed("walk_up"):
		input_direction.y -= 1
	if Input.is_action_pressed("walk_down"):
		input_direction.y += 1
	if Input.is_action_pressed("walk_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("walk_right"):
		input_direction.x += 1
		
	if input_direction.length() > 0 :
		velocity = input_direction.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.stop()
	
	move_and_slide()
	_update_sprite_direction(input_direction)
	
func _update_sprite_direction(dir):
	if dir.x != 0:
		$AnimatedSprite2D.animation = "walk_side"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = dir.x < 0 
	elif dir.y < 0:
		$AnimatedSprite2D.animation = "walk_up"
	elif dir.y > 0:
		$AnimatedSprite2D.animation = "walk_down"
				
func start(pos):
	global_position = pos
	show()
