extends CharacterBody2D


@onready var throw_origin: Marker2D = $Marker2D
@onready var item_sprite: Sprite2D = $Marker2D/Sprite2D

var gameover: PackedScene = preload("res://levels/gameover.tscn")
#const gameover = preload("uid://cuevp8ji8x6nn")

const SPEED = 100.0

var carry = false
var held_item: ThrowableItem = null

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if carry and event.is_action_pressed("throw"):
		throw_shit()

func pickup_shit(item: ThrowableItem):
	held_item = item
	item_sprite.texture = item.sprite
	carry = true

func throw_shit():
	item_sprite.texture = null
	var projectile = held_item.projectile_scene.instantiate()
	projectile.global_position = throw_origin.global_position
	projectile.initialize((get_global_mouse_position() - global_position).normalized(),held_item)
	get_tree().current_scene.add_child(projectile)
	held_item = null
	carry = false

func _on_area_2d_area_entered(area: Node2D) -> void:
	if area.is_in_group("killplayer"):
		get_tree().change_scene_to_packed(gameover)
		print("AAAAAAAAAAAA")
