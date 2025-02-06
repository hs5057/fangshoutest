extends StaticBody2D

@onready var detection_area: Area2D = %DetectionArea



func _ready() -> void:
	detection_area.body_entered.connect(_on_detection_area_body_entered)
	detection_area.body_exited.connect(_on_detection_area_body_exited)


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Enemy:
		EnemyDetection.discovered_enemies.append(body)
		EnemyDetection.discovered_enemies_count += 1


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is Enemy:
		EnemyDetection.discovered_enemies.erase(body)
		EnemyDetection.discovered_enemies_count -= 1
