extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack: Area2D = $attack
@onready var attack_collision: CollisionShape2D = $attack/attack_collision
@onready var death_timer: Timer = $death_timer

var alive = true
const SPEED = 100.0
var direction = "down"
var attacking = 0

func _physics_process(delta: float) -> void:
	var joystick = Vector2(0,0)
	if alive:
		joystick.x = Input.get_axis("left", "right")
		joystick.y = Input.get_axis("up", "down")
	elif death_timer.is_stopped():
		attacking = 0
		death_timer.start()
		
	if joystick.length():
		joystick = joystick/joystick.length()
		
	velocity.x = move_toward(velocity.x, SPEED*joystick.x, 25)
	velocity.y = move_toward(velocity.y, SPEED*joystick.y, 25)
	
	if attacking<=0:
		if joystick.y>0:
			direction="down"
		elif joystick.y<0:
			direction="up"
		elif joystick.x>0:
			direction="right"
		elif joystick.x<0:
			direction="left"
	
	
	attacking-=delta
	if Input.is_action_just_pressed("attack") and attacking<-.1 and alive:
		if direction == "right":
			attack.rotation_degrees = 0
		elif direction == "up":
			attack.rotation_degrees = -90
		elif direction == "down":
			attack.rotation_degrees = 90
		elif direction == "left":
			attack.rotation_degrees = 180
		attack_collision.disabled = false
		attacking = .5
	elif attacking<=0:
		attack_collision.disabled = true
	
	if !alive:
		animated_sprite.play("hit_"+direction)
	elif attacking>0:
		animated_sprite.play("attack_"+direction)
		attack_collision.position.y = (attacking/.5) * -22 + 11
	elif joystick.length():
		animated_sprite.play("run_"+direction)
	else:
		animated_sprite.play("idle_"+direction)
	
	move_and_slide()


func _on_death_timer_timeout() -> void:
	get_tree().reload_current_scene()
