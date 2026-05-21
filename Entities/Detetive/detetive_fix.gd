extends CharacterBody2D

@export var speed = 200

#region Variáveis

var can_interact = false
var interactable_object = null
var opened_puzzle = false

#endregion 

func _physics_process(delta):
	
	if opened_puzzle:
		return
		
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
	
	if Input.is_action_just_pressed("ui_accept") and can_interact:
		open_puzzle()
	
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

func open_puzzle():
	if interactable_object:
		opened_puzzle = true
		$AnimatedSprite2D.stop()
		interactable_object.activate_glitch(self)
	
func _on_interactive_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("glitch"):
		can_interact = true
		interactable_object = area.get_parent()
		
func _on_interactive_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("glitch"):
		can_interact = false
		interactable_object = null
		
		
