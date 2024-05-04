extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)

var enemy: PackedScene = preload("res://scenes/enemy.tscn")
var path_enemy_scene = preload("res://scenes/path_enemy.tscn")

@onready var spawn_positions = $SpawnPositions

func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var spawn_positions_array: Array = spawn_positions.get_children()
	var random_spawn_position: Marker2D = spawn_positions_array.pick_random()
	
	var enemy_instance: Area2D = enemy.instantiate()
	enemy_instance.global_position = random_spawn_position.global_position
	emit_signal("enemy_spawned", enemy_instance)
	#add_child(enemy_instance)


func _on_path_enemy_timer_timeout():
	spawn_path_enemy()

func spawn_path_enemy():
	var path_enemy_instance = path_enemy_scene.instantiate()
	emit_signal("path_enemy_spawned", path_enemy_instance)
