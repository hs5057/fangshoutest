extends Control

@export var 拥有者: CharacterBody2D
@onready var health_bar: ProgressBar = %HealthBar
@onready var magic_bar: ProgressBar = %MagicBar


func _ready() -> void:
	await owner.ready
	health_bar.value = 拥有者.当前血量值
	magic_bar.value = 拥有者.当前魔法值
	拥有者.血量值变动了.connect(update_health_bar)
	拥有者.魔法值变动了.connect(update_magic_bar)
	update_health_bar()
	pass


func update_health_bar() -> void:
	health_bar.value = 拥有者.当前血量值 * 100 / 拥有者.最大血量值
	pass


func update_magic_bar() -> void:
	magic_bar.value = 拥有者.当前魔法值 * 100 / 拥有者.最大魔法值
	pass
