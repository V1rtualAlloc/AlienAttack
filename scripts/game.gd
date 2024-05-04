extends Node2D

var lives: int = 3
var score: int = 0

@onready var player: CharacterBody2D = $Player
@onready var hud: Control = $UI/HUD
@onready var ui: CanvasLayer = $UI

@onready var enemy_hit_sound: AudioStreamPlayer = $EnemyHitSound
@onready var player_hit_sound: AudioStreamPlayer = $PlayerHitSound

var gos_scene: PackedScene = preload("res://scenes/game_over_screen.tscn")

func _ready():
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_deathzone_area_entered(area):
	area.queue_free()

func _on_player_took_damage():
	player_hit_sound.play()
	lives -= 1
	hud.set_lives(lives)
	if lives == 0:
		player.die()
		await get_tree().create_timer(1.5).timeout
		var gos = gos_scene.instantiate()
		gos.set_score(score)
		ui.add_child(gos)
		#gos.global_position = Vector2(500, 500)

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)
