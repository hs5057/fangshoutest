extends Node2D

@onready var enemy_bear: CharacterBody2D = $EnemyBear


func _physics_process(delta: float) -> void:
	enemy_bear.global_position = get_global_mouse_position()
