extends Node2D

@export var player: Node2D
@export var follow = false
@export var SPEED = 30
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	var move = Vector2(player.global_position-self.global_position)
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
func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
