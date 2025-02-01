extends Enemy

@onready var detection_area: Area2D = %DetectionArea


func _ready() -> void:
	detection_area.body_entered.connect(_on_detection_area_body_entered)
	pass


func _on_detection_area_body_entered(body: Node2D) -> void:
	print( "Enemy_on_body_entered: ",body )
	pass
