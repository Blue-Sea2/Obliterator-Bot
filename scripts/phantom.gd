extends Node2D

@export var player: Node2D
@export var follower = false
@export var SPEED = 30
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var follow = false

func _process(delta: float) -> void:
	var move = Vector2(player.global_position-self.global_position)
	if follower and move.length()>1 and move.length()<100:
		follow = true
	else:
		follow = false
	if follow:
		move = move*SPEED/move.length()
		position += move*delta
	if move.x>0:
		if follow:
			animated_sprite.play("run_right")
		else:
			animated_sprite.play("idle_right")
	elif move.x<0:
		if follow:
			animated_sprite.play("run_left")
		else:
			animated_sprite.play("idle_left")
			

func _on_hitbox_area_entered(area: Area2D) -> void:
	queue_free()
