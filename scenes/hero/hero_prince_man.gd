extends Hero

@onready var health_timer: Timer = %HealthTimer
@onready var magic_timer: Timer = %magicTimer


func _ready() -> void:
	health_timer.start()
	magic_timer.start()
	health_timer.timeout.connect(_on_health_timer_timeout)
	magic_timer.timeout.connect(_on_magic_timer_timeout)
	pass


func _on_health_timer_timeout() -> void:
	当前血量值 = clampi( 当前血量值 + 血量恢复, 0, 100 )
	print( "当前血量值：" , 当前血量值 )
	血量值变动了.emit()
	health_timer.start()
	pass


func _on_magic_timer_timeout() -> void:
	当前魔法值 = clampi( 当前魔法值 + 魔法恢复, 0, 100 )
	print( "当前魔法值：",当前魔法值 )
	魔法值变动了.emit()
	magic_timer.start()
	pass
