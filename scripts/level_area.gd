extends Area2D

@export var camera: Camera2D
@export var limit_left = -100
@export var limit_right = 100
@export var limit_top = -100
@export var limit_bottom = 100



func _on_area_entered(area: Area2D) -> void:
	print("entered area")
	print("limit x:", limit_left, " to ", limit_right)
	print("limit y:", limit_top, " to ", limit_bottom)
	camera.limit_left = limit_left
	camera.limit_right = limit_right
	camera.limit_top = limit_top
	camera.limit_bottom = limit_bottom
